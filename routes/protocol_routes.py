"""
Matrix Protocol Routes
API endpoints for fetching matrix protocols
"""

from fastapi import APIRouter, Depends, HTTPException
from typing import List, Optional
from uuid import UUID
import asyncpg

from pydantic import BaseModel, Field
from datetime import datetime
from auth.middleware import get_current_session
from database import get_db_pool

router = APIRouter(prefix="/api/protocols", tags=["Matrix Protocols"])


class MatrixProtocol(BaseModel):
    """Matrix Protocol schema"""
    protocol_id: UUID
    protocol_key: str
    initial_instructions: Optional[str] = None
    context_framework: dict = Field(default_factory=dict)
    success_criteria: dict = Field(default_factory=dict)
    is_active: bool = True
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
    pool: asyncpg.Pool = Depends(get_db_pool),
    current_session: dict = Depends(get_current_session)
):
    """
    Get all matrix protocols.
    
    Returns the available protocol phases (GENESIS, CAMPAIGN, VALIDATION)
    with their instructions, frameworks, and success criteria.
    """
    
    async with pool.acquire() as conn:
        query = """
            SELECT 
                protocol_id,
                protocol_key,
                initial_instructions,
                context_framework,
                success_criteria,
                is_active,
                created_at,
                updated_at
            FROM tbl_matrix_protocols
            WHERE 1=1
        """
        
        params = []
        if active_only:
            query += " AND is_active = $1"
            params.append(True)
        
        query += " ORDER BY protocol_key"
        
        rows = await conn.fetch(query, *params)
        
        protocols = [
            MatrixProtocol(
                protocol_id=row['protocol_id'],
                protocol_key=row['protocol_key'],
                initial_instructions=row['initial_instructions'],
                context_framework=row['context_framework'] or {},
                success_criteria=row['success_criteria'] or {},
                is_active=row['is_active'],
                created_at=row['created_at'],
                updated_at=row['updated_at']
            )
            for row in rows
        ]
        
        return MatrixProtocolList(
            protocols=protocols,
            total=len(protocols)
        )


@router.get("/{protocol_id}", response_model=MatrixProtocol)
async def get_protocol_by_id(
    protocol_id: UUID,
    pool: asyncpg.Pool = Depends(get_db_pool),
    current_session: dict = Depends(get_current_session)
):
    """Get a specific protocol by ID"""
    
    async with pool.acquire() as conn:
        row = await conn.fetchrow("""
            SELECT 
                protocol_id,
                protocol_key,
                initial_instructions,
                context_framework,
                success_criteria,
                is_active,
                created_at,
                updated_at
            FROM tbl_matrix_protocols
            WHERE protocol_id = $1
        """, protocol_id)
        
        if not row:
            raise HTTPException(status_code=404, detail="Protocol not found")
        
        return MatrixProtocol(
            protocol_id=row['protocol_id'],
            protocol_key=row['protocol_key'],
            initial_instructions=row['initial_instructions'],
            context_framework=row['context_framework'] or {},
            success_criteria=row['success_criteria'] or {},
            is_active=row['is_active'],
            created_at=row['created_at'],
            updated_at=row['updated_at']
        )


@router.get("/key/{protocol_key}", response_model=MatrixProtocol)
async def get_protocol_by_key(
    protocol_key: str,
    pool: asyncpg.Pool = Depends(get_db_pool),
    current_session: dict = Depends(get_current_session)
):
    """Get a specific protocol by key (GENESIS, CAMPAIGN, VALIDATION)"""
    
    async with pool.acquire() as conn:
        row = await conn.fetchrow("""
            SELECT 
                protocol_id,
                protocol_key,
                initial_instructions,
                context_framework,
                success_criteria,
                is_active,
                created_at,
                updated_at
            FROM tbl_matrix_protocols
            WHERE protocol_key = $1
        """, protocol_key.upper())
        
        if not row:
            raise HTTPException(status_code=404, detail=f"Protocol '{protocol_key}' not found")
        
        return MatrixProtocol(
            protocol_id=row['protocol_id'],
            protocol_key=row['protocol_key'],
            initial_instructions=row['initial_instructions'],
            context_framework=row['context_framework'] or {},
            success_criteria=row['success_criteria'] or {},
            is_active=row['is_active'],
            created_at=row['created_at'],
            updated_at=row['updated_at']
        )
