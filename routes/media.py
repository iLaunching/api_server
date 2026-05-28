"""
User media uploads (wallpapers) → ilaunching-user-media R2 via media server Worker.
"""

from fastapi import APIRouter, Depends, File, Form, HTTPException, UploadFile, status
from sqlalchemy.ext.asyncio import AsyncSession
import structlog
import uuid

from auth.middleware import get_current_session
from config.database import get_db
from config.media_settings import media_upload_status
from services.synaptic_background_payload import build_synaptic_expressive_background_payload
from services.user_media import (
    apply_user_wallpaper_to_synaptic_background,
    create_user_wallpaper_upload,
    serialize_user_media,
)

logger = structlog.get_logger()
router = APIRouter()


@router.get("/media/upload-status")
async def get_media_upload_status():
    """
    Ops check: confirms Railway has Worker URL + ingest secret (does not call Worker).
    """
    status = media_upload_status()
    return {
        "ok": status["configured"],
        **status,
        "hint": (
            "Set MEDIA_WORKER_URL and MEDIA_INGEST_SECRET on Railway api-server; "
            "set INGEST_SECRET to the same value on the Cloudflare Worker."
        ),
    }


@router.post("/users/me/media/wallpapers")
async def upload_user_wallpaper(
    file: UploadFile = File(...),
    session: dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db),
):
    user_id = session.get("user_id")
    if not user_id:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="User ID not found in session",
        )

    content_type = (file.content_type or "").split(";")[0].strip().lower()
    body = await file.read()
    if not body:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Empty file")

    try:
        row = await create_user_wallpaper_upload(
            db,
            uuid.UUID(str(user_id)),
            body,
            content_type or "application/octet-stream",
        )
    except ValueError as exc:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(exc),
        ) from exc
    except RuntimeError as exc:
        logger.error("user_wallpaper_upload_not_configured", error=str(exc))
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail="Media upload is not configured on the server",
        ) from exc
    except Exception as exc:
        logger.exception("user_wallpaper_upload_failed")
        raise HTTPException(
            status_code=status.HTTP_502_BAD_GATEWAY,
            detail="Failed to store wallpaper in media server",
        ) from exc

    return {
        "message": "Wallpaper uploaded",
        "media": serialize_user_media(row),
    }


@router.post("/users/me/media/wallpapers/apply-to-background")
async def apply_user_wallpaper_to_background(
    file: UploadFile = File(...),
    pan_x: float = Form(0),
    pan_y: float = Form(0),
    dim_opacity: float = Form(0),
    session: dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db),
):
    """
    Upload a user wallpaper and persist it on synapticExpressiveBackground in one request.
    iOS device-library Set uses this so R2, user_media, and synaptic row stay in sync.
    """
    user_id = session.get("user_id")
    if not user_id:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="User ID not found in session",
        )

    content_type = (file.content_type or "").split(";")[0].strip().lower()
    body = await file.read()
    if not body:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Empty file")

    uid = uuid.UUID(str(user_id))
    try:
        row, bg = await apply_user_wallpaper_to_synaptic_background(
            db,
            uid,
            body,
            content_type or "application/octet-stream",
            pan_x=pan_x,
            pan_y=pan_y,
            dim_opacity=dim_opacity,
        )
    except ValueError as exc:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(exc),
        ) from exc
    except RuntimeError as exc:
        logger.error("user_wallpaper_apply_not_configured", error=str(exc))
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail="Media upload is not configured on the server",
        ) from exc
    except HTTPException:
        raise
    except Exception as exc:
        await db.rollback()
        logger.exception("user_wallpaper_apply_to_background_failed")
        raise HTTPException(
            status_code=status.HTTP_502_BAD_GATEWAY,
            detail="Failed to apply wallpaper to background",
        ) from exc

    synaptic_payload = await build_synaptic_expressive_background_payload(db, bg, user_id=uid)
    logger.info(
        "user_wallpaper_applied_to_synaptic_background",
        user_id=str(user_id),
        user_media_id=str(row.id),
        synaptic_id=bg.id,
        active_chat_id=bg.active_chat_id,
        pan_x=bg.pan_x,
        pan_y=bg.pan_y,
    )
    return {
        "message": "Wallpaper applied to synaptic expressive background",
        "media": serialize_user_media(row),
        "synaptic_expressive_background": synaptic_payload,
    }
