"""
Fireworks dictation: streaming-shaped audio in, one transcript out.

Audio goes to whisper-v3-turbo. When formatting is on, the transcript text
(not the audio) goes to Llama 3.2 3B. The phone still sees one stream.
"""

from __future__ import annotations

import os

import httpx
import structlog

from services.dictation_asr import pcm16_to_wav_bytes

logger = structlog.get_logger()


def _env_secret(name: str) -> str:
    raw = os.getenv(name, "") or ""
    return raw.strip().strip('"').strip("'")


FIREWORKS_API_KEY = _env_secret("FIREWORKS_API_KEY")
# audio-turbo has no healthy upstream (503 before auth). audio-prod still serves whisper-v3.
FIREWORKS_ASR_BASE_URL = (
    _env_secret("FIREWORKS_ASR_BASE_URL")
    or "https://audio-prod.us-virginia-1.direct.fireworks.ai/v1"
).rstrip("/")
FIREWORKS_ASR_MODEL = _env_secret("FIREWORKS_ASR_MODEL") or "whisper-v3"
_ASR_FALLBACK = (
    "https://audio-prod.us-virginia-1.direct.fireworks.ai/v1",
    "whisper-v3",
)
FIREWORKS_CHAT_URL = (
    _env_secret("FIREWORKS_CHAT_URL")
    or "https://api.fireworks.ai/inference/v1/chat/completions"
)
FIREWORKS_FORMAT_MODEL = (
    _env_secret("FIREWORKS_FORMAT_MODEL")
    or "accounts/fireworks/models/llama-v3p2-3b-instruct"
)


class FireworksDictationError(RuntimeError):
    def __init__(self, status_code: int, message: str):
        self.status_code = status_code
        self.message = message
        super().__init__(message)


def fireworks_configured() -> bool:
    return bool(FIREWORKS_API_KEY)


async def transcribe_pcm16(pcm16: bytes, sample_rate: int = 16_000) -> str:
    if not FIREWORKS_API_KEY:
        raise FireworksDictationError(503, "Speech service is not configured yet.")
    if len(pcm16) < sample_rate * 2 // 10:
        return ""
    wav = pcm16_to_wav_bytes(pcm16, sample_rate=sample_rate)
    headers = {"Authorization": f"Bearer {FIREWORKS_API_KEY}"}
    attempts = [(FIREWORKS_ASR_BASE_URL, FIREWORKS_ASR_MODEL)]
    if (FIREWORKS_ASR_BASE_URL, FIREWORKS_ASR_MODEL) != _ASR_FALLBACK:
        attempts.append(_ASR_FALLBACK)

    last_error: FireworksDictationError | None = None
    async with httpx.AsyncClient(timeout=45.0) as client:
        for base_url, model in attempts:
            try:
                response = await client.post(
                    f"{base_url}/audio/transcriptions",
                    headers=headers,
                    files={"file": ("speech.wav", wav, "audio/wav")},
                    data={"model": model, "response_format": "json", "temperature": "0"},
                )
            except httpx.TimeoutException as exc:
                raise FireworksDictationError(504, "Speech provider timed out.") from exc
            except httpx.HTTPError as exc:
                raise FireworksDictationError(502, "Could not reach speech provider.") from exc
            if response.status_code < 400:
                payload = response.json()
                return (payload.get("text") or "").strip()
            detail = (response.text or "")[:240]
            logger.warning(
                "fireworks_asr_failed",
                status=response.status_code,
                model=model,
                detail=detail,
            )
            last_error = FireworksDictationError(
                response.status_code,
                f"Speech provider error ({response.status_code}).",
            )
            # Turbo's pool is empty. Try the full Whisper host once.
            if response.status_code == 503 and model != _ASR_FALLBACK[1]:
                continue
            raise last_error
    if last_error:
        raise last_error
    return ""


async def format_transcript(
    asr_text: str,
    *,
    before_text: str = "",
) -> str:
    """Rewrite the transcript. Returns "" when the call fails so the caller can keep raw text."""
    if not FIREWORKS_API_KEY or not asr_text.strip():
        return ""
    system = (
        "Rewrite ASR into the chat message the user meant. "
        "Strip fillers, apply self-corrections, fix punctuation. "
        "Reply with ONLY the message text."
    )
    user = f"before:{before_text[-200:]}\nasr:{asr_text}"
    body = {
        "model": FIREWORKS_FORMAT_MODEL,
        "temperature": 0.1,
        "max_tokens": 120,
        "messages": [
            {"role": "system", "content": system},
            {"role": "user", "content": user},
        ],
    }
    headers = {
        "Authorization": f"Bearer {FIREWORKS_API_KEY}",
        "Content-Type": "application/json",
    }
    try:
        async with httpx.AsyncClient(timeout=8.0) as client:
            response = await client.post(FIREWORKS_CHAT_URL, headers=headers, json=body)
    except Exception as exc:
        logger.warning("fireworks_format_failed", error=str(exc))
        return ""
    if response.status_code >= 400:
        logger.warning("fireworks_format_failed", status=response.status_code)
        return ""
    data = response.json()
    text = (
        data.get("choices", [{}])[0]
        .get("message", {})
        .get("content", "")
        .strip()
    )
    return text
