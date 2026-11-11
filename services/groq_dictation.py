"""
Groq dictation: one key for speech and cleanup.

Audio goes to whisper-large-v3-turbo. When formatting is on, the transcript
text (not the audio) goes to gpt-oss-20b. The phone still sees one stream.
"""

from __future__ import annotations

import asyncio
import os
import re

import httpx
import structlog

from services.dictation_asr import pcm16_to_wav_bytes

logger = structlog.get_logger()


def _env_secret(name: str) -> str:
    raw = os.getenv(name, "") or ""
    return raw.strip().strip('"').strip("'")


GROQ_API_KEY = _env_secret("GROQ_API_KEY")
GROQ_BASE_URL = (
    _env_secret("GROQ_BASE_URL") or "https://api.groq.com/openai/v1"
).rstrip("/")
GROQ_ASR_MODEL = _env_secret("GROQ_ASR_MODEL") or "whisper-large-v3-turbo"
GROQ_ASR_LANGUAGE = _env_secret("GROQ_ASR_LANGUAGE") or "en"
GROQ_FORMAT_MODEL = _env_secret("GROQ_FORMAT_MODEL") or "openai/gpt-oss-20b"

_RETRY_AFTER_RE = re.compile(r"try again in\s+(\d+(?:\.\d+)?)\s*s", re.IGNORECASE)


class GroqDictationError(RuntimeError):
    def __init__(self, status_code: int, message: str):
        self.status_code = status_code
        self.message = message
        super().__init__(message)


def groq_configured() -> bool:
    return bool(GROQ_API_KEY)


def _retry_after_seconds(detail: str, fallback: float = 3.0) -> float:
    match = _RETRY_AFTER_RE.search(detail or "")
    if not match:
        return fallback
    try:
        return max(0.5, min(15.0, float(match.group(1))))
    except ValueError:
        return fallback


async def transcribe_pcm16(
    pcm16: bytes,
    sample_rate: int = 16_000,
    *,
    retry_rate_limits: bool = False,
) -> str:
    if not GROQ_API_KEY:
        raise GroqDictationError(503, "Speech service is not configured yet.")
    if len(pcm16) < sample_rate * 2 // 10:
        return ""
    wav = pcm16_to_wav_bytes(pcm16, sample_rate=sample_rate)
    headers = {"Authorization": f"Bearer {GROQ_API_KEY}"}
    data = {
        "model": GROQ_ASR_MODEL,
        "response_format": "json",
        "temperature": "0",
    }
    if GROQ_ASR_LANGUAGE:
        data["language"] = GROQ_ASR_LANGUAGE

    attempts = 4 if retry_rate_limits else 1
    last_error: GroqDictationError | None = None
    async with httpx.AsyncClient(timeout=45.0) as client:
        for attempt in range(attempts):
            try:
                response = await client.post(
                    f"{GROQ_BASE_URL}/audio/transcriptions",
                    headers=headers,
                    files={"file": ("speech.wav", wav, "audio/wav")},
                    data=data,
                )
            except httpx.TimeoutException as exc:
                raise GroqDictationError(504, "Speech provider timed out.") from exc
            except httpx.HTTPError as exc:
                raise GroqDictationError(502, "Could not reach speech provider.") from exc
            if response.status_code < 400:
                payload = response.json()
                return (payload.get("text") or "").strip()
            detail = (response.text or "")[:240]
            logger.warning(
                "groq_asr_failed",
                status=response.status_code,
                model=GROQ_ASR_MODEL,
                detail=detail,
                attempt=attempt + 1,
            )
            last_error = GroqDictationError(
                response.status_code,
                f"Speech provider error ({response.status_code}).",
            )
            if response.status_code == 429 and attempt + 1 < attempts:
                await asyncio.sleep(_retry_after_seconds(detail))
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
    if not GROQ_API_KEY or not asr_text.strip():
        return ""
    system = (
        "Rewrite ASR into the chat message the user meant. "
        "Strip fillers, apply self-corrections, fix punctuation. "
        "Reply with ONLY the message text."
    )
    user = f"before:{before_text[-200:]}\nasr:{asr_text}"
    body = {
        "model": GROQ_FORMAT_MODEL,
        "temperature": 0.1,
        "max_tokens": 120,
        "reasoning_effort": "low",
        "messages": [
            {"role": "system", "content": system},
            {"role": "user", "content": user},
        ],
    }
    headers = {
        "Authorization": f"Bearer {GROQ_API_KEY}",
        "Content-Type": "application/json",
    }
    try:
        async with httpx.AsyncClient(timeout=8.0) as client:
            response = await client.post(
                f"{GROQ_BASE_URL}/chat/completions",
                headers=headers,
                json=body,
            )
    except Exception as exc:
        logger.warning("groq_format_failed", error=str(exc))
        return ""
    if response.status_code >= 400:
        logger.warning(
            "groq_format_failed",
            status=response.status_code,
            detail=(response.text or "")[:240],
        )
        return ""
    data = response.json()
    text = (
        data.get("choices", [{}])[0]
        .get("message", {})
        .get("content", "")
        .strip()
    )
    return text
