"""
Create and link one activeChat row per smart hub (smart_hubs."activeChat" FK).

New rows use appearance/itheme column defaults (6, 10) like UserProfile at signup.
Avatar/display fields are read from user_profiles only.
"""

from __future__ import annotations

import uuid

import structlog
from fastapi import HTTPException, status
import json

from sqlalchemy import select, text
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from models.active_chat import ActiveChat
from models.database_models import SmartHub, UserNavigation
from models.synaptic_expressive_background import SynapticExpressiveBackground
from models.user import UserProfile

logger = structlog.get_logger()


async def ensure_active_chat_for_hub(
    db: AsyncSession,
    user_id: uuid.UUID,
    hub: SmartHub,
) -> ActiveChat:
    """
    Idempotently ensure this hub has its own activeChat row and smart_hubs."activeChat" FK.
    """
    if hub.activeChat is not None:
        result = await db.execute(
            select(ActiveChat).where(ActiveChat.id == hub.activeChat)
        )
        existing = result.scalar_one_or_none()
        if existing is not None:
            return existing

    # Same pattern as auth-api: UserProfile(user_id=...) — only user_id set; column defaults apply.
    active_chat = ActiveChat(user_id=user_id)
    db.add(active_chat)
    await db.flush()

    # Ensure a 1:1 synaptic expressive background row exists and link from activeChat.
    syn_bg = SynapticExpressiveBackground(user_id=user_id, active_chat_id=active_chat.id)
    db.add(syn_bg)
    await db.flush()
    active_chat.synaptic_expressive_background_id = syn_bg.id

    hub.activeChat = active_chat.id
    await db.commit()
    await db.refresh(hub)

    logger.info(
        "active_chat_created_for_hub",
        active_chat_id=active_chat.id,
        hub_id=str(hub.id),
        user_id=str(user_id),
    )
    return active_chat


async def get_ac_current_hub_active_chat(
    db: AsyncSession,
    user_id: uuid.UUID,
) -> tuple[SmartHub, ActiveChat]:
    """
    Resolve the user's Active Chat smart hub (ac_current_smart_hub_id) and its activeChat row.
    Creates the activeChat row when the hub exists but has no link yet.
    """
    result = await db.execute(
        select(UserProfile)
        .options(
            selectinload(UserProfile.navigation)
            .selectinload(UserNavigation.ac_current_smart_hub)
            .selectinload(SmartHub.active_chat),
            selectinload(UserProfile.smart_hubs),
        )
        .where(UserProfile.user_id == user_id)
    )
    profile = result.scalar_one_or_none()
    if profile is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User profile not found",
        )

    navigation = profile.navigation
    if navigation is None or navigation.ac_current_smart_hub_id is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Active Chat smart hub not set",
        )

    hub = navigation.ac_current_smart_hub
    if hub is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Active Chat smart hub not found",
        )

    if hub.active_chat is not None:
        return hub, hub.active_chat

    active_chat = await ensure_active_chat_for_hub(db, user_id, hub)
    return hub, active_chat


async def update_ac_active_chat_appearance(
    db: AsyncSession,
    user_id: uuid.UUID,
    appearance_id: int,
) -> int:
    """Update appearance_option_id on the AC hub's activeChat row only."""
    _, active_chat = await get_ac_current_hub_active_chat(db, user_id)
    await db.execute(
        text(
            """
            UPDATE "activeChat"
            SET appearance_option_id = :appearance_id, updated_at = NOW()
            WHERE id = :active_chat_id
            """
        ),
        {"appearance_id": appearance_id, "active_chat_id": active_chat.id},
    )
    await db.commit()
    await db.refresh(active_chat)
    return active_chat.id


async def update_ac_active_chat_itheme(
    db: AsyncSession,
    user_id: uuid.UUID,
    itheme_id: int,
) -> int:
    """Update itheme_option_id on the AC hub's activeChat row only."""
    _, active_chat = await get_ac_current_hub_active_chat(db, user_id)
    await db.execute(
        text(
            """
            UPDATE "activeChat"
            SET itheme_option_id = :itheme_id, updated_at = NOW()
            WHERE id = :active_chat_id
            """
        ),
        {"itheme_id": itheme_id, "active_chat_id": active_chat.id},
    )
    await db.commit()
    await db.refresh(active_chat)
    return active_chat.id


async def ensure_synaptic_background_for_active_chat(
    db: AsyncSession,
    user_id: uuid.UUID,
    active_chat: ActiveChat,
) -> SynapticExpressiveBackground:
    """
    Ensure the activeChat row has a linked synapticExpressiveBackground row and FK pointer.
    """
    if getattr(active_chat, "synaptic_expressive_background_id", None):
        result = await db.execute(
            select(SynapticExpressiveBackground).where(
                SynapticExpressiveBackground.id == active_chat.synaptic_expressive_background_id
            )
        )
        existing = result.scalar_one_or_none()
        if existing is not None:
            return existing

    result = await db.execute(
        select(SynapticExpressiveBackground).where(
            SynapticExpressiveBackground.active_chat_id == active_chat.id
        )
    )
    existing_by_chat = result.scalar_one_or_none()
    if existing_by_chat is not None:
        active_chat.synaptic_expressive_background_id = existing_by_chat.id
        await db.commit()
        await db.refresh(active_chat)
        return existing_by_chat

    syn_bg = SynapticExpressiveBackground(user_id=user_id, active_chat_id=active_chat.id)
    db.add(syn_bg)
    await db.flush()
    active_chat.synaptic_expressive_background_id = syn_bg.id
    await db.commit()
    await db.refresh(active_chat)
    return syn_bg


async def update_ac_synaptic_expressive_background(
    db: AsyncSession,
    user_id: uuid.UUID,
    payload: dict,
) -> SynapticExpressiveBackground:
    """
    Update the synapticExpressiveBackground row for the user's current Active Chat hub.
    Payload is a validated dict from the route layer.
    """
    _, active_chat = await get_ac_current_hub_active_chat(db, user_id)
    bg = await ensure_synaptic_background_for_active_chat(db, user_id, active_chat)

    # Normalize kind-specific clearing to avoid stale fields.
    kind = payload.get("background_kind")
    if kind == "pattern":
        payload["media_photo_id"] = None
        payload["user_photo_id"] = None
        payload["dim_opacity"] = 0
    elif kind == "media_photo":
        payload["pattern_category_slug"] = None
        payload["pattern_id"] = None
        payload["pattern_opacity"] = 1
        payload["pattern_overlay_gradient"] = None
        payload["user_photo_id"] = None
    elif kind == "user_photo":
        payload["pattern_category_slug"] = None
        payload["pattern_id"] = None
        payload["pattern_opacity"] = 1
        payload["pattern_overlay_gradient"] = None
        payload["media_photo_id"] = None
    elif kind == "solid":
        payload["pattern_category_slug"] = None
        payload["pattern_id"] = None
        payload["pattern_opacity"] = 1
        payload["pattern_overlay_gradient"] = None
        payload["media_photo_id"] = None
        payload["user_photo_id"] = None
        payload["pan_x"] = 0
        payload["pan_y"] = 0
        payload["dim_opacity"] = 0

    await db.execute(
        text(
            """
            UPDATE "synapticExpressiveBackground"
            SET
              background_kind = :background_kind,
              solid_hex = :solid_hex,
              pattern_category_slug = :pattern_category_slug,
              pattern_id = :pattern_id,
              pattern_opacity = :pattern_opacity,
              pattern_overlay_gradient = :pattern_overlay_gradient::jsonb,
              media_photo_id = :media_photo_id,
              user_photo_id = :user_photo_id,
              pan_x = :pan_x,
              pan_y = :pan_y,
              dim_opacity = :dim_opacity,
              updated_at = NOW()
            WHERE id = :id
            """
        ),
        {
            "id": bg.id,
            "background_kind": payload.get("background_kind", bg.background_kind),
            "solid_hex": payload.get("solid_hex"),
            "pattern_category_slug": payload.get("pattern_category_slug"),
            "pattern_id": payload.get("pattern_id"),
            "pattern_opacity": payload.get("pattern_opacity", 1),
            "pattern_overlay_gradient": (
                json.dumps(payload.get("pattern_overlay_gradient"))
                if payload.get("pattern_overlay_gradient") is not None
                else None
            ),
            "media_photo_id": payload.get("media_photo_id"),
            "user_photo_id": payload.get("user_photo_id"),
            "pan_x": payload.get("pan_x", 0),
            "pan_y": payload.get("pan_y", 0),
            "dim_opacity": payload.get("dim_opacity", 0),
        },
    )
    await db.commit()
    await db.refresh(bg)
    return bg
