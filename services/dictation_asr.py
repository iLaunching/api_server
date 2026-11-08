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
from typing import Any, Optional

import httpx
import structlog

logger = structlog.get_logger()

OPENAI_API_KEY = os.getenv("OPENAI_API_KEY", "").strip()
OPENAI_ASR_MODEL = os.getenv("OPENAI_ASR_MODEL", "whisper-1").strip() or "whisper-1"
OPENAI_INTENT_MODEL = os.getenv("OPENAI_INTENT_MODEL", "gpt-4o-mini").strip() or "gpt-4o-mini"

_FILLERS = {"um", "uh", "erm", "ah", "like", "you know", "i mean"}


def provider_configured() -> bool:
    return bool(OPENAI_API_KEY)


def floats_to_wav_bytes(samples: list[float], sample_rate: int = 16_000) -> bytes:
    """Encode mono float PCM (~±1) as 16-bit WAV for Whisper upload."""
    clipped = [max(-1.0, min(1.0, float(s))) for s in samples]
    pcm = b"".join(struct.pack("<h", int(v * 32767.0)) for v in clipped)
    buf = io.BytesIO()
    with wave.open(buf, "wb") as wf:
        wf.setnchannels(1)
        wf.setsampwidth(2)
        wf.setframerate(sample_rate)
        wf.writeframes(pcm)
    return buf.getvalue()


async def transcribe_wav(wav_bytes: bytes) -> str:
    if not OPENAI_API_KEY:
        raise RuntimeError("not_configured")
    if len(wav_bytes) < 44:
        return ""

    headers = {"Authorization": f"Bearer {OPENAI_API_KEY}"}
    files = {"file": ("speech.wav", wav_bytes, "audio/wav")}
    data = {"model": OPENAI_ASR_MODEL, "response_format": "json"}

    async with httpx.AsyncClient(timeout=60.0) as client:
        response = await client.post(
            "https://api.openai.com/v1/audio/transcriptions",
            headers=headers,
            files=files,
            data=data,
        )
    if response.status_code >= 400:
        logger.error("whisper_failed", status=response.status_code)
        raise RuntimeError(f"asr_provider_error:{response.status_code}")
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
