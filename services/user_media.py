"""Create and resolve user-owned wallpaper uploads."""

from __future__ import annotations

import uuid

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from models.user_media import UserMedia
from services.media_delivery import build_delivery_url, pick_width_bucket
from services.media_r2 import (
    ALLOWED_IMAGE_CONTENT_TYPES,
    extension_for_content_type,
    put_user_object,
    wallpaper_object_path,
)


async def get_user_media_for_user(
    db: AsyncSession,
    media_id: uuid.UUID,
    user_id: uuid.UUID,
) -> UserMedia | None:
    result = await db.execute(
        select(UserMedia).where(UserMedia.id == media_id, UserMedia.user_id == user_id)
    )
    return result.scalar_one_or_none()


def user_media_delivery_url(object_path: str, *, width_px: int = 1950) -> str:
    w = pick_width_bucket(width_px)
    return build_delivery_url(object_path=object_path, lane="user", width=w, crop="fit")


async def create_user_wallpaper_upload(
    db: AsyncSession,
    user_id: uuid.UUID,
    body: bytes,
    content_type: str,
) -> UserMedia:
    ct = (content_type or "").split(";")[0].strip().lower()
    if ct not in ALLOWED_IMAGE_CONTENT_TYPES:
        raise ValueError("unsupported_content_type")
    if not body or len(body) > 20 * 1024 * 1024:
        raise ValueError("invalid_body_size")

    upload_id = uuid.uuid4()
    ext = extension_for_content_type(ct)
    object_path = wallpaper_object_path(user_id, upload_id, ext)

    await put_user_object(object_path, body, ct)

    row = UserMedia(
        id=upload_id,
        user_id=user_id,
        kind="wallpaper",
        object_path=object_path,
        content_type=ct,
        byte_size=len(body),
    )
    db.add(row)
    await db.commit()
    await db.refresh(row)
    return row


def serialize_user_media(row: UserMedia, *, width_px: int = 1950) -> dict:
    return {
        "id": str(row.id),
        "user_id": str(row.user_id),
        "kind": row.kind,
        "object_path": row.object_path,
        "content_type": row.content_type,
        "byte_size": row.byte_size,
        "delivery_url": user_media_delivery_url(row.object_path, width_px=width_px),
        "created_at": row.created_at.isoformat() if row.created_at else None,
    }
