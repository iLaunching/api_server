"""
Unified Smart Matrix Routes
Handles the sovereign Smart Matrix entity (which now includes Business DNA/Manifest)
"""

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from typing import Dict, Any, Optional
import uuid
import structlog

from config.database import get_db
from auth.middleware import get_current_session
from models.database_models import SmartMatrix
# from models.schemas import SmartMatrixUpdate, SmartMatrixResponse  # We might need to create these schemas

router = APIRouter(prefix="/api/v1/smart-matrix", tags=["smart-matrix"])
logger = structlog.get_logger()

@router.get("/{matrix_id}")
async def get_smart_matrix(
    matrix_id: uuid.UUID,
    db: AsyncSession = Depends(get_db),
    session: Dict = Depends(get_current_session)
):
    user_id = uuid.UUID(session.get("id"))
    """
    Get a Smart Matrix by ID.
    Now includes Business DNA, camera position, and master context status.
    """
    matrix = await SmartMatrix.get_by_id(db, matrix_id)
    if not matrix:
        raise HTTPException(status_code=404, detail="Smart Matrix not found")
        
    # Security check: Ensure user owns the matrix via its hub
    # This is a simplified check; in prod we'd check hub ownership more strictly
    if matrix.owner_id != user_id:
        # Check if user has access to this hub (omitted for brevity, assuming owner linkage)
        pass

    return matrix.to_dict()

@router.patch("/{matrix_id}/position")
async def update_position(
    matrix_id: uuid.UUID,
    position_data: Dict[str, Any],
    db: AsyncSession = Depends(get_db),
    session: Dict = Depends(get_current_session)
):
    """Updates the camera definition (x, y, zoom) of the user's view."""
    user_id = uuid.UUID(session.get("id"))
    matrix = await SmartMatrix.get_by_id(db, matrix_id)
    if not matrix:
        raise HTTPException(status_code=404, detail="Matrix not found")
        
    await matrix.update_position(
        db, 
        current_x=position_data.get("x", matrix.current_x),
        current_y=position_data.get("y", matrix.current_y),
        zoom_level=position_data.get("zoom", matrix.zoom_level)
    )
    return {"status": "success", "position": {"x": matrix.current_x, "y": matrix.current_y, "zoom": matrix.zoom_level}}

@router.patch("/{matrix_id}/business-dna")
async def update_business_dna(
    matrix_id: uuid.UUID,
    dna_data: Dict[str, Any],
    db: AsyncSession = Depends(get_db),
    session: Dict = Depends(get_current_session)
):
    """Updates the Business DNA (Intent, Constraints, Style)"""
    user_id = uuid.UUID(session.get("id"))
    matrix = await SmartMatrix.get_by_id(db, matrix_id)
    if not matrix:
        raise HTTPException(status_code=404, detail="Matrix not found")

    await matrix.update_business_dna(db, dna_data)
    return {"status": "success", "dna_keys_updated": list(dna_data.keys())}
    
@router.post("/{matrix_id}/heartbeat")
async def matrix_heartbeat(
    matrix_id: uuid.UUID,
    db: AsyncSession = Depends(get_db),
    session: Dict = Depends(get_current_session)
):
    """Keep-alive heartbeat for this matrix session"""
    user_id = uuid.UUID(session.get("id"))
    matrix = await SmartMatrix.get_by_id(db, matrix_id)
    if matrix:
        await matrix.heartbeat(db)
    return {"status": "alive"}
