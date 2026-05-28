"""Enrich synapticExpressiveBackground JSON for clients."""

from __future__ import annotations

import uuid
from typing import Any

from sqlalchemy.ext.asyncio import AsyncSession

from models.synaptic_expressive_background import SynapticExpressiveBackground
from services.media_catalog import resolve_catalog_photo
from services.user_media import get_user_media_for_user, user_media_delivery_url


def _normalize_pattern_overlay_gradient(raw: Any) -> Any | None:
    """Drop malformed JSONB so iOS decoding does not fail on partial gradient objects."""
    if not isinstance(raw, dict):
        return None
    stops = raw.get("stops")
    if not isinstance(stops, list) or len(stops) < 2:
        return None
    return raw


async def build_synaptic_expressive_background_payload(
    db: AsyncSession,
    bg: SynapticExpressiveBackground,
    *,
    user_id: uuid.UUID,
) -> dict[str, Any]:
    payload: dict[str, Any] = {
        "id": bg.id,
        "active_chat_id": bg.active_chat_id,
        "user_id": str(bg.user_id),
        "background_kind": bg.background_kind,
        "solid_hex": bg.solid_hex,
        "pattern_category_slug": bg.pattern_category_slug,
        "pattern_id": bg.pattern_id,
        "pattern_delivery_url": bg.pattern_delivery_url,
        "pattern_opacity": bg.pattern_opacity,
        "pattern_overlay_gradient": _normalize_pattern_overlay_gradient(
            bg.pattern_overlay_gradient
        ),
        "media_photo_id": bg.media_photo_id,
        "user_photo_id": str(bg.user_photo_id) if bg.user_photo_id else None,
        "pan_x": float(bg.pan_x or 0.0),
        "pan_y": float(bg.pan_y or 0.0),
        "dim_opacity": float(bg.dim_opacity or 0.0),
        "created_at": bg.created_at.isoformat() if bg.created_at else None,
        "updated_at": bg.updated_at.isoformat() if bg.updated_at else None,
        "media_photo_delivery_url": None,
        "user_photo_object_path": None,
        "user_photo_delivery_url": None,
    }

    if bg.background_kind == "media_photo" and bg.media_photo_id:
        resolved = await resolve_catalog_photo(bg.media_photo_id)
        if resolved:
            payload["media_photo_delivery_url"] = resolved.get("delivery_url")

    if bg.background_kind == "user_photo" and bg.user_photo_id:
        media = await get_user_media_for_user(db, bg.user_photo_id, user_id)
        if media:
            payload["user_photo_object_path"] = media.object_path
            payload["user_photo_delivery_url"] = user_media_delivery_url(media.object_path)

    return payload
