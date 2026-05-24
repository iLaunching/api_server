"""
Create and link one activeChat row per smart hub (smart_hubs."activeChat" FK).

New rows use appearance/itheme column defaults (6, 10) like UserProfile at signup.
Avatar/display fields are read from user_profiles only.
"""

from __future__ import annotations

import uuid

import structlog
from fastapi import HTTPException, status
from sqlalchemy import select, text
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from models.active_chat import ActiveChat
from models.database_models import SmartHub, UserNavigation
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
