"""
API Routes for Context Layer (Tier B)
Handles creation and management of Contexts (Campaigns, Projects, etc.)
"""

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from typing import Optional, List, Dict, Any
from pydantic import BaseModel, Field, validator
import uuid
import structlog
from geoalchemy2 import WKTElement
from geoalchemy2.shape import to_shape
import json

from config.database import get_db
from models.context import Context
from models.database_models import SmartMatrix
from auth.middleware import get_current_session

logger = structlog.get_logger()

# Versioned API path
router = APIRouter(prefix="/api/v1/context", tags=["context"])

# ============================================================================
# Pydantic Schemas
# ============================================================================

class ContextCreate(BaseModel):
    """Schema for creating a new context"""
    smart_matrix_id: uuid.UUID = Field(..., description="Parent Smart Matrix UUID")
    context_name: str = Field(..., description="Display name for the context")
    context_type: str = Field(..., description="Type: CAMPAIGN, GOAL, PROJECT, etc.")
    
    # Optional Polygon WKT (Well-Known Text) for boundary
    # Example: "POLYGON((0 0, 10 0, 10 10, 0 10, 0 0))"
    boundary_wkt: Optional[str] = Field(None, description="WKT Polygon string (SRID 0)")
    
    local_variables: Optional[Dict[str, Any]] = Field(default_factory=dict)
    
    # Master Context Fields
    is_master_context: bool = Field(False, description="Flag for the Soul/Master Context")
    master_dna_payload: Optional[Dict[str, Any]] = Field(default_factory=dict, description="AI-led architecture keys")

    @validator('context_name')
    def name_must_not_be_empty(cls, v):
        if not v or not v.strip():
            raise ValueError('Name cannot be empty')
        return v

class ContextResponse(BaseModel):
    """Schema for context response"""
    context_id: uuid.UUID
    smart_matrix_id: uuid.UUID
    context_name: str
    context_type: str
    inherited_intent: Optional[str]
    local_variables: Dict[str, Any]
    boundary_wkt: Optional[str]
    is_active: bool
    
    # Master Context Fields
    is_master_context: bool
    master_dna_payload: Dict[str, Any]
    sync_heartbeat: Optional[str]
    
    created_at: str
    
    class Config:
        orm_mode = True

# ============================================================================
# Routes
# ============================================================================

@router.post("/create", response_model=ContextResponse, status_code=status.HTTP_201_CREATED)
async def create_context(
    context_data: ContextCreate,
    db: AsyncSession = Depends(get_db),
    # Require authentication
    current_session: dict = Depends(get_current_session) 
):
    """
    Create a new Context container.
    - Validates SmartMatrix existence.
    - Creates Context entry.
    - DB Trigger 'context_dna_handshake' will auto-populate inherited_intent.
    """
    user_id = uuid.UUID(current_session.get("id"))
    
    # Verify SmartMatrix ownership
    stmt = select(SmartMatrix).where(
        SmartMatrix.id == context_data.smart_matrix_id,
        SmartMatrix.owner_id == user_id
    )
    result = await db.execute(stmt)
    matrix = result.scalar_one_or_none()
    
    if not matrix:
        # Also check if it's the Smart Hub's owner if checking matrix ownership is indirect?
        # But SmartMatrix.owner_id should match user_id.
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, 
            detail="Smart Matrix not found or access denied"
        )

    # Process Geometry
    boundary_geom = None
    if context_data.boundary_wkt:
        try:
            # Create WKTElement with SRID 0 (Planar)
            boundary_geom = WKTElement(context_data.boundary_wkt, srid=0)
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Invalid WKT Polygon: {str(e)}"
            )

    new_context = Context(
        smart_matrix_id=context_data.smart_matrix_id,
        context_name=context_data.context_name,
        context_type=context_data.context_type,
        boundary_polygon=boundary_geom,
        local_variables=context_data.local_variables,
        # Master Fields
        is_master_context=context_data.is_master_context,
        master_dna_payload=context_data.master_dna_payload
        # inherited_intent populated by DB trigger
    )
    
    try:
        db.add(new_context)
        await db.commit()
        await db.refresh(new_context)
        
        # Format response
        # Note: SQLAlchemy might need to re-fetch to get trigger-updated fields
        # verify inherited_intent
        await db.refresh(new_context, ['inherited_intent', 'sync_heartbeat'])
        
        return ContextResponse(
            context_id=new_context.context_id,
            smart_matrix_id=new_context.smart_matrix_id,
            context_name=new_context.context_name,
            context_type=new_context.context_type,
            inherited_intent=new_context.inherited_intent,
            local_variables=new_context.local_variables or {},
            boundary_wkt=context_data.boundary_wkt, # Simplified return
            is_active=new_context.is_active,
            is_master_context=new_context.is_master_context,
            master_dna_payload=new_context.master_dna_payload or {},
            sync_heartbeat=new_context.sync_heartbeat.isoformat() if new_context.sync_heartbeat else None,
            created_at=new_context.created_at.isoformat()
        )
        
    except Exception as e:
        await db.rollback()
        logger.error("create_context_failed", error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, 
            detail="Failed to create context"
        )

@router.get("/s/manifest/{manifest_id}/master", status_code=status.HTTP_200_OK)
async def get_master_context_by_manifest(
    manifest_id: uuid.UUID,
    db: AsyncSession = Depends(get_db),
    session: dict = Depends(get_current_session)
):
    """
    Get the master context for a given manifest.
    Used by frontend to load canvas state.
    """
    try:
        # Query for master context by manifest_id
        result = await db.execute(
            select(Context).where(
                Context.manifest_id == manifest_id,
                Context.is_master_context == True
            )
        )
        context = result.scalar_one_or_none()
        
        if not context:
            logger.warning("Master context not found", manifest_id=str(manifest_id))
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Master context not found for manifest {manifest_id}"
            )
        
        logger.info("Master context retrieved", context_id=str(context.context_id), manifest_id=str(manifest_id))
        
        return {
            "context_id": str(context.context_id),
            "manifest_id": str(context.manifest_id),
            "context_name": context.context_name,
            "context_type": context.context_type,
            "is_master_context": context.is_master_context,
            "is_active": context.is_active
        }
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Failed to get master context", manifest_id=str(manifest_id), error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to get master context: {str(e)}"
        )

@router.get("/{context_id}", response_model=ContextResponse)
async def get_context(
    context_id: uuid.UUID,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """Get a Context by ID"""
    stmt = select(Context).where(Context.context_id == context_id)
    result = await db.execute(stmt)
    context = result.scalar_one_or_none()
    
    if not context:
        raise HTTPException(status_code=404, detail="Context not found")
        
    # TODO: Verify ownership via Manifest->User check for stricter security
    
    return ContextResponse(
        context_id=context.context_id,
        manifest_id=context.manifest_id,
        context_name=context.context_name,
        context_type=context.context_type,
        inherited_intent=context.inherited_intent,
        local_variables=context.local_variables or {},
        boundary_wkt=None, # Implement WKB to WKT if needed
        is_active=context.is_active,
        is_master_context=context.is_master_context,
        master_dna_payload=context.master_dna_payload or {},
        sync_heartbeat=context.sync_heartbeat.isoformat() if context.sync_heartbeat else None,
        created_at=context.created_at.isoformat()
    )

@router.get("/manifest/{manifest_id}/contexts", response_model=List[ContextResponse])
async def list_manifest_contexts(
    manifest_id: uuid.UUID,
    db: AsyncSession = Depends(get_db),
    current_session: dict = Depends(get_current_session)
):
    """List all Contexts for a specific Manifest"""
    stmt = select(Context).where(
        Context.manifest_id == manifest_id,
        Context.is_active == True
    ).order_by(Context.created_at.desc())
    
    result = await db.execute(stmt)
    contexts = result.scalars().all()
    
    return [
        ContextResponse(
            context_id=ctx.context_id,
            manifest_id=ctx.manifest_id,
            context_name=ctx.context_name,
            context_type=ctx.context_type,
            inherited_intent=ctx.inherited_intent,
            local_variables=ctx.local_variables or {},
            boundary_wkt=None,
            is_active=ctx.is_active,
            is_master_context=ctx.is_master_context,
            master_dna_payload=ctx.master_dna_payload or {},
            sync_heartbeat=ctx.sync_heartbeat.isoformat() if ctx.sync_heartbeat else None,
            created_at=ctx.created_at.isoformat()
        ) for ctx in contexts
    ]
