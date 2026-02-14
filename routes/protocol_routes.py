"""
Matrix Protocol Routes
API endpoints for fetching matrix protocols
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

router = APIRouter(prefix="/protocols", tags=["Matrix Protocols"])


class MatrixProtocol(BaseModel):
    """Matrix Protocol schema"""
    protocol_id: UUID
    protocol_key: str
    initial_instructions: Optional[str] = None
    context_framework: dict = Field(default_factory=dict)
    success_criteria: dict = Field(default_factory=dict)
    is_active: bool = True
    background_color: Optional[str] = None
    border_color: Optional[str] = None
    display_name: Optional[str] = None
    display_description: Optional[str] = None
    short_description: Optional[str] = None
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True


class MatrixProtocolList(BaseModel):
    """Response schema for listing protocols"""
    protocols: List[MatrixProtocol]
    total: int


@router.get("", response_model=MatrixProtocolList)
async def get_matrix_protocols(
    active_only: bool = True,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """
    Get all matrix protocols.
    
    Returns the available protocol phases (GENESIS, CAMPAIGN, VALIDATION)
    with their instructions, frameworks, and success criteria.
    """
    
    # Build query
    stmt = select(MatrixProtocolModel)
    
    if active_only:
        stmt = stmt.where(MatrixProtocolModel.is_active == True)
    
    stmt = stmt.order_by(MatrixProtocolModel.protocol_key)
    
    # Execute query
    result = await db.execute(stmt)
    protocols = result.scalars().all()
    
    return MatrixProtocolList(
        protocols=[
            MatrixProtocol(
                protocol_id=p.protocol_id,
                protocol_key=p.protocol_key,
                initial_instructions=p.initial_instructions,
                context_framework=p.context_framework or {},
                success_criteria=p.success_criteria or {},
                is_active=p.is_active,
                background_color=p.background_color,
                border_color=p.border_color,
                display_name=p.display_name,
                display_description=p.display_description,
                short_description=p.short_description,
                created_at=p.created_at,
                updated_at=p.updated_at
            )
            for p in protocols
        ],
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
    
    return MatrixProtocol(
        protocol_id=protocol.protocol_id,
        protocol_key=protocol.protocol_key,
        initial_instructions=protocol.initial_instructions,
        context_framework=protocol.context_framework or {},
        success_criteria=protocol.success_criteria or {},
        is_active=protocol.is_active,
        background_color=protocol.background_color,
        border_color=protocol.border_color,
        display_name=protocol.display_name,
        display_description=protocol.display_description,
        short_description=protocol.short_description,
        created_at=protocol.created_at,
        updated_at=protocol.updated_at
    )


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
    
    return MatrixProtocol(
        protocol_id=protocol.protocol_id,
        protocol_key=protocol.protocol_key,
        initial_instructions=protocol.initial_instructions,
        context_framework=protocol.context_framework or {},
        success_criteria=protocol.success_criteria or {},
        is_active=protocol.is_active,
        background_color=protocol.background_color,
        border_color=protocol.border_color,
        display_name=protocol.display_name,
        display_description=protocol.display_description,
        short_description=protocol.short_description,
        created_at=protocol.created_at,
        updated_at=protocol.updated_at
    )
