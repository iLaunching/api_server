"""
In-app dictation: short-lived session + WebSocket audio stream + intent format.

Provider keys never leave this service. When OPENAI_API_KEY is unset, sessions
report provider_configured=false and the WS fails closed with not_configured.
"""

from __future__ import annotations

import base64
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
    floats_to_wav_bytes,
    format_intent,
    pcm16_to_wav_bytes,
    provider_configured,
    transcribe_wav,
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
    """One-shot HTTP ASR (preferred over WebSocket for Railway reliability)."""
    pcm16_b64: str = Field(..., min_length=1, description="Little-endian PCM16 mono")
    sample_rate: int = 16_000
    session_id: str | None = None


class TranscribeResponseBody(BaseModel):
    text: str
    provider_configured: bool


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
        provider_configured=provider_configured(),
    )
    return CreateSessionResponse(
        session_id=session_id,
        expires_at=expires_at,
        provider_configured=provider_configured(),
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

    logger.info(
        "dictation_transcribe_ok",
        session_id=body.session_id,
        pcm_bytes=len(raw),
        text_len=len(text or ""),
    )
    return TranscribeResponseBody(text=text or "", provider_configured=True)


@router.websocket("/ws/{session_id}")
async def dictation_websocket(websocket: WebSocket, session_id: str):
    """
    Bidirectional dictation stream.

    Client → server:
      { "type": "auth", "token": "<jwt>" }   (first message if not already validated)
      { "type": "audio", "samples": [f32, ...] }  or  { "type": "audio_b64", "pcm16_b64": "..." }
      { "type": "commit" }
      { "type": "cancel" }

    Server → client:
      { "type": "ready", "provider_configured": bool }
      { "type": "partial", "text": "..." }
      { "type": "final", "text": "..." }
      { "type": "error", "code": "...", "message": "..." }
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

    # Auth: prefer Authorization header / query; else first auth message.
    token = websocket.query_params.get("access_token") or websocket.query_params.get("token")
    if not token:
        auth_header = websocket.headers.get("authorization") or ""
        if auth_header.lower().startswith("bearer "):
            token = auth_header[7:].strip()

    if not token:
        try:
            first = await websocket.receive_json()
        except WebSocketDisconnect:
            return
        if first.get("type") != "auth" or not first.get("token"):
            await websocket.send_json(
                {
                    "type": "error",
                    "code": "unauthorized",
                    "message": "Missing auth token.",
                }
            )
            await websocket.close()
            return
        token = str(first["token"])

    try:
        session = await get_current_session(
            HTTPAuthorizationCredentials(scheme="Bearer", credentials=token)
        )
        user_id = str(session.get("user", {}).get("id", ""))
        if meta.get("user_id") and user_id and meta["user_id"] != user_id:
            await websocket.send_json(
                {
                    "type": "error",
                    "code": "unauthorized",
                    "message": "Session owner mismatch.",
                }
            )
            await websocket.close()
            return
    except HTTPException:
        await websocket.send_json(
            {
                "type": "error",
                "code": "unauthorized",
                "message": "Invalid or expired token.",
            }
        )
        await websocket.close()
        return
    except Exception as exc:
        logger.warning("dictation_ws_auth_failed", error=str(exc))
        await websocket.send_json(
            {
                "type": "error",
                "code": "unauthorized",
                "message": "Auth failed.",
            }
        )
        await websocket.close()
        return

    configured = provider_configured()
    await websocket.send_json(
        {"type": "ready", "provider_configured": configured, "session_id": session_id}
    )
    if not configured:
        await websocket.send_json(
            {
                "type": "error",
                "code": "not_configured",
                "message": "Speech service is not configured yet.",
            }
        )
        # Keep socket briefly so client can read the error, then close.
        await websocket.close()
        _SESSIONS.pop(session_id, None)
        return

    samples: List[float] = []
    try:
        while True:
            message = await websocket.receive_json()
            msg_type = message.get("type")
            if msg_type == "cancel":
                samples.clear()
                await websocket.send_json({"type": "cancelled"})
                break
            if msg_type == "audio":
                chunk = message.get("samples") or []
                if isinstance(chunk, list) and chunk:
                    # Cap buffer (~60s @ 16kHz)
                    room = max(0, 16_000 * 60 - len(samples))
                    if room:
                        samples.extend(float(x) for x in chunk[:room])
                continue
            if msg_type == "audio_b64":
                # Optional: PCM16 LE little-endian mono @ 16 kHz
                raw = base64.b64decode(message.get("pcm16_b64") or "")
                if raw:
                    import struct as _struct

                    count = len(raw) // 2
                    room = max(0, 16_000 * 60 - len(samples))
                    take = min(count, room)
                    for i in range(take):
                        (v,) = _struct.unpack_from("<h", raw, i * 2)
                        samples.append(v / 32767.0)
                continue
            if msg_type == "commit":
                if len(samples) < 1600:  # < ~100 ms
                    await websocket.send_json(
                        {
                            "type": "error",
                            "code": "empty_audio",
                            "message": "No speech detected.",
                        }
                    )
                    break
                wav = floats_to_wav_bytes(samples, sample_rate=16_000)
                try:
                    text = await transcribe_wav(wav)
                except RuntimeError as exc:
                    code = str(exc)
                    await websocket.send_json(
                        {
                            "type": "error",
                            "code": "asr_failed" if "provider" in code else code,
                            "message": "Speech recognition failed.",
                        }
                    )
                    break
                await websocket.send_json(
                    {"type": "final", "text": text or "", "is_final": True}
                )
                break
            # ignore unknown
    except WebSocketDisconnect:
        logger.info("dictation_ws_disconnected", session_id=session_id)
    finally:
        _SESSIONS.pop(session_id, None)
