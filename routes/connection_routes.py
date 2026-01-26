"""
API Routes for Node Connections (Tier C)
Handles creation and management of connections between node ports
"""

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from typing import List, Dict, Any
from pydantic import BaseModel, Field
import uuid
import structlog

from config.database import get_db
from models.canvas_node import CanvasNode
from models.node_connection import NodeConnection
from auth.middleware import get_current_session
from services.connection_validator import ConnectionValidator

logger = structlog.get_logger()

# Versioned API path
router = APIRouter(prefix="/api/v1/connection", tags=["connections"])

# Initialize validator
validator = ConnectionValidator()

# ============================================================================
# Pydantic Schemas
# ============================================================================

class ConnectionCreate(BaseModel):
    """Schema for creating a new connection"""
    source_node_id: uuid.UUID = Field(..., description="Source node UUID (output port)")
    source_port_id: str = Field(..., description="Source port ID")
    target_node_id: uuid.UUID = Field(..., description="Target node UUID (input port)")
    target_port_id: str = Field(..., description="Target port ID")
    
    # Visual & Animation (optional)
    color: str = Field('#3b82f6', description="Connection color")
    animated: bool = Field(True, description="Enable pulse animation")
    pulse_speed: int = Field(200, description="Pulse speed in ms")

class ConnectionResponse(BaseModel):
    """Schema for connection response"""
    connection_id: uuid.UUID
    source_node_id: uuid.UUID
    source_port_id: str
    target_node_id: uuid.UUID
    target_port_id: str
    color: str
    animated: bool
    pulse_speed: int
    status: str
    created_at: str
    updated_at: str
    
    class Config:
        orm_mode = True

class NodeConnectionsResponse(BaseModel):
    """Schema for node connections response"""
    incoming: List[ConnectionResponse]
    outgoing: List[ConnectionResponse]

# ============================================================================
# Routes
# ============================================================================

@router.post("/create", response_model=ConnectionResponse, status_code=status.HTTP_201_CREATED)
async def create_connection(
    connection_data: ConnectionCreate,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """
    Create a new connection between node ports.
    
    Validates:
    - Nodes exist
    - Ports exist
    - No self-connections
    - Input/output ports not already connected
    - No cycles created
    - Data type compatibility
    """
    
    # Fetch source and target nodes
    source_stmt = select(CanvasNode).where(CanvasNode.node_id == connection_data.source_node_id)
    target_stmt = select(CanvasNode).where(CanvasNode.node_id == connection_data.target_node_id)
    
    source_result = await db.execute(source_stmt)
    target_result = await db.execute(target_stmt)
    
    source_node = source_result.scalar_one_or_none()
    target_node = target_result.scalar_one_or_none()
    
    if not source_node:
        raise HTTPException(status_code=404, detail="Source node not found")
    
    if not target_node:
        raise HTTPException(status_code=404, detail="Target node not found")
    
    # Verify nodes are in the same context
    if source_node.context_id != target_node.context_id:
        raise HTTPException(
            status_code=400,
            detail="Cannot connect nodes from different contexts"
        )
    
    # Get all existing connections in this context
    connections_stmt = select(NodeConnection).join(
        CanvasNode,
        NodeConnection.source_node_id == CanvasNode.node_id
    ).where(CanvasNode.context_id == source_node.context_id)
    
    connections_result = await db.execute(connections_stmt)
    existing_connections = connections_result.scalars().all()
    
    # Validate connection
    is_valid, error_message = validator.validate_connection(
        source_node,
        connection_data.source_port_id,
        target_node,
        connection_data.target_port_id,
        existing_connections
    )
    
    if not is_valid:
        raise HTTPException(status_code=400, detail=error_message)
    
    # Create connection
    new_connection = NodeConnection(
        source_node_id=connection_data.source_node_id,
        source_port_id=connection_data.source_port_id,
        target_node_id=connection_data.target_node_id,
        target_port_id=connection_data.target_port_id,
        color=connection_data.color,
        animated=connection_data.animated,
        pulse_speed=connection_data.pulse_speed,
        status='idle'
    )
    
    try:
        db.add(new_connection)
        await db.commit()
        await db.refresh(new_connection)
        
        logger.info(
            "connection_created",
            connection_id=str(new_connection.connection_id),
            source_node=str(source_node.node_id),
            target_node=str(target_node.node_id)
        )
        
        return ConnectionResponse(
            connection_id=new_connection.connection_id,
            source_node_id=new_connection.source_node_id,
            source_port_id=new_connection.source_port_id,
            target_node_id=new_connection.target_node_id,
            target_port_id=new_connection.target_port_id,
            color=new_connection.color,
            animated=new_connection.animated,
            pulse_speed=new_connection.pulse_speed,
            status=new_connection.status,
            created_at=new_connection.created_at,
            updated_at=new_connection.updated_at
        )
        
    except Exception as e:
        await db.rollback()
        logger.error("create_connection_failed", error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to create connection"
        )

@router.get("/node/{node_id}/connections", response_model=NodeConnectionsResponse)
async def get_node_connections(
    node_id: uuid.UUID,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """
    Get all connections for a specific node (incoming and outgoing).
    """
    
    # Verify node exists
    node_stmt = select(CanvasNode).where(CanvasNode.node_id == node_id)
    node_result = await db.execute(node_stmt)
    node = node_result.scalar_one_or_none()
    
    if not node:
        raise HTTPException(status_code=404, detail="Node not found")
    
    # Get incoming connections (where this node is the target)
    incoming_stmt = select(NodeConnection).where(
        NodeConnection.target_node_id == node_id
    )
    incoming_result = await db.execute(incoming_stmt)
    incoming_connections = incoming_result.scalars().all()
    
    # Get outgoing connections (where this node is the source)
    outgoing_stmt = select(NodeConnection).where(
        NodeConnection.source_node_id == node_id
    )
    outgoing_result = await db.execute(outgoing_stmt)
    outgoing_connections = outgoing_result.scalars().all()
    
    return NodeConnectionsResponse(
        incoming=[
            ConnectionResponse(
                connection_id=conn.connection_id,
                source_node_id=conn.source_node_id,
                source_port_id=conn.source_port_id,
                target_node_id=conn.target_node_id,
                target_port_id=conn.target_port_id,
                color=conn.color,
                animated=conn.animated,
                pulse_speed=conn.pulse_speed,
                status=conn.status,
                created_at=conn.created_at,
                updated_at=conn.updated_at
            ) for conn in incoming_connections
        ],
        outgoing=[
            ConnectionResponse(
                connection_id=conn.connection_id,
                source_node_id=conn.source_node_id,
                source_port_id=conn.source_port_id,
                target_node_id=conn.target_node_id,
                target_port_id=conn.target_port_id,
                color=conn.color,
                animated=conn.animated,
                pulse_speed=conn.pulse_speed,
                status=conn.status,
                created_at=conn.created_at,
                updated_at=conn.updated_at
            ) for conn in outgoing_connections
        ]
    )

@router.get("/context/{context_id}/connections", response_model=List[ConnectionResponse])
async def get_context_connections(
    context_id: uuid.UUID,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """
    Get all connections for a context.
    Useful for loading entire canvas state.
    """
    
    # Get all connections where source node is in this context
    stmt = select(NodeConnection).join(
        CanvasNode,
        NodeConnection.source_node_id == CanvasNode.node_id
    ).where(CanvasNode.context_id == context_id)
    
    result = await db.execute(stmt)
    connections = result.scalars().all()
    
    return [
        ConnectionResponse(
            connection_id=conn.connection_id,
            source_node_id=conn.source_node_id,
            source_port_id=conn.source_port_id,
            target_node_id=conn.target_node_id,
            target_port_id=conn.target_port_id,
            color=conn.color,
            animated=conn.animated,
            pulse_speed=conn.pulse_speed,
            status=conn.status,
            created_at=conn.created_at,
            updated_at=conn.updated_at
        ) for conn in connections
    ]

@router.delete("/{connection_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_connection(
    connection_id: uuid.UUID,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """Delete a connection"""
    
    stmt = select(NodeConnection).where(NodeConnection.connection_id == connection_id)
    result = await db.execute(stmt)
    connection = result.scalar_one_or_none()
    
    if not connection:
        raise HTTPException(status_code=404, detail="Connection not found")
    
    try:
        await db.delete(connection)
        await db.commit()
        
        logger.info("connection_deleted", connection_id=str(connection_id))
        
    except Exception as e:
        await db.rollback()
        logger.error("delete_connection_failed", error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to delete connection"
        )
