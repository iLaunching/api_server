"""
Keep user_navigation current_* and ac_current_* hub/matrix columns in sync.
"""

from __future__ import annotations

import uuid
from typing import Optional

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from models.database_models import SmartMatrix, UserNavigation


def set_navigation_hub(
    navigation: UserNavigation, hub_id: Optional[uuid.UUID]
) -> None:
    navigation.current_smart_hub_id = hub_id
    navigation.ac_current_smart_hub_id = hub_id


def set_navigation_matrix(
    navigation: UserNavigation, matrix_id: Optional[uuid.UUID]
) -> None:
    navigation.current_smart_matrix_id = matrix_id
    navigation.ac_current_smart_matrix_id = matrix_id


def set_navigation_context(
    navigation: UserNavigation,
    *,
    hub_id: Optional[uuid.UUID] = None,
    matrix_id: Optional[uuid.UUID] = None,
) -> None:
    set_navigation_hub(navigation, hub_id)
    set_navigation_matrix(navigation, matrix_id)


async def first_matrix_id_for_hub(
    db: AsyncSession,
    hub_id: uuid.UUID,
    owner_id: uuid.UUID,
) -> Optional[uuid.UUID]:
    result = await db.execute(
        select(SmartMatrix.id)
        .where(
            SmartMatrix.smart_hub_id == hub_id,
            SmartMatrix.owner_id == owner_id,
        )
        .order_by(SmartMatrix.order_number.asc(), SmartMatrix.created_at.asc())
        .limit(1)
    )
    row = result.scalar_one_or_none()
    return row
