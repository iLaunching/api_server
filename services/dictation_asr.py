"""
Dictation ASR + intent helpers.

Provider keys stay on the server. When unset, callers get a clear not-configured signal.
MVP ASR: buffer PCM and run OpenAI file transcription on commit when OPENAI_API_KEY is set.
Default model is `gpt-transcribe` (whisper-1 / gpt-4o-*-transcribe are deprecated).
Intent: small chat completion when key set; otherwise local light-clean fallback.
"""

from __future__ import annotations

import io
import os
import re
import struct
import wave
from typing import Any

import httpx
import structlog

logger = structlog.get_logger()

def _env_secret(name: str) -> str:
    raw = os.getenv(name, "") or ""
    return raw.strip().strip('"').strip("'")


OPENAI_API_KEY = _env_secret("OPENAI_API_KEY")
# File / buffer-and-commit path — OpenAI recommends gpt-transcribe over deprecated whisper-1.
OPENAI_ASR_MODEL = _env_secret("OPENAI_ASR_MODEL") or "gpt-transcribe"
OPENAI_INTENT_MODEL = _env_secret("OPENAI_INTENT_MODEL") or "gpt-4o-mini"
# local = instant light-clean only; cloud = OpenAI format with short timeout + local fallback.
DICTATION_INTENT_MODE = (_env_secret("DICTATION_INTENT_MODE") or "cloud").lower()
INTENT_TIMEOUT_SEC = float(os.getenv("DICTATION_INTENT_TIMEOUT_SEC", "8") or "8")

_FILLERS = {"um", "uh", "erm", "ah", "like", "you know", "i mean"}


def provider_configured() -> bool:
    return bool(OPENAI_API_KEY)


def pcm16_to_wav_bytes(pcm16: bytes, sample_rate: int = 16_000) -> bytes:
    """Wrap little-endian mono PCM16 as a WAV container for Whisper."""
    buf = io.BytesIO()
    with wave.open(buf, "wb") as wf:
        wf.setnchannels(1)
        wf.setsampwidth(2)
        wf.setframerate(sample_rate)
        wf.writeframes(pcm16)
    return buf.getvalue()


def floats_to_wav_bytes(samples: list[float], sample_rate: int = 16_000) -> bytes:
    """Encode mono float PCM (~±1) as 16-bit WAV for Whisper upload."""
    pcm = bytearray(len(samples) * 2)
    for i, sample in enumerate(samples):
        clipped = max(-1.0, min(1.0, float(sample)))
        struct.pack_into("<h", pcm, i * 2, int(clipped * 32767.0))
    return pcm16_to_wav_bytes(bytes(pcm), sample_rate=sample_rate)


class ASRProviderError(RuntimeError):
    def __init__(self, status_code: int, message: str):
        self.status_code = status_code
        self.message = message
        super().__init__(f"asr_provider_error:{status_code}")


async def transcribe_wav(wav_bytes: bytes) -> str:
    import asyncio

    if not OPENAI_API_KEY:
        raise RuntimeError("not_configured")
    if len(wav_bytes) < 44:
        return ""

    headers = {"Authorization": f"Bearer {OPENAI_API_KEY}"}
    data = {"model": OPENAI_ASR_MODEL, "response_format": "json"}
    # Brief retries — free/low-tier Whisper often returns 429 under burst traffic.
    max_attempts = 4
    last_detail = ""

    async with httpx.AsyncClient(timeout=90.0) as client:
        for attempt in range(max_attempts):
            # BytesIO must be recreated each attempt (stream is consumed).
            files = {"file": ("speech.wav", io.BytesIO(wav_bytes), "audio/wav")}
            try:
                response = await client.post(
                    "https://api.openai.com/v1/audio/transcriptions",
                    headers=headers,
                    files=files,
                    data=data,
                )
            except httpx.TimeoutException as exc:
                logger.error("whisper_timeout", attempt=attempt + 1)
                raise ASRProviderError(504, "Speech provider timed out.") from exc
            except httpx.HTTPError as exc:
                logger.error("whisper_http_error", error=str(exc), attempt=attempt + 1)
                raise ASRProviderError(502, "Could not reach speech provider.") from exc

            if response.status_code < 400:
                payload = response.json()
                return (payload.get("text") or "").strip()

            last_detail = (response.text or "")[:400]
            logger.error(
                "whisper_failed",
                status=response.status_code,
                model=OPENAI_ASR_MODEL,
                detail=last_detail,
                wav_bytes=len(wav_bytes),
                attempt=attempt + 1,
            )

            if response.status_code in (401, 403):
                raise ASRProviderError(
                    response.status_code,
                    "Speech API key was rejected. Check OPENAI_API_KEY on the server.",
                )

            if response.status_code == 429 and attempt + 1 < max_attempts:
                retry_after = response.headers.get("retry-after")
                try:
                    delay = float(retry_after) if retry_after else (1.5 * (2**attempt))
                except ValueError:
                    delay = 1.5 * (2**attempt)
                delay = min(max(delay, 0.5), 12.0)
                logger.warning("whisper_rate_limited_retry", delay=delay, attempt=attempt + 1)
                await asyncio.sleep(delay)
                continue

            if response.status_code == 429:
                raise ASRProviderError(
                    429,
                    "Speech provider rate-limited. Wait a few seconds and try again "
                    "(check OpenAI usage / tier limits).",
                )

            raise ASRProviderError(
                response.status_code,
                f"Speech provider error ({response.status_code}).",
            )

    raise ASRProviderError(429, "Speech provider rate-limited. Try again.")


def light_clean(raw: str) -> str:
    tokens = [t for t in re.split(r"\s+", (raw or "").strip()) if t]
    tokens = [
        t
        for t in tokens
        if t.lower().strip(".,!?;:") not in _FILLERS
    ]
    # “... X no Y …” → drop X and “no”, keep Y (self-correction of the prior word).
    i = 0
    rewritten: list[str] = []
    while i < len(tokens):
        bare = tokens[i].lower().strip(".,!?;:")
        if (
            bare == "no"
            and rewritten
            and i + 1 < len(tokens)
        ):
            rewritten.pop()
            rewritten.append(tokens[i + 1])
            i += 2
            continue
        rewritten.append(tokens[i])
        i += 1
    tokens = rewritten
    text = " ".join(tokens).strip()
    if not text:
        return ""
    text = text[0].upper() + text[1:]
    if text[-1] not in ".!?":
        text += "."
    return text


async def format_intent(
    asr_text: str,
    *,
    before_text: str = "",
    selected_text: str = "",
    after_text: str = "",
    field_kind: str = "composer",
    force_local: bool = False,
) -> dict[str, Any]:
    cleaned_local = light_clean(asr_text)
    if not cleaned_local:
        return {"intent_text": "", "used_fallback": True}

    use_cloud = (
        not force_local
        and DICTATION_INTENT_MODE not in ("local", "off", "none")
        and bool(OPENAI_API_KEY)
    )
    if not use_cloud:
        return {"intent_text": cleaned_local, "used_fallback": True}

    system = (
        "Rewrite ASR into the chat message the user meant. "
        "Strip fillers, apply self-corrections, fix punctuation. "
        "Reply with ONLY the message text."
    )
    # Keep context tight — less tokens = faster.
    user = (
        f"before:{before_text[-200:]}\n"
        f"asr:{asr_text}"
    )
    headers = {
        "Authorization": f"Bearer {OPENAI_API_KEY}",
        "Content-Type": "application/json",
    }
    body = {
        "model": OPENAI_INTENT_MODEL,
        "temperature": 0.1,
        "max_tokens": 120,
        "messages": [
            {"role": "system", "content": system},
            {"role": "user", "content": user},
        ],
    }
    try:
        async with httpx.AsyncClient(timeout=INTENT_TIMEOUT_SEC) as client:
            response = await client.post(
                "https://api.openai.com/v1/chat/completions",
                headers=headers,
                json=body,
            )
        if response.status_code >= 400:
            logger.warning("intent_provider_failed", status=response.status_code)
            return {"intent_text": cleaned_local, "used_fallback": True}
        data = response.json()
        text = (
            data.get("choices", [{}])[0]
            .get("message", {})
            .get("content", "")
            .strip()
        )
        if not text:
            return {"intent_text": cleaned_local, "used_fallback": True}
        return {"intent_text": text, "used_fallback": False}
    except Exception as exc:
        logger.warning("intent_provider_exception", error=str(exc))
        return {"intent_text": cleaned_local, "used_fallback": True}
