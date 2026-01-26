"""
API Routes for Node Templates (Node Library)
Handles retrieval of available node types per context
"""

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy import and_
from typing import List, Optional
from pydantic import BaseModel, Field
import uuid
import structlog

from config.database import get_db
from models.node_template import NodeTemplate
from models.context import Context
from auth.middleware import get_current_session

logger = structlog.get_logger()

# Versioned API path
router = APIRouter(prefix="/api/v1/templates", tags=["node-templates"])

# ============================================================================
# Pydantic Schemas
# ============================================================================

class TemplateResponse(BaseModel):
    """Schema for node template response"""
    template_id: uuid.UUID
    template_name: str
    node_type: str
    allowed_context_types: List[str]
    default_width: float
    default_height: float
    default_color: str
    shape_type: str
    icon: Optional[str]
    port_template: dict
    renderer_class: Optional[str]
    description: Optional[str]
    category: Optional[str]
    is_active: bool
    
    class Config:
        orm_mode = True

# ============================================================================
# Routes
# ============================================================================

@router.get("/", response_model=List[TemplateResponse])
async def list_templates(
    category: Optional[str] = None,
    context_type: Optional[str] = None,
    is_active: bool = True,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """
    List all node templates with optional filtering.
    
    Query Parameters:
    - category: Filter by category (ai, communication, logic, etc.)
    - context_type: Filter by allowed context type
    - is_active: Only show active templates (default: true)
    """
    
    # Build query
    stmt = select(NodeTemplate)
    
    # Apply filters
    if is_active:
        stmt = stmt.where(NodeTemplate.is_active == True)
    
    if category:
        stmt = stmt.where(NodeTemplate.category == category)
    
    if context_type:
        # Filter templates that allow this context type
        stmt = stmt.where(NodeTemplate.allowed_context_types.contains([context_type]))
    
    stmt = stmt.order_by(NodeTemplate.category, NodeTemplate.template_name)
    
    result = await db.execute(stmt)
    templates = result.scalars().all()
    
    return [
        TemplateResponse(
            template_id=t.template_id,
            template_name=t.template_name,
            node_type=t.node_type,
            allowed_context_types=t.allowed_context_types or [],
            default_width=t.default_width,
            default_height=t.default_height,
            default_color=t.default_color,
            shape_type=t.shape_type,
            icon=t.icon,
            port_template=t.port_template or {'inputs': [], 'outputs': []},
            renderer_class=t.renderer_class,
            description=t.description,
            category=t.category,
            is_active=t.is_active
        ) for t in templates
    ]

@router.get("/context/{context_id}/available-nodes", response_model=List[TemplateResponse])
async def get_available_nodes(
    context_id: uuid.UUID,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """
    Get available node types for a specific context.
    Filters templates based on context type.
    
    This is used by the frontend node library panel to show
    only relevant nodes for the current context.
    """
    
    # Get context to determine its type
    context_stmt = select(Context).where(Context.context_id == context_id)
    context_result = await db.execute(context_stmt)
    context = context_result.scalar_one_or_none()
    
    if not context:
        raise HTTPException(status_code=404, detail="Context not found")
    
    # Get templates that allow this context type
    stmt = select(NodeTemplate).where(
        and_(
            NodeTemplate.is_active == True,
            NodeTemplate.allowed_context_types.contains([context.context_type])
        )
    ).order_by(NodeTemplate.category, NodeTemplate.template_name)
    
    result = await db.execute(stmt)
    templates = result.scalars().all()
    
    logger.info(
        "available_nodes_fetched",
        context_id=str(context_id),
        context_type=context.context_type,
        template_count=len(templates)
    )
    
    return [
        TemplateResponse(
            template_id=t.template_id,
            template_name=t.template_name,
            node_type=t.node_type,
            allowed_context_types=t.allowed_context_types or [],
            default_width=t.default_width,
            default_height=t.default_height,
            default_color=t.default_color,
            shape_type=t.shape_type,
            icon=t.icon,
            port_template=t.port_template or {'inputs': [], 'outputs': []},
            renderer_class=t.renderer_class,
            description=t.description,
            category=t.category,
            is_active=t.is_active
        ) for t in templates
    ]

@router.get("/{template_id}", response_model=TemplateResponse)
async def get_template(
    template_id: uuid.UUID,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """Get a specific template by ID"""
    
    stmt = select(NodeTemplate).where(NodeTemplate.template_id == template_id)
    result = await db.execute(stmt)
    template = result.scalar_one_or_none()
    
    if not template:
        raise HTTPException(status_code=404, detail="Template not found")
    
    return TemplateResponse(
        template_id=template.template_id,
        template_name=template.template_name,
        node_type=template.node_type,
        allowed_context_types=template.allowed_context_types or [],
        default_width=template.default_width,
        default_height=template.default_height,
        default_color=template.default_color,
        shape_type=template.shape_type,
        icon=template.icon,
        port_template=template.port_template or {'inputs': [], 'outputs': []},
        renderer_class=template.renderer_class,
        description=template.description,
        category=template.category,
        is_active=template.is_active
    )
