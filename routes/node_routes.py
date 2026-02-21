"""
API Routes for Canvas Nodes (Tier C)
Handles creation and management of nodes on the spatial canvas
"""

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy import and_, or_
from typing import Optional, List, Dict, Any
from pydantic import BaseModel, Field
import uuid
import structlog

from config.database import get_db
from models.canvas_node import CanvasNode
from models.context import Context
from auth.middleware import get_current_session

logger = structlog.get_logger()

# Versioned API path
router = APIRouter(prefix="/api/v1/node", tags=["canvas-nodes"])

# ============================================================================
# Pydantic Schemas
# ============================================================================

class NodeCreate(BaseModel):
    """Schema for creating a new canvas node"""
    context_id: uuid.UUID = Field(..., description="Parent Context UUID")
    node_type: str = Field(..., description="Node type (smart-matrix, email-sender, etc.)")
    node_name: str = Field(..., description="Display name for the node")
    node_description: Optional[str] = Field(None, description="Node description")
    
    # Spatial position
    pos_x: float = Field(..., description="X position in world coordinates")
    pos_y: float = Field(..., description="Y position in world coordinates")
    width: float = Field(200, description="Node width")
    height: float = Field(150, description="Node height")
    
    # Visual properties
    color: Optional[str] = Field('#3b82f6', description="Node color")
    background_color: Optional[str] = Field(None)
    text_color: Optional[str] = Field(None)
    
    # Port configuration
    port_config: Optional[Dict[str, Any]] = Field(
        default_factory=lambda: {'inputs': [], 'outputs': []},
        description="Port definitions"
    )
    
    # Master Bridge fields
    is_master_bridge: bool = Field(False, description="Sovereign toggle for Master Bridge")
    
    # Metadata
    metadata: Optional[Dict[str, Any]] = Field(default_factory=dict)

class NodePositionUpdate(BaseModel):
    """Schema for updating node position"""
    pos_x: float
    pos_y: float

class NodeStateUpdate(BaseModel):
    """Schema for updating node state"""
    operational_status: Optional[str] = None
    visual_state: Optional[str] = None
    is_selected: Optional[bool] = None
    is_hovered: Optional[bool] = None

class NodeProtocolUpdate(BaseModel):
    """Schema for updating node protocol"""
    protocol_id: uuid.UUID
    # Optional: allow overriding context_type if needed, but default to 'cell_protocol'
    context_type: Optional[str] = 'cell_protocol'

class NodeResponse(BaseModel):
    """Schema for node response"""
    node_id: uuid.UUID
    context_id: uuid.UUID
    node_name: str
    node_type: str
    node_description: Optional[str]
    
    # Spatial
    pos_x: float
    pos_y: float
    width: float
    height: float
    
    # Visual
    color: str
    background_color: Optional[str]
    text_color: Optional[str]
    
    # Port config
    port_config: Dict[str, Any]
    
    # Master Bridge
    is_master_bridge: bool
    bridge_inputs: Dict[str, Any]
    node_dna_overrides: Dict[str, Any]
    
    # States
    operational_status: str
    visual_state: str
    is_selected: bool
    is_hovered: bool
    
    # Execution
    execution_count: int
    last_execution_time: Optional[str]
    error_message: Optional[str]
    
    # Metadata
    metadata: Dict[str, Any]
    created_at: str
    updated_at: str
    
    class Config:
        orm_mode = True

# ============================================================================
# Routes
# ============================================================================

@router.post("/create", response_model=NodeResponse, status_code=status.HTTP_201_CREATED)
async def create_node(
    node_data: NodeCreate,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """
    Create a new canvas node.
    - Validates Context existence and ownership
    - Creates node with port configuration
    - Supports Master Bridge nodes
    """
    user_id = current_session.get("user_id")
    
    # Verify Context ownership (via Manifest)
    stmt = select(Context).where(Context.context_id == node_data.context_id)
    result = await db.execute(stmt)
    context = result.scalar_one_or_none()
    
    if not context:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Context not found or access denied"
        )
    
    # Create new node
    new_node = CanvasNode(
        context_id=node_data.context_id,
        node_type=node_data.node_type,
        node_name=node_data.node_name,
        node_description=node_data.node_description,
        pos_x=node_data.pos_x,
        pos_y=node_data.pos_y,
        width=node_data.width,
        height=node_data.height,
        color=node_data.color,
        background_color=node_data.background_color,
        text_color=node_data.text_color,
        port_config=node_data.port_config,
        is_master_bridge=node_data.is_master_bridge,
        node_metadata=node_data.metadata
    )
    
    try:
        db.add(new_node)
        await db.commit()
        await db.refresh(new_node)
        
        return NodeResponse(
            node_id=new_node.node_id,
            context_id=new_node.context_id,
            node_name=new_node.node_name,
            node_type=new_node.node_type,
            node_description=new_node.node_description,
            pos_x=new_node.pos_x,
            pos_y=new_node.pos_y,
            width=new_node.width,
            height=new_node.height,
            color=new_node.color,
            background_color=new_node.background_color,
            text_color=new_node.text_color,
            port_config=new_node.port_config or {'inputs': [], 'outputs': []},
            is_master_bridge=new_node.is_master_bridge,
            bridge_inputs=new_node.bridge_inputs or {},
            node_dna_overrides=new_node.node_dna_overrides or {},
            operational_status=new_node.operational_status,
            visual_state=new_node.visual_state,
            is_selected=new_node.is_selected,
            is_hovered=new_node.is_hovered,
            execution_count=new_node.execution_count,
            last_execution_time=new_node.last_execution_time,
            error_message=new_node.error_message,
            metadata=new_node.node_metadata or {},
            created_at=new_node.created_at,
            updated_at=new_node.updated_at
        )
        
    except Exception as e:
        await db.rollback()
        logger.error("create_node_failed", error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to create node"
        )

@router.get("/{node_id}", response_model=NodeResponse)
async def get_node(
    node_id: uuid.UUID,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """Get a single canvas node by its ID. Returns context_id among other fields."""
    stmt = select(CanvasNode).where(CanvasNode.node_id == node_id)
    result = await db.execute(stmt)
    node = result.scalar_one_or_none()

    if not node:
        raise HTTPException(status_code=404, detail="Node not found")

    return NodeResponse(
        node_id=node.node_id,
        context_id=node.context_id,
        node_name=node.node_name,
        node_type=node.node_type,
        node_description=node.node_description,
        pos_x=node.pos_x,
        pos_y=node.pos_y,
        width=node.width,
        height=node.height,
        color=node.color,
        background_color=node.background_color,
        text_color=node.text_color,
        port_config=node.port_config or {'inputs': [], 'outputs': []},
        is_master_bridge=node.is_master_bridge,
        bridge_inputs=node.bridge_inputs or {},
        node_dna_overrides=node.node_dna_overrides or {},
        operational_status=node.operational_status,
        visual_state=node.visual_state,
        is_selected=node.is_selected,
        is_hovered=node.is_hovered,
        execution_count=node.execution_count,
        last_execution_time=node.last_execution_time,
        error_message=node.error_message,
        metadata=node.node_metadata or {},
        created_at=node.created_at,
        updated_at=node.updated_at
    )

@router.get("/context/{context_id}/nodes", response_model=List[NodeResponse])
async def get_context_nodes(
    context_id: uuid.UUID,
    min_x: Optional[float] = None,
    max_x: Optional[float] = None,
    min_y: Optional[float] = None,
    max_y: Optional[float] = None,
    node_type: Optional[str] = None,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """
    Get all nodes for a context with optional spatial filtering.
    Supports viewport culling for performance.
    """
    
    # Build query
    stmt = select(CanvasNode).where(CanvasNode.context_id == context_id)
    
    # Spatial filtering (viewport culling)
    if min_x is not None and max_x is not None:
        stmt = stmt.where(and_(
            CanvasNode.pos_x >= min_x,
            CanvasNode.pos_x <= max_x
        ))
    
    if min_y is not None and max_y is not None:
        stmt = stmt.where(and_(
            CanvasNode.pos_y >= min_y,
            CanvasNode.pos_y <= max_y
        ))
    
    # Node type filtering
    if node_type:
        stmt = stmt.where(CanvasNode.node_type == node_type)
    
    stmt = stmt.order_by(CanvasNode.created_at.desc())
    
    result = await db.execute(stmt)
    nodes = result.scalars().all()
    
    return [
        NodeResponse(
            node_id=node.node_id,
            context_id=node.context_id,
            node_name=node.node_name,
            node_type=node.node_type,
            node_description=node.node_description,
            pos_x=node.pos_x,
            pos_y=node.pos_y,
            width=node.width,
            height=node.height,
            color=node.color,
            background_color=node.background_color,
            text_color=node.text_color,
            port_config=node.port_config or {'inputs': [], 'outputs': []},
            is_master_bridge=node.is_master_bridge,
            bridge_inputs=node.bridge_inputs or {},
            node_dna_overrides=node.node_dna_overrides or {},
            operational_status=node.operational_status,
            visual_state=node.visual_state,
            is_selected=node.is_selected,
            is_hovered=node.is_hovered,
            execution_count=node.execution_count,
            last_execution_time=node.last_execution_time,
            error_message=node.error_message,
            metadata=node.node_metadata or {},
            created_at=node.created_at,
            updated_at=node.updated_at
        ) for node in nodes
    ]

@router.patch("/{node_id}/position", response_model=NodeResponse)
async def update_node_position(
    node_id: uuid.UUID,
    position_data: NodePositionUpdate,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """Update node position (for drag-and-drop persistence)"""
    
    stmt = select(CanvasNode).where(CanvasNode.node_id == node_id)
    result = await db.execute(stmt)
    node = result.scalar_one_or_none()
    
    if not node:
        raise HTTPException(status_code=404, detail="Node not found")
    
    # Update position
    node.pos_x = position_data.pos_x
    node.pos_y = position_data.pos_y
    
    try:
        await db.commit()
        await db.refresh(node)
        
        return NodeResponse(
            node_id=node.node_id,
            context_id=node.context_id,
            node_name=node.node_name,
            node_type=node.node_type,
            node_description=node.node_description,
            pos_x=node.pos_x,
            pos_y=node.pos_y,
            width=node.width,
            height=node.height,
            color=node.color,
            background_color=node.background_color,
            text_color=node.text_color,
            port_config=node.port_config or {'inputs': [], 'outputs': []},
            is_master_bridge=node.is_master_bridge,
            bridge_inputs=node.bridge_inputs or {},
            node_dna_overrides=node.node_dna_overrides or {},
            operational_status=node.operational_status,
            visual_state=node.visual_state,
            is_selected=node.is_selected,
            is_hovered=node.is_hovered,
            execution_count=node.execution_count,
            last_execution_time=node.last_execution_time,
            error_message=node.error_message,
            metadata=node.node_metadata or {},
            created_at=node.created_at,
            updated_at=node.updated_at
        )
    except Exception as e:
        await db.rollback()
        logger.error("update_node_position_failed", error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to update node position"
        )

@router.patch("/{node_id}/state", response_model=NodeResponse)
async def update_node_state(
    node_id: uuid.UUID,
    state_data: NodeStateUpdate,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """Update node visual/operational state"""
    
    stmt = select(CanvasNode).where(CanvasNode.node_id == node_id)
    result = await db.execute(stmt)
    node = result.scalar_one_or_none()
    
    if not node:
        raise HTTPException(status_code=404, detail="Node not found")
    
    # Update state fields
    if state_data.operational_status is not None:
        node.operational_status = state_data.operational_status
    if state_data.visual_state is not None:
        node.visual_state = state_data.visual_state
    if state_data.is_selected is not None:
        node.is_selected = state_data.is_selected
    if state_data.is_hovered is not None:
        node.is_hovered = state_data.is_hovered
    
    try:
        await db.commit()
        await db.refresh(node)
        
        return NodeResponse(
            node_id=node.node_id,
            context_id=node.context_id,
            node_name=node.node_name,
            node_type=node.node_type,
            node_description=node.node_description,
            pos_x=node.pos_x,
            pos_y=node.pos_y,
            width=node.width,
            height=node.height,
            color=node.color,
            background_color=node.background_color,
            text_color=node.text_color,
            port_config=node.port_config or {'inputs': [], 'outputs': []},
            is_master_bridge=node.is_master_bridge,
            bridge_inputs=node.bridge_inputs or {},
            node_dna_overrides=node.node_dna_overrides or {},
            operational_status=node.operational_status,
            visual_state=node.visual_state,
            is_selected=node.is_selected,
            is_hovered=node.is_hovered,
            execution_count=node.execution_count,
            last_execution_time=node.last_execution_time,
            error_message=node.error_message,
            metadata=node.node_metadata or {},
            created_at=node.created_at,
            updated_at=node.updated_at
        )
    except Exception as e:
        await db.rollback()
        logger.error("update_node_state_failed", error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to update node state"
        )

@router.delete("/{node_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_node(
    node_id: uuid.UUID,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """Delete a node (cascades to connections)"""
    
    stmt = select(CanvasNode).where(CanvasNode.node_id == node_id)
    result = await db.execute(stmt)
    node = result.scalar_one_or_none()
    
    if not node:
        raise HTTPException(status_code=404, detail="Node not found")
    
    try:
        await db.delete(node)
        await db.commit()
    except Exception as e:
        await db.rollback()
        logger.error("delete_node_failed", error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to delete node"
        )
@router.patch("/{node_id}/protocol", response_model=NodeResponse)
async def update_node_protocol(
    node_id: uuid.UUID,
    protocol_data: NodeProtocolUpdate,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """
    Update the protocol for the context associated with this node.
    - Looks up node by ID
    - targeted_context_id = node.context_id
    - Updates tbl_contexts with new protocol and type
    """
    # 1. Get Node
    stmt = select(CanvasNode).where(CanvasNode.node_id == node_id)
    result = await db.execute(stmt)
    node = result.scalar_one_or_none()
    
    if not node:
        raise HTTPException(status_code=404, detail="Node not found")
        
    # 2. Get Context (to ensure it exists and maybe check permissions)
    # The 'context_id' on the node is the Context this node BELONGS to.
    # User instruction: "table holds the nodes context_id".
    target_context_id = node.context_id
    
    stmt_ctx = select(Context).where(Context.context_id == target_context_id)
    result_ctx = await db.execute(stmt_ctx)
    context = result_ctx.scalar_one_or_none()
    
    if not context:
        raise HTTPException(status_code=404, detail=f"Associated Context {target_context_id} not found")
        
    try:
        # 3. Update Context
        context.current_protocol_id = protocol_data.protocol_id
        if protocol_data.context_type:
            context.context_type = protocol_data.context_type
            
        # 4. Commit Linkage
        await db.commit()
        await db.refresh(node) # Refresh node to return
        
        # Optional: We might want to return the Context, but the route is under /node
        # and typically returns NodeResponse. The Node itself hasn't changed structure,
        # but its "environment" has.
        
        return NodeResponse(
            node_id=node.node_id,
            context_id=node.context_id,
            node_name=node.node_name,
            node_type=node.node_type,
            node_description=node.node_description,
            pos_x=node.pos_x,
            pos_y=node.pos_y,
            width=node.width,
            height=node.height,
            color=node.color,
            background_color=node.background_color,
            text_color=node.text_color,
            port_config=node.port_config or {'inputs': [], 'outputs': []},
            is_master_bridge=node.is_master_bridge,
            bridge_inputs=node.bridge_inputs or {},
            node_dna_overrides=node.node_dna_overrides or {},
            operational_status=node.operational_status,
            visual_state=node.visual_state,
            is_selected=node.is_selected,
            is_hovered=node.is_hovered,
            execution_count=node.execution_count,
            last_execution_time=node.last_execution_time,
            error_message=node.error_message,
            metadata=node.node_metadata or {},
            created_at=node.created_at,
            updated_at=node.updated_at
        )

    except Exception as e:
        await db.rollback()
        logger.error("update_node_protocol_failed", node_id=str(node_id), error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to update node protocol: {str(e)}"
        )
