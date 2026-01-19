"""
API Routes for Manifest (Tier A - Master Manifest)
Handles spatial state and business DNA for Smart Matrices
"""

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from typing import Optional
from pydantic import BaseModel, Field
import uuid
import structlog

from config.database import get_db
from models.manifest import Manifest
from models.database_models import SmartMatrix

logger = structlog.get_logger()

router = APIRouter(prefix="/api/manifest", tags=["manifest"])


# ============================================================================
# Pydantic Schemas
# ============================================================================

class ManifestCreate(BaseModel):
    """Schema for creating a new manifest"""
    smart_matrix_id: uuid.UUID = Field(..., description="UUID of the Smart Matrix")
    user_id: uuid.UUID = Field(..., description="UUID of the user")
    current_x: Optional[float] = Field(0.0, description="Initial X position")
    current_y: Optional[float] = Field(0.0, description="Initial Y position")
    zoom_level: Optional[float] = Field(1.0, description="Initial zoom level")
    business_dna: Optional[dict] = Field(default_factory=dict, description="Business DNA (intent, constraints, style)")


class ManifestUpdate(BaseModel):
    """Schema for updating manifest position"""
    current_x: float = Field(..., description="New X position")
    current_y: float = Field(..., description="New Y position")
    zoom_level: Optional[float] = Field(None, description="New zoom level")


class BusinessDNAUpdate(BaseModel):
    """Schema for updating business DNA"""
    business_dna: dict = Field(..., description="New business DNA")


class ManifestResponse(BaseModel):
    """Schema for manifest response"""
    manifest_id: uuid.UUID
    smart_matrix_id: uuid.UUID
    user_id: uuid.UUID
    current_x: float
    current_y: float
    zoom_level: float
    business_dna: dict
    last_heartbeat: str
    is_active: bool
    created_at: str
    updated_at: str

    class Config:
        from_attributes = True


# ============================================================================
# API Endpoints
# ============================================================================

@router.post("/create", response_model=ManifestResponse, status_code=status.HTTP_201_CREATED)
async def create_manifest(
    manifest_data: ManifestCreate,
    db: AsyncSession = Depends(get_db)
):
    """
    Create a new manifest for a Smart Matrix.
    
    **Note:** Each Smart Matrix can only have ONE manifest (one-to-one relationship).
    If a manifest already exists for this Smart Matrix, this will return 409 Conflict.
    """
    try:
        # Check if manifest already exists for this smart_matrix
        existing = await Manifest.get_by_smart_matrix_id(db, manifest_data.smart_matrix_id)
        if existing:
            raise HTTPException(
                status_code=status.HTTP_409_CONFLICT,
                detail=f"Manifest already exists for Smart Matrix {manifest_data.smart_matrix_id}"
            )
        
        # Verify smart_matrix exists
        smart_matrix = await SmartMatrix.get_by_id(db, manifest_data.smart_matrix_id)
        if not smart_matrix:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Smart Matrix {manifest_data.smart_matrix_id} not found"
            )
        
        # Create manifest
        manifest = await Manifest.create(
            db=db,
            smart_matrix_id=manifest_data.smart_matrix_id,
            user_id=manifest_data.user_id,
            current_x=manifest_data.current_x,
            current_y=manifest_data.current_y,
            zoom_level=manifest_data.zoom_level,
            business_dna=manifest_data.business_dna
        )
        
        # Update smart_matrix.manifest_id for bidirectional relationship
        smart_matrix.manifest_id = manifest.manifest_id
        await db.commit()
        await db.refresh(smart_matrix)
        
        logger.info(
            "Manifest created via API",
            manifest_id=str(manifest.manifest_id),
            smart_matrix_id=str(manifest_data.smart_matrix_id)
        )
        
        return manifest.to_dict()
    
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Failed to create manifest", error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to create manifest: {str(e)}"
        )


@router.get("/{manifest_id}", response_model=ManifestResponse)
async def get_manifest(
    manifest_id: uuid.UUID,
    db: AsyncSession = Depends(get_db)
):
    """
    Get manifest by ID.
    """
    manifest = await Manifest.get_by_id(db, manifest_id)
    
    if not manifest:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Manifest {manifest_id} not found"
        )
    
    return manifest.to_dict()


@router.get("/smart-matrix/{smart_matrix_id}", response_model=ManifestResponse)
async def get_manifest_by_smart_matrix(
    smart_matrix_id: uuid.UUID,
    db: AsyncSession = Depends(get_db)
):
    """
    Get manifest by Smart Matrix ID (one-to-one relationship).
    
    This is the primary way to retrieve a manifest, since you typically
    have the smart_matrix_id from the user's navigation context.
    """
    manifest = await Manifest.get_by_smart_matrix_id(db, smart_matrix_id)
    
    if not manifest:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"No manifest found for Smart Matrix {smart_matrix_id}"
        )
    
    return manifest.to_dict()


@router.patch("/{manifest_id}/position", response_model=ManifestResponse)
async def update_manifest_position(
    manifest_id: uuid.UUID,
    position_data: ManifestUpdate,
    db: AsyncSession = Depends(get_db)
):
    """
    Update manifest camera position and zoom level.
    
    This endpoint should be called frequently as the user pans/zooms the canvas.
    The `last_heartbeat` timestamp is automatically updated.
    """
    manifest = await Manifest.get_by_id(db, manifest_id)
    
    if not manifest:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Manifest {manifest_id} not found"
        )
    
    await manifest.update_position(
        db=db,
        current_x=position_data.current_x,
        current_y=position_data.current_y,
        zoom_level=position_data.zoom_level
    )
    
    return manifest.to_dict()


@router.patch("/{manifest_id}/business-dna", response_model=ManifestResponse)
async def update_business_dna(
    manifest_id: uuid.UUID,
    dna_data: BusinessDNAUpdate,
    db: AsyncSession = Depends(get_db)
):
    """
    Update manifest business DNA (founder intent, constraints, style).
    
    Business DNA is a flexible JSONB field that stores:
    - `intent`: Founder's primary goal (e.g., "Raise $50k")
    - `constraints`: Limitations (e.g., {"budget": 5000, "timeline": "30 days"})
    - `style`: Brand voice and tone preferences
    """
    manifest = await Manifest.get_by_id(db, manifest_id)
    
    if not manifest:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Manifest {manifest_id} not found"
        )
    
    await manifest.update_business_dna(db=db, business_dna=dna_data.business_dna)
    
    return manifest.to_dict()


@router.post("/{manifest_id}/heartbeat", status_code=status.HTTP_204_NO_CONTENT)
async def manifest_heartbeat(
    manifest_id: uuid.UUID,
    db: AsyncSession = Depends(get_db)
):
    """
    Update manifest heartbeat timestamp.
    
    Call this periodically to indicate the manifest is still active.
    Useful for tracking user activity and cleaning up stale manifests.
    """
    manifest = await Manifest.get_by_id(db, manifest_id)
    
    if not manifest:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Manifest {manifest_id} not found"
        )
    
    await manifest.heartbeat(db)
    
    return None


@router.delete("/{manifest_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_manifest(
    manifest_id: uuid.UUID,
    db: AsyncSession = Depends(get_db)
):
    """
    Delete a manifest.
    
    **Warning:** This will also set `smart_matrices.manifest_id` to NULL
    due to the `ON DELETE SET NULL` constraint.
    """
    manifest = await Manifest.get_by_id(db, manifest_id)
    
    if not manifest:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Manifest {manifest_id} not found"
        )
    
    await db.delete(manifest)
    await db.commit()
    
    logger.info("Manifest deleted via API", manifest_id=str(manifest_id))
    
    return None
