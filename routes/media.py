"""
User media uploads (wallpapers) → ilaunching-user-media R2 via media server Worker.
"""

from fastapi import APIRouter, Depends, File, HTTPException, UploadFile, status
from sqlalchemy.ext.asyncio import AsyncSession
import structlog
import uuid

from auth.middleware import get_current_session
from config.database import get_db
from services.user_media import create_user_wallpaper_upload, serialize_user_media

logger = structlog.get_logger()
router = APIRouter()


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
