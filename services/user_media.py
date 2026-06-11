"""Create and resolve user-owned wallpaper uploads."""

from __future__ import annotations

import uuid
from datetime import datetime, timezone

import structlog
from sqlalchemy import select, update
from sqlalchemy.ext.asyncio import AsyncSession

from models.user_media import UserMedia
from services.asset_patterns import resolve_pattern_delivery_url
from services.media_catalog import resolve_catalog_photo
from services.media_delivery import build_delivery_url, pick_width_bucket
from services.media_r2 import (
    extension_for_content_type,
    normalize_image_content_type,
    pattern_object_path,
    put_user_object,
    wallpaper_object_path,
)
from services.pattern_overlay import normalize_pattern_overlay_gradient

logger = structlog.get_logger()

RECENTLY_USED_FEATURED_LIMIT = 16


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


def user_media_preview_delivery_url(object_path: str, *, width_px: int = 200) -> str:
    w = pick_width_bucket(width_px)
    return build_delivery_url(object_path=object_path, lane="user", width=w, crop="fit")


async def stage_user_wallpaper_upload(
    db: AsyncSession,
    user_id: uuid.UUID,
    body: bytes,
    content_type: str,
    *,
    title: str | None = None,
    source_kind: str = "upload",
    source_catalog_photo_id: str | None = None,
    source_collection_slug: str | None = None,
    mark_recently_used: bool = False,
) -> UserMedia:
    """Upload to R2 and insert user_media row (flush only — caller commits)."""
    ct = normalize_image_content_type(content_type, body)
    if not body or len(body) > 20 * 1024 * 1024:
        raise ValueError("invalid_body_size")

    upload_id = uuid.uuid4()
    ext = extension_for_content_type(ct)
    object_path = wallpaper_object_path(user_id, upload_id, ext)

    await put_user_object(object_path, body, ct)

    now = datetime.now(timezone.utc) if mark_recently_used else None
    row = UserMedia(
        id=upload_id,
        user_id=user_id,
        kind="wallpaper",
        object_path=object_path,
        content_type=ct,
        byte_size=len(body),
        title=title,
        source_kind=source_kind,
        source_catalog_photo_id=source_catalog_photo_id,
        source_collection_slug=source_collection_slug,
        last_used_at=now,
    )
    db.add(row)
    await db.flush()
    return row


async def create_user_wallpaper_upload(
    db: AsyncSession,
    user_id: uuid.UUID,
    body: bytes,
    content_type: str,
) -> UserMedia:
    row = await stage_user_wallpaper_upload(
        db, user_id, body, content_type, title="My photo", source_kind="library"
    )
    await db.commit()
    await db.refresh(row)
    return row


async def touch_wallpaper_recently_used(
    db: AsyncSession,
    user_id: uuid.UUID,
    media_id: uuid.UUID,
) -> UserMedia | None:
    row = await get_user_media_for_user(db, media_id, user_id)
    if row is None:
        return None
    now = datetime.now(timezone.utc)
    await db.execute(
        update(UserMedia)
        .where(UserMedia.id == media_id, UserMedia.user_id == user_id)
        .values(last_used_at=now, updated_at=now)
    )
    await db.commit()
    await db.refresh(row)
    return row


async def record_catalog_wallpaper_recently_used(
    db: AsyncSession,
    user_id: uuid.UUID,
    catalog_photo_id: str,
) -> UserMedia | None:
    """Track catalog wallpaper in recently-used without copying bytes to user R2."""
    resolved = await resolve_catalog_photo(catalog_photo_id)
    if not resolved:
        logger.warning(
            "recently_used_catalog_photo_not_found",
            user_id=str(user_id),
            catalog_photo_id=catalog_photo_id,
        )
        return None

    catalog_id = resolved["media_photo_id"]
    existing = await db.execute(
        select(UserMedia).where(
            UserMedia.user_id == user_id,
            UserMedia.source_catalog_photo_id == catalog_id,
        )
    )
    row = existing.scalar_one_or_none()
    now = datetime.now(timezone.utc)
    if row is not None:
        await db.execute(
            update(UserMedia)
            .where(UserMedia.id == row.id)
            .values(last_used_at=now, updated_at=now)
        )
        await db.commit()
        await db.refresh(row)
        return row

    record_id = uuid.uuid4()
    object_path = wallpaper_object_path(user_id, record_id, "webp")
    row = UserMedia(
        id=record_id,
        user_id=user_id,
        kind="wallpaper",
        object_path=object_path,
        content_type="image/webp",
        byte_size=0,
        title=resolved.get("title"),
        source_kind="catalog",
        source_catalog_photo_id=catalog_id,
        source_collection_slug=resolved.get("collection_slug"),
        last_used_at=now,
    )
    db.add(row)
    await db.flush()
    await db.commit()
    await db.refresh(row)
    logger.info(
        "recently_used_catalog_recorded",
        user_id=str(user_id),
        catalog_photo_id=catalog_id,
        user_media_id=str(row.id),
    )
    return row


async def record_pattern_recently_used(
    db: AsyncSession,
    user_id: uuid.UUID,
    *,
    pattern_category_slug: str | None,
    pattern_id: str | None,
    pattern_delivery_url: str | None,
    pattern_opacity: float | None,
    pattern_overlay_gradient: dict | None,
) -> UserMedia | None:
    slug = (pattern_category_slug or "").strip()
    pid = (pattern_id or "").strip()
    delivery = resolve_pattern_delivery_url(pattern_delivery_url)
    if not slug or not pid or not delivery:
        logger.warning(
            "recently_used_pattern_missing_fields",
            user_id=str(user_id),
            pattern_category_slug=slug,
            pattern_id=pid,
        )
        return None

    overlay = normalize_pattern_overlay_gradient(pattern_overlay_gradient)
    opacity = float(pattern_opacity if pattern_opacity is not None else 1.0)
    opacity = max(0.0, min(1.0, opacity))
    title = pid.replace("-", " ").strip().title() or "Pattern"
    now = datetime.now(timezone.utc)

    existing = await db.execute(
        select(UserMedia).where(
            UserMedia.user_id == user_id,
            UserMedia.kind == "pattern",
            UserMedia.pattern_category_slug == slug,
            UserMedia.pattern_id == pid,
        )
    )
    row = existing.scalar_one_or_none()
    if row is not None:
        await db.execute(
            update(UserMedia)
            .where(UserMedia.id == row.id)
            .values(
                pattern_delivery_url=delivery,
                pattern_opacity=opacity,
                pattern_overlay_gradient=overlay,
                last_used_at=now,
                updated_at=now,
            )
        )
        await db.commit()
        await db.refresh(row)
        logger.info(
            "recently_used_pattern_touched",
            user_id=str(user_id),
            pattern_category_slug=slug,
            pattern_id=pid,
            user_media_id=str(row.id),
        )
        return row

    # Patterns stay on asset_server — recently-used rows are metadata + overlay snapshot only.
    record_id = uuid.uuid4()
    object_path = pattern_object_path(user_id, record_id)

    row = UserMedia(
        id=record_id,
        user_id=user_id,
        kind="pattern",
        object_path=object_path,
        content_type="application/vnd.ilaunching.pattern+json",
        byte_size=0,
        title=title,
        source_kind="catalog",
        pattern_category_slug=slug,
        pattern_id=pid,
        pattern_delivery_url=delivery,
        pattern_opacity=opacity,
        pattern_overlay_gradient=overlay,
        last_used_at=now,
    )
    db.add(row)
    await db.flush()
    await db.commit()
    await db.refresh(row)
    logger.info(
        "recently_used_pattern_recorded",
        user_id=str(user_id),
        pattern_category_slug=slug,
        pattern_id=pid,
        user_media_id=str(row.id),
    )
    return row


async def sync_recently_used_from_synaptic_experience(
    db: AsyncSession,
    user_id: uuid.UUID,
    *,
    background_kind: str | None,
    media_photo_id: str | None,
    user_photo_id: uuid.UUID | None,
    pattern_category_slug: str | None = None,
    pattern_id: str | None = None,
    pattern_delivery_url: str | None = None,
    pattern_opacity: float | None = None,
    pattern_overlay_gradient: dict | None = None,
) -> None:
    try:
        if background_kind == "media_photo" and media_photo_id:
            await record_catalog_wallpaper_recently_used(db, user_id, media_photo_id)
        elif background_kind == "user_photo" and user_photo_id:
            await touch_wallpaper_recently_used(db, user_id, user_photo_id)
        elif background_kind == "pattern" and pattern_id:
            await record_pattern_recently_used(
                db,
                user_id,
                pattern_category_slug=pattern_category_slug,
                pattern_id=pattern_id,
                pattern_delivery_url=pattern_delivery_url,
                pattern_opacity=pattern_opacity,
                pattern_overlay_gradient=pattern_overlay_gradient,
            )
    except Exception:
        logger.exception(
            "recently_used_sync_failed",
            user_id=str(user_id),
            background_kind=background_kind,
        )


async def list_recently_used_wallpapers(
    db: AsyncSession,
    user_id: uuid.UUID,
    *,
    limit: int = 48,
    offset: int = 0,
) -> list[UserMedia]:
    limit = max(1, min(limit, 100))
    offset = max(0, offset)
    result = await db.execute(
        select(UserMedia)
        .where(
            UserMedia.user_id == user_id,
            UserMedia.kind.in_(("wallpaper", "pattern")),
            UserMedia.last_used_at.isnot(None),
        )
        .order_by(UserMedia.last_used_at.desc())
        .limit(limit)
        .offset(offset)
    )
    return list(result.scalars().all())


async def apply_user_wallpaper_to_synaptic_experience(
    db: AsyncSession,
    user_id: uuid.UUID,
    body: bytes,
    content_type: str,
    *,
    pan_x: float,
    pan_y: float,
    dim_opacity: float,
):
    """
    Upload user wallpaper and update synapticExpressiveExperience in one DB transaction.
    """
    from services.active_chat import update_ac_synaptic_expressive_experience

    row = await stage_user_wallpaper_upload(
        db, user_id, body, content_type, title="My photo", source_kind="library"
    )
    experience = await update_ac_synaptic_expressive_experience(
        db,
        user_id,
        {
            "background_kind": "user_photo",
            "user_photo_id": row.id,
            "pan_x": pan_x,
            "pan_y": pan_y,
            "dim_opacity": dim_opacity,
        },
    )
    await touch_wallpaper_recently_used(db, user_id, row.id)
    return row, experience


async def _catalog_wallpaper_delivery_urls(
    catalog_photo_id: str,
    *,
    width_px: int,
    preview_width_px: int,
) -> tuple[str, str] | None:
    cover = await resolve_catalog_photo(
        catalog_photo_id, width_px=width_px, crop="fit"
    )
    preview = await resolve_catalog_photo(
        catalog_photo_id, width_px=preview_width_px, crop="fill"
    )
    if not cover or not preview:
        return None
    delivery = cover.get("delivery_url")
    preview_delivery = preview.get("delivery_url")
    if not delivery or not preview_delivery:
        return None
    return delivery, preview_delivery


async def serialize_user_media(
    row: UserMedia,
    *,
    width_px: int = 1950,
    preview_width_px: int = 200,
) -> dict:
    title = (row.title or "").strip()
    if row.kind == "pattern":
        pid = (row.pattern_id or "").strip()
        if not title:
            title = pid.replace("-", " ").title() or "Pattern"
        return {
            "id": str(row.id),
            "item_type": "pattern",
            "user_id": str(row.user_id),
            "kind": row.kind,
            "title": title,
            "pattern_category_slug": row.pattern_category_slug,
            "pattern_id": row.pattern_id,
            "pattern_delivery_url": row.pattern_delivery_url,
            "pattern_opacity": float(row.pattern_opacity if row.pattern_opacity is not None else 1.0),
            "pattern_overlay_gradient": normalize_pattern_overlay_gradient(
                row.pattern_overlay_gradient
            ),
            "object_path": row.object_path,
            "last_used_at": row.last_used_at.isoformat() if row.last_used_at else None,
            "created_at": row.created_at.isoformat() if row.created_at else None,
        }

    if not title:
        title = "Wallpaper"

    delivery_url = user_media_delivery_url(row.object_path, width_px=width_px)
    preview_delivery_url = user_media_preview_delivery_url(
        row.object_path, width_px=preview_width_px
    )
    catalog_id = (row.source_catalog_photo_id or "").strip()
    if row.source_kind == "catalog" and catalog_id:
        catalog_urls = await _catalog_wallpaper_delivery_urls(
            catalog_id,
            width_px=width_px,
            preview_width_px=preview_width_px,
        )
        if catalog_urls:
            delivery_url, preview_delivery_url = catalog_urls

    return {
        "id": str(row.id),
        "item_type": "photo",
        "user_id": str(row.user_id),
        "kind": row.kind,
        "object_path": row.object_path,
        "content_type": row.content_type,
        "byte_size": row.byte_size,
        "title": title,
        "source_kind": row.source_kind,
        "source_catalog_photo_id": row.source_catalog_photo_id,
        "source_collection_slug": row.source_collection_slug,
        "delivery_url": delivery_url,
        "preview_delivery_url": preview_delivery_url,
        "last_used_at": row.last_used_at.isoformat() if row.last_used_at else None,
        "created_at": row.created_at.isoformat() if row.created_at else None,
    }
