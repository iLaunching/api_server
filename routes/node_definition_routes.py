"""
Node Definition Routes
API endpoints for the Node Definition Library
"""

from fastapi import APIRouter, Depends, HTTPException, Query
from typing import Optional, List
from uuid import UUID
import asyncpg

from models.node_definition import (
    NodeDefinition,
    NodeDefinitionCreate,
    NodeDefinitionUpdate,
    NodeDefinitionList,
    CreateNodeFromDefinition
)
from auth.middleware import get_current_session
from database import get_db_pool

router = APIRouter(prefix="/api/nodes/definitions", tags=["Node Definitions"])


@router.get("", response_model=NodeDefinitionList)
async def get_node_definitions(
    category: Optional[str] = Query(None, description="Filter by category: GENESIS, CAMPAIGN, or VALIDATION"),
    active_only: bool = Query(True, description="Only return active definitions"),
    pool: asyncpg.Pool = Depends(get_db_pool),
    current_session: dict = Depends(get_current_session)
):
    """
    Get all node definitions, optionally filtered by category.
    
    This endpoint returns the Node Definition Library - the catalog of spawnable nodes.
    Used by:
    - Frontend menu to display available nodes
    - AI to discover available tools
    """
    
    async with pool.acquire() as conn:
        # Build query based on filters
        query = """
            SELECT 
                def_id,
                category,
                display_name,
                description,
                icon_name,
                node_type,
                default_config,
                is_active,
                created_at
            FROM tbl_node_definitions
            WHERE 1=1
        """
        params = []
        param_count = 1
        
        if active_only:
            query += f" AND is_active = ${param_count}"
            params.append(True)
            param_count += 1
        
        if category:
            query += f" AND category = ${param_count}"
            params.append(category.upper())
            param_count += 1
        
        query += " ORDER BY category, display_name"
        
        # Execute query
        rows = await conn.fetch(query, *params)
        
        # Convert to models
        definitions = [
            NodeDefinition(
                def_id=row['def_id'],
                category=row['category'],
                display_name=row['display_name'],
                description=row['description'],
                icon_name=row['icon_name'],
                node_type=row['node_type'],
                default_config=row['default_config'],
                is_active=row['is_active'],
                created_at=row['created_at']
            )
            for row in rows
        ]
        
        return NodeDefinitionList(
            definitions=definitions,
            total=len(definitions),
            category_filter=category
        )


@router.get("/{def_id}", response_model=NodeDefinition)
async def get_node_definition(
    def_id: UUID,
    pool: asyncpg.Pool = Depends(get_db_pool),
    current_session: dict = Depends(get_current_session)
):
    """Get a specific node definition by ID"""
    
    async with pool.acquire() as conn:
        row = await conn.fetchrow("""
            SELECT 
                def_id,
                category,
                display_name,
                description,
                icon_name,
                node_type,
                default_config,
                is_active,
                created_at
            FROM tbl_node_definitions
            WHERE def_id = $1
        """, def_id)
        
        if not row:
            raise HTTPException(status_code=404, detail="Node definition not found")
        
        return NodeDefinition(
            def_id=row['def_id'],
            category=row['category'],
            display_name=row['display_name'],
            description=row['description'],
            icon_name=row['icon_name'],
            node_type=row['node_type'],
            default_config=row['default_config'],
            is_active=row['is_active'],
            created_at=row['created_at']
        )


@router.post("", response_model=NodeDefinition, status_code=201)
async def create_node_definition(
    definition: NodeDefinitionCreate,
    pool: asyncpg.Pool = Depends(get_db_pool),
    current_session: dict = Depends(get_current_session)
):
    """
    Create a new node definition.
    
    This allows admins to add new node types to the library.
    """
    
    async with pool.acquire() as conn:
        row = await conn.fetchrow("""
            INSERT INTO tbl_node_definitions (
                category,
                display_name,
                description,
                icon_name,
                node_type,
                default_config,
                is_active
            ) VALUES ($1, $2, $3, $4, $5, $6, $7)
            RETURNING 
                def_id,
                category,
                display_name,
                description,
                icon_name,
                node_type,
                default_config,
                is_active,
                created_at
        """,
            definition.category.upper(),
            definition.display_name,
            definition.description,
            definition.icon_name,
            definition.node_type,
            definition.default_config,
            definition.is_active
        )
        
        return NodeDefinition(
            def_id=row['def_id'],
            category=row['category'],
            display_name=row['display_name'],
            description=row['description'],
            icon_name=row['icon_name'],
            node_type=row['node_type'],
            default_config=row['default_config'],
            is_active=row['is_active'],
            created_at=row['created_at']
        )


@router.patch("/{def_id}", response_model=NodeDefinition)
async def update_node_definition(
    def_id: UUID,
    updates: NodeDefinitionUpdate,
    pool: asyncpg.Pool = Depends(get_db_pool),
    current_session: dict = Depends(get_current_session)
):
    """Update an existing node definition"""
    
    async with pool.acquire() as conn:
        # Build dynamic update query
        update_fields = []
        params = []
        param_count = 1
        
        if updates.category is not None:
            update_fields.append(f"category = ${param_count}")
            params.append(updates.category.upper())
            param_count += 1
        
        if updates.display_name is not None:
            update_fields.append(f"display_name = ${param_count}")
            params.append(updates.display_name)
            param_count += 1
        
        if updates.description is not None:
            update_fields.append(f"description = ${param_count}")
            params.append(updates.description)
            param_count += 1
        
        if updates.icon_name is not None:
            update_fields.append(f"icon_name = ${param_count}")
            params.append(updates.icon_name)
            param_count += 1
        
        if updates.node_type is not None:
            update_fields.append(f"node_type = ${param_count}")
            params.append(updates.node_type)
            param_count += 1
        
        if updates.default_config is not None:
            update_fields.append(f"default_config = ${param_count}")
            params.append(updates.default_config)
            param_count += 1
        
        if updates.is_active is not None:
            update_fields.append(f"is_active = ${param_count}")
            params.append(updates.is_active)
            param_count += 1
        
        if not update_fields:
            raise HTTPException(status_code=400, detail="No fields to update")
        
        params.append(def_id)
        
        query = f"""
            UPDATE tbl_node_definitions
            SET {', '.join(update_fields)}
            WHERE def_id = ${param_count}
            RETURNING 
                def_id,
                category,
                display_name,
                description,
                icon_name,
                node_type,
                default_config,
                is_active,
                created_at
        """
        
        row = await conn.fetchrow(query, *params)
        
        if not row:
            raise HTTPException(status_code=404, detail="Node definition not found")
        
        return NodeDefinition(
            def_id=row['def_id'],
            category=row['category'],
            display_name=row['display_name'],
            description=row['description'],
            icon_name=row['icon_name'],
            node_type=row['node_type'],
            default_config=row['default_config'],
            is_active=row['is_active'],
            created_at=row['created_at']
        )


@router.delete("/{def_id}", status_code=204)
async def delete_node_definition(
    def_id: UUID,
    hard_delete: bool = Query(False, description="Permanently delete instead of soft delete"),
    pool: asyncpg.Pool = Depends(get_db_pool),
    current_session: dict = Depends(get_current_session)
):
    """
    Delete a node definition.
    
    By default, performs a soft delete (sets is_active = false).
    Use hard_delete=true to permanently remove.
    """
    
    async with pool.acquire() as conn:
        if hard_delete:
            result = await conn.execute("""
                DELETE FROM tbl_node_definitions
                WHERE def_id = $1
            """, def_id)
        else:
            result = await conn.execute("""
                UPDATE tbl_node_definitions
                SET is_active = false
                WHERE def_id = $1
            """, def_id)
        
        if result == "DELETE 0" or result == "UPDATE 0":
            raise HTTPException(status_code=404, detail="Node definition not found")
        
        return None
