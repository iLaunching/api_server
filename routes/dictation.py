"""
In-app dictation: short-lived session + WebSocket audio stream + intent format.

Provider keys never leave this service. When GROQ_API_KEY is unset, sessions
report provider_configured=false and the WS fails closed with not_configured.
"""

from __future__ import annotations

import asyncio
import base64
import json
import os
import time
import uuid
from typing import Any, Dict, List

from fastapi import APIRouter, Depends, HTTPException, WebSocket, WebSocketDisconnect
from fastapi.security import HTTPAuthorizationCredentials
from pydantic import BaseModel, Field
import structlog

from auth.middleware import get_current_session
from services.dictation_asr import (
    ASRProviderError,
    format_intent,
    pcm16_to_wav_bytes,
    provider_configured,
    transcribe_wav,
)
from services.groq_dictation import (
    GroqDictationError,
    format_transcript,
    groq_configured,
    transcribe_pcm16,
)

logger = structlog.get_logger()

router = APIRouter(prefix="/dictation", tags=["dictation"])

# In-memory short-lived session registry (single-instance MVP; Redis later if needed).
_SESSIONS: Dict[str, Dict[str, Any]] = {}
_SESSION_TTL_SEC = int(os.getenv("DICTATION_SESSION_TTL_SEC", "120"))


class CreateSessionRequest(BaseModel):
    client_session_id: str | None = None
    field_kind: str = "composer"
    before_text: str = ""
    selected_text: str = ""
    after_text: str = ""


class CreateSessionResponse(BaseModel):
    session_id: str
    expires_at: float
    provider_configured: bool
    sample_rate: int = 16_000


class IntentFormatRequestBody(BaseModel):
    asr_text: str = Field(..., min_length=1)
    before_text: str = ""
    selected_text: str = ""
    after_text: str = ""
    field_kind: str = "composer"


class IntentFormatResponseBody(BaseModel):
    intent_text: str
    used_fallback: bool


class TranscribeRequestBody(BaseModel):
    """One-shot HTTP ASR + optional intent in a single round-trip."""
    pcm16_b64: str = Field(..., min_length=1, description="Little-endian PCM16 mono")
    sample_rate: int = 16_000
    session_id: str | None = None
    include_intent: bool = True
    before_text: str = ""
    selected_text: str = ""
    after_text: str = ""
    field_kind: str = "composer"


class TranscribeResponseBody(BaseModel):
    text: str
    provider_configured: bool
    intent_text: str = ""
    used_fallback: bool = True


def _purge_expired() -> None:
    now = time.time()
    dead = [sid for sid, meta in _SESSIONS.items() if meta.get("expires_at", 0) < now]
    for sid in dead:
        _SESSIONS.pop(sid, None)


@router.post("/sessions", response_model=CreateSessionResponse)
async def create_dictation_session(
    body: CreateSessionRequest,
    current_user: dict = Depends(get_current_session),
):
    """Mint a short-lived dictation session id for the authenticated user."""
    _purge_expired()
    session_id = body.client_session_id or str(uuid.uuid4())
    expires_at = time.time() + _SESSION_TTL_SEC
    user_id = str(current_user.get("user", {}).get("id", ""))
    _SESSIONS[session_id] = {
        "user_id": user_id,
        "expires_at": expires_at,
        "context": {
            "before_text": (body.before_text or "")[-500:],
            "selected_text": (body.selected_text or "")[:200],
            "after_text": (body.after_text or "")[:500],
            "field_kind": body.field_kind or "composer",
        },
    }
    logger.info(
        "dictation_session_created",
        session_id=session_id,
        user_id=user_id,
        provider_configured=groq_configured(),
    )
    return CreateSessionResponse(
        session_id=session_id,
        expires_at=expires_at,
        provider_configured=groq_configured(),
    )


@router.post("/format", response_model=IntentFormatResponseBody)
async def format_dictation_intent(
    body: IntentFormatRequestBody,
    current_user: dict = Depends(get_current_session),
):
    """Meant-to-say formatting over raw ASR."""
    _ = current_user
    result = await format_intent(
        body.asr_text,
        before_text=body.before_text,
        selected_text=body.selected_text,
        after_text=body.after_text,
        field_kind=body.field_kind,
    )
    return IntentFormatResponseBody(
        intent_text=result["intent_text"],
        used_fallback=bool(result["used_fallback"]),
    )


@router.post("/transcribe", response_model=TranscribeResponseBody)
async def transcribe_dictation_audio(
    body: TranscribeRequestBody,
    current_user: dict = Depends(get_current_session),
):
    """
    Buffer-and-commit ASR over HTTPS.

    App records locally, then posts PCM16 once on stop. Avoids WebSocket idle
    timeouts on some Railway / mobile network paths.
    """
    _ = current_user
    if not provider_configured():
        raise HTTPException(
            status_code=503,
            detail="Speech service is not configured yet.",
        )

    try:
        raw = base64.b64decode(body.pcm16_b64)
    except Exception as exc:
        raise HTTPException(status_code=400, detail="Invalid pcm16_b64") from exc

    sample_rate = body.sample_rate if body.sample_rate > 0 else 16_000
    # Cap ~60s @ 16 kHz mono PCM16
    max_bytes = sample_rate * 2 * 60
    if len(raw) > max_bytes:
        raw = raw[:max_bytes]
    # Align to 16-bit frames
    if len(raw) % 2 == 1:
        raw = raw[:-1]
    if len(raw) < sample_rate * 2 // 10:  # < ~100 ms
        raise HTTPException(status_code=400, detail="No speech detected.")

    wav = pcm16_to_wav_bytes(raw, sample_rate=sample_rate)
    try:
        text = await transcribe_wav(wav)
    except ASRProviderError as exc:
        logger.error(
            "dictation_transcribe_failed",
            status=exc.status_code,
            message=exc.message,
            pcm_bytes=len(raw),
            wav_bytes=len(wav),
        )
        # Map provider auth / rate-limit distinctly; everything else stays 502.
        status = 502
        if exc.status_code in (401, 403):
            status = 503
        elif exc.status_code == 429:
            status = 429
        elif exc.status_code == 504:
            status = 504
        raise HTTPException(status_code=status, detail=exc.message) from exc
    except RuntimeError as exc:
        code = str(exc)
        if code == "not_configured":
            raise HTTPException(status_code=503, detail="Speech service is not configured yet.") from exc
        logger.error("dictation_transcribe_failed", error=code)
        raise HTTPException(status_code=502, detail="Speech recognition failed.") from exc

    asr_text = text or ""
    intent_text = asr_text
    used_fallback = True
    if body.include_intent and asr_text:
        # Prefer session context when the client didn't resend field text.
        ctx = {}
        if body.session_id and body.session_id in _SESSIONS:
            ctx = _SESSIONS[body.session_id].get("context") or {}
        formatted = await format_intent(
            asr_text,
            before_text=body.before_text or ctx.get("before_text", ""),
            selected_text=body.selected_text or ctx.get("selected_text", ""),
            after_text=body.after_text or ctx.get("after_text", ""),
            field_kind=body.field_kind or ctx.get("field_kind", "composer"),
        )
        intent_text = formatted.get("intent_text") or asr_text
        used_fallback = bool(formatted.get("used_fallback", True))

    logger.info(
        "dictation_transcribe_ok",
        session_id=body.session_id,
        pcm_bytes=len(raw),
        text_len=len(asr_text),
        intent_len=len(intent_text),
        used_fallback=used_fallback,
    )
    return TranscribeResponseBody(
        text=asr_text,
        provider_configured=True,
        intent_text=intent_text,
        used_fallback=used_fallback,
    )


@router.websocket("/ws/{session_id}")
async def dictation_websocket(websocket: WebSocket, session_id: str):
    """
    Live dictation stream. Audio is PCM16 mono 16 kHz, sent as binary frames.

    Client → server:
      { "type": "start", "format": true, "mode": "dictation" }
      <binary pcm16>
      { "type": "end" }
      { "type": "cancel" }

    Server → client:
      { "type": "ready" }
      { "type": "partial", "text" }
      { "type": "final", "text", "asr_text", "formatted" }
      { "type": "error", "code", "message" }
    """
    await websocket.accept()
    _purge_expired()
    meta = _SESSIONS.get(session_id)
    if not meta or meta.get("expires_at", 0) < time.time():
        await websocket.send_json(
            {
                "type": "error",
                "code": "session_expired",
                "message": "Dictation session expired. Start again.",
            }
        )
        await websocket.close()
        return

    token = websocket.query_params.get("access_token") or websocket.query_params.get("token")
    if not token:
        auth_header = websocket.headers.get("authorization") or ""
        if auth_header.lower().startswith("bearer "):
            token = auth_header[7:].strip()
    if not token:
        await websocket.send_json(
            {"type": "error", "code": "unauthorized", "message": "Missing auth token."}
        )
        await websocket.close()
        return
    try:
        session = await get_current_session(
            HTTPAuthorizationCredentials(scheme="Bearer", credentials=token)
        )
        user_id = str(session.get("user", {}).get("id", ""))
        if meta.get("user_id") and user_id and meta["user_id"] != user_id:
            await websocket.send_json(
                {"type": "error", "code": "unauthorized", "message": "Session owner mismatch."}
            )
            await websocket.close()
            return
    except Exception:
        await websocket.send_json(
            {"type": "error", "code": "unauthorized", "message": "Invalid or expired token."}
        )
        await websocket.close()
        return

    if not groq_configured():
        await websocket.send_json(
            {
                "type": "error",
                "code": "not_configured",
                "message": "Speech service is not configured yet.",
            }
        )
        await websocket.close()
        _SESSIONS.pop(session_id, None)
        return

    await websocket.send_json(
        {"type": "ready", "provider_configured": True, "session_id": session_id}
    )

    pcm = bytearray()
    format_on = True
    started = False
    closed = False
    last_partial_at = 0
    partial_lock_held = False

    async def emit_partial(snapshot: bytes) -> None:
        nonlocal last_partial_at, partial_lock_held
        if closed or partial_lock_held or len(snapshot) < 16_000:
            return
        partial_lock_held = True
        try:
            text = await transcribe_pcm16(snapshot)
        except GroqDictationError as exc:
            logger.warning("dictation_partial_failed", status=exc.status_code)
            return
        finally:
            partial_lock_held = False
        if closed or not text:
            return
        try:
            await websocket.send_json({"type": "partial", "text": text})
        except Exception:
            return

    try:
        while True:
            message = await websocket.receive()
            if message.get("type") == "websocket.disconnect":
                break
            raw_bytes = message.get("bytes")
            if raw_bytes:
                if not started:
                    continue
                room = max(0, 16_000 * 2 * 60 - len(pcm))
                if room:
                    pcm.extend(raw_bytes[:room])
                meta["expires_at"] = time.time() + _SESSION_TTL_SEC
                # Free-tier Whisper is ~20 RPM. One partial every ~4s leaves room for Stop.
                if len(pcm) - last_partial_at >= 16_000 * 2 * 4 and not partial_lock_held:
                    last_partial_at = len(pcm)
                    asyncio.create_task(emit_partial(bytes(pcm)))
                continue
            raw_text = message.get("text")
            if not raw_text:
                continue
            try:
                payload = json.loads(raw_text)
            except json.JSONDecodeError:
                continue
            kind = payload.get("type")
            if kind == "start":
                started = True
                format_on = bool(payload.get("format", True))
                continue
            if kind == "cancel":
                closed = True
                await websocket.send_json({"type": "cancelled"})
                break
            if kind == "end":
                closed = True
                while partial_lock_held:
                    await asyncio.sleep(0.05)
                if len(pcm) < 16_000 * 2 // 10:
                    await websocket.send_json(
                        {
                            "type": "error",
                            "code": "empty_audio",
                            "message": "No speech detected.",
                        }
                    )
                    break
                try:
                    asr_text = await transcribe_pcm16(
                        bytes(pcm),
                        retry_rate_limits=True,
                    )
                except GroqDictationError as exc:
                    await websocket.send_json(
                        {
                            "type": "error",
                            "code": "asr_failed",
                            "message": exc.message,
                        }
                    )
                    break
                formatted = False
                final_text = asr_text
                if format_on and asr_text:
                    ctx = meta.get("context") or {}
                    rewritten = await format_transcript(
                        asr_text,
                        before_text=ctx.get("before_text", ""),
                    )
                    if rewritten:
                        final_text = rewritten
                        formatted = True
                await websocket.send_json(
                    {
                        "type": "final",
                        "text": final_text,
                        "asr_text": asr_text,
                        "formatted": formatted,
                    }
                )
                break
    except WebSocketDisconnect:
        logger.info("dictation_ws_disconnected", session_id=session_id)
    finally:
        closed = True
        _SESSIONS.pop(session_id, None)
