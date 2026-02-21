"""
Matrix Protocol Routes
API endpoints for fetching matrix protocols and protocol categories
"""

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from typing import List, Optional
from uuid import UUID

from pydantic import BaseModel, Field
from datetime import datetime
from auth.middleware import get_current_session
from config.database import get_db
from models.matrix_protocol import MatrixProtocol as MatrixProtocolModel
from models.protocol_category import ProtocolCategory as ProtocolCategoryModel

router = APIRouter(prefix="/protocols", tags=["Matrix Protocols"])


# ==============================================================================
# PYDANTIC SCHEMAS
# ==============================================================================

class ProtocolCategory(BaseModel):
    """Protocol Category schema"""
    id: int
    name: str
    description: Optional[str] = None
    color: Optional[str] = None
    icon_name: Optional[str] = None
    icon_prefix: str = 'fas'
    sort_order: int = 0
    is_active: bool = True

    class Config:
        from_attributes = True


class MatrixProtocol(BaseModel):
    """Matrix Protocol schema"""
    protocol_id: UUID
    protocol_key: str
    initial_instructions: Optional[str] = None
    context_framework: dict = Field(default_factory=dict)
    success_criteria: dict = Field(default_factory=dict)
    is_active: bool = True
    category_id: Optional[int] = None
    category: Optional[ProtocolCategory] = None
    background_color: Optional[str] = None
    border_color: Optional[str] = None
    display_name: Optional[str] = None
    display_description: Optional[str] = None
    short_description: Optional[str] = None
    ui_theme: dict = Field(default_factory=dict)
    ui_assets: dict = Field(default_factory=dict)
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True


class MatrixProtocolList(BaseModel):
    """Response schema for listing protocols"""
    protocols: List[MatrixProtocol]
    total: int


# ==============================================================================
# CATEGORIES ENDPOINT
# ==============================================================================

@router.get("/categories", response_model=List[ProtocolCategory])
async def get_protocol_categories(
    active_only: bool = True,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """
    Get all protocol categories.

    Returns the available categories for filtering protocols in the UI.
    Results are ordered by sort_order.
    """
    stmt = select(ProtocolCategoryModel)
    if active_only:
        stmt = stmt.where(ProtocolCategoryModel.is_active == True)
    stmt = stmt.order_by(ProtocolCategoryModel.sort_order, ProtocolCategoryModel.name)

    result = await db.execute(stmt)
    categories = result.scalars().all()

    return [
        ProtocolCategory(
            id=c.id,
            name=c.name,
            description=c.description,
            color=c.color,
            icon_name=c.icon_name,
            icon_prefix=c.icon_prefix or 'fas',
            sort_order=c.sort_order or 0,
            is_active=c.is_active,
        )
        for c in categories
    ]


# ==============================================================================
# PROTOCOL ENDPOINTS
# ==============================================================================

def _build_protocol(p: MatrixProtocolModel, cat: Optional[ProtocolCategoryModel] = None) -> MatrixProtocol:
    """Helper to build a MatrixProtocol response, optionally embedding category."""
    return MatrixProtocol(
        protocol_id=p.protocol_id,
        protocol_key=p.protocol_key,
        initial_instructions=p.initial_instructions,
        context_framework=p.context_framework or {},
        success_criteria=p.success_criteria or {},
        is_active=p.is_active,
        category_id=p.category_id,
        category=ProtocolCategory(
            id=cat.id,
            name=cat.name,
            description=cat.description,
            color=cat.color,
            icon_name=cat.icon_name,
            icon_prefix=cat.icon_prefix or 'fas',
            sort_order=cat.sort_order or 0,
            is_active=cat.is_active,
        ) if cat else None,
        background_color=p.background_color,
        border_color=p.border_color,
        display_name=p.display_name,
        display_description=p.display_description,
        short_description=p.short_description,
        ui_theme=p.ui_theme or {},
        ui_assets=p.ui_assets or {},
        created_at=p.created_at,
        updated_at=p.updated_at,
    )


@router.get("", response_model=MatrixProtocolList)
async def get_matrix_protocols(
    active_only: bool = True,
    category_id: Optional[int] = None,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """
    Get all matrix protocols, optionally filtered by category.

    - active_only: Only return active protocols (default: true)
    - category_id: Filter by a specific category ID
    """
    stmt = select(MatrixProtocolModel)

    if active_only:
        stmt = stmt.where(MatrixProtocolModel.is_active == True)

    if category_id is not None:
        stmt = stmt.where(MatrixProtocolModel.category_id == category_id)

    stmt = stmt.order_by(MatrixProtocolModel.protocol_key)

    result = await db.execute(stmt)
    protocols = result.scalars().all()

    # Fetch categories for embedding
    all_cat_ids = list({p.category_id for p in protocols if p.category_id})
    cat_map: dict[int, ProtocolCategoryModel] = {}
    if all_cat_ids:
        cat_result = await db.execute(
            select(ProtocolCategoryModel).where(ProtocolCategoryModel.id.in_(all_cat_ids))
        )
        cat_map = {c.id: c for c in cat_result.scalars().all()}

    return MatrixProtocolList(
        protocols=[_build_protocol(p, cat_map.get(p.category_id)) for p in protocols],
        total=len(protocols)
    )


@router.get("/{protocol_id}", response_model=MatrixProtocol)
async def get_protocol_by_id(
    protocol_id: UUID,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """Get a specific protocol by ID"""
    stmt = select(MatrixProtocolModel).where(MatrixProtocolModel.protocol_id == protocol_id)
    result = await db.execute(stmt)
    protocol = result.scalar_one_or_none()

    if not protocol:
        raise HTTPException(status_code=404, detail="Protocol not found")

    cat = None
    if protocol.category_id:
        cat_result = await db.execute(
            select(ProtocolCategoryModel).where(ProtocolCategoryModel.id == protocol.category_id)
        )
        cat = cat_result.scalar_one_or_none()

    return _build_protocol(protocol, cat)


@router.get("/key/{protocol_key}", response_model=MatrixProtocol)
async def get_protocol_by_key(
    protocol_key: str,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """Get a specific protocol by key (GENESIS, CAMPAIGN, VALIDATION)"""
    stmt = select(MatrixProtocolModel).where(
        MatrixProtocolModel.protocol_key == protocol_key.upper()
    )
    result = await db.execute(stmt)
    protocol = result.scalar_one_or_none()

    if not protocol:
        raise HTTPException(status_code=404, detail=f"Protocol '{protocol_key}' not found")

    cat = None
    if protocol.category_id:
        cat_result = await db.execute(
            select(ProtocolCategoryModel).where(ProtocolCategoryModel.id == protocol.category_id)
        )
        cat = cat_result.scalar_one_or_none()

    return _build_protocol(protocol, cat)
