"""
Dictation ASR + intent helpers.

Provider keys stay on the server. When unset, callers get a clear not-configured signal.
MVP ASR: buffer PCM and run OpenAI Whisper on commit when OPENAI_API_KEY is set.
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
# whisper-1 is the stable transcription model; override only with another audio model.
OPENAI_ASR_MODEL = _env_secret("OPENAI_ASR_MODEL") or "whisper-1"
OPENAI_INTENT_MODEL = _env_secret("OPENAI_INTENT_MODEL") or "gpt-4o-mini"

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
    if not OPENAI_API_KEY:
        raise RuntimeError("not_configured")
    if len(wav_bytes) < 44:
        return ""

    headers = {"Authorization": f"Bearer {OPENAI_API_KEY}"}
    # httpx multipart — do not set Content-Type manually.
    files = {"file": ("speech.wav", io.BytesIO(wav_bytes), "audio/wav")}
    data = {"model": OPENAI_ASR_MODEL, "response_format": "json"}

    try:
        async with httpx.AsyncClient(timeout=90.0) as client:
            response = await client.post(
                "https://api.openai.com/v1/audio/transcriptions",
                headers=headers,
                files=files,
                data=data,
            )
    except httpx.TimeoutException as exc:
        logger.error("whisper_timeout")
        raise ASRProviderError(504, "Speech provider timed out.") from exc
    except httpx.HTTPError as exc:
        logger.error("whisper_http_error", error=str(exc))
        raise ASRProviderError(502, "Could not reach speech provider.") from exc

    if response.status_code >= 400:
        detail = (response.text or "")[:400]
        logger.error(
            "whisper_failed",
            status=response.status_code,
            model=OPENAI_ASR_MODEL,
            detail=detail,
            wav_bytes=len(wav_bytes),
        )
        if response.status_code in (401, 403):
            raise ASRProviderError(
                response.status_code,
                "Speech API key was rejected. Check OPENAI_API_KEY on the server.",
            )
        if response.status_code == 429:
            raise ASRProviderError(429, "Speech provider rate-limited. Try again.")
        raise ASRProviderError(
            response.status_code,
            f"Speech provider error ({response.status_code}).",
        )
    payload = response.json()
    text = (payload.get("text") or "").strip()
    return text


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
) -> dict[str, Any]:
    cleaned_local = light_clean(asr_text)
    if not cleaned_local:
        return {"intent_text": "", "used_fallback": True}

    if not OPENAI_API_KEY:
        return {"intent_text": cleaned_local, "used_fallback": True}

    system = (
        "You rewrite speech-to-text into what the user meant to type in a chat composer. "
        "Strip fillers, apply self-corrections, fix punctuation/casing, keep the user's voice. "
        "Return ONLY the final message text with no quotes or explanation."
    )
    user = (
        f"field_kind: {field_kind}\n"
        f"before: {before_text[:500]}\n"
        f"selected: {selected_text[:200]}\n"
        f"after: {after_text[:500]}\n"
        f"asr: {asr_text}"
    )
    headers = {
        "Authorization": f"Bearer {OPENAI_API_KEY}",
        "Content-Type": "application/json",
    }
    body = {
        "model": OPENAI_INTENT_MODEL,
        "temperature": 0.2,
        "messages": [
            {"role": "system", "content": system},
            {"role": "user", "content": user},
        ],
    }
    try:
        async with httpx.AsyncClient(timeout=30.0) as client:
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
