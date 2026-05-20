"""
Create and link one activeChat row per smart hub (smart_hubs."activeChat" FK).

New rows use appearance/itheme column defaults (6, 10) like UserProfile at signup.
Avatar/display fields are read from user_profiles only.
"""

from __future__ import annotations

import uuid

import structlog
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from models.active_chat import ActiveChat
from models.database_models import SmartHub

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
