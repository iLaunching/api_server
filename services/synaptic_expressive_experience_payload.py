"""Enrich synapticExpressiveExperience JSON for clients."""

from __future__ import annotations

import uuid
from typing import Any

from sqlalchemy.ext.asyncio import AsyncSession

from models.synaptic_expressive_experience import SynapticExpressiveExperience
from services.media_catalog import resolve_catalog_photo
from services.user_media import get_user_media_for_user, user_media_delivery_url

from services.experience_theme_config import ensure_appearance_typography
from services.pattern_overlay import normalize_pattern_overlay_gradient

async def build_synaptic_expressive_experience_payload(
    db: AsyncSession,
    experience: SynapticExpressiveExperience,
    *,
    user_id: uuid.UUID,
) -> dict[str, Any]:
    payload: dict[str, Any] = {
        "id": experience.id,
        "active_chat_id": experience.active_chat_id,
        "user_id": str(experience.user_id),
        "background_kind": experience.background_kind,
        "solid_hex": experience.solid_hex,
        "pattern_category_slug": experience.pattern_category_slug,
        "pattern_id": experience.pattern_id,
        "pattern_delivery_url": experience.pattern_delivery_url,
        "pattern_opacity": float(
            experience.pattern_opacity if experience.pattern_opacity is not None else 1.0
        ),
        "pattern_overlay_gradient": normalize_pattern_overlay_gradient(
            experience.pattern_overlay_gradient
        ),
        "media_photo_id": experience.media_photo_id,
        "user_photo_id": str(experience.user_photo_id) if experience.user_photo_id else None,
        "pan_x": float(experience.pan_x or 0.0),
        "pan_y": float(experience.pan_y or 0.0),
        "dim_opacity": float(experience.dim_opacity or 0.0),
        "appearance_config": ensure_appearance_typography(experience.appearance_config or {}),
        "theme_config": experience.theme_config,
        "appearance_palette_id": experience.appearance_palette_id,
        "theme_palette_id": experience.theme_palette_id,
        "created_at": experience.created_at.isoformat() if experience.created_at else None,
        "updated_at": experience.updated_at.isoformat() if experience.updated_at else None,
        "media_photo_delivery_url": None,
        "user_photo_object_path": None,
        "user_photo_delivery_url": None,
    }

    if experience.background_kind == "media_photo" and experience.media_photo_id:
        resolved = await resolve_catalog_photo(experience.media_photo_id)
        if resolved:
            payload["media_photo_delivery_url"] = resolved.get("delivery_url")

    if experience.background_kind == "user_photo" and experience.user_photo_id:
        media = await get_user_media_for_user(db, experience.user_photo_id, user_id)
        if media:
            payload["user_photo_object_path"] = media.object_path
            payload["user_photo_delivery_url"] = user_media_delivery_url(media.object_path)

    return payload
