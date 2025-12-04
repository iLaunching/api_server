"""
Onboarding API routes for creating Smart Hub and Smart Matrix during user onboarding.
"""

import uuid
from datetime import datetime
from typing import Optional
from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel, Field
from sqlalchemy.ext.asyncio import AsyncSession
import structlog

from config.database import get_db
from models.database_models import SmartHub, SmartMatrix
from auth.middleware import get_current_session

logger = structlog.get_logger()

router = APIRouter(prefix="/api/v1/onboarding", tags=["onboarding"])


class OnboardingRequest(BaseModel):
    """Request model for onboarding data"""
    hub_name: str = Field(..., min_length=1, max_length=255, description="Smart Hub name")
    hub_color_id: int = Field(..., description="Selected color ID from smarthub_color_scheme")
    matrix_name: str = Field(..., min_length=1, description="Smart Matrix name")
    marketing_option_id: Optional[int] = Field(None, description="Selected marketing option ID")


class OnboardingResponse(BaseModel):
    """Response model for onboarding completion"""
    success: bool
    hub_id: str
    matrix_id: str
    message: str
    step: str  # Current step being processed


@router.post("/complete", response_model=OnboardingResponse)
async def complete_onboarding(
    request: OnboardingRequest,
    db: AsyncSession = Depends(get_db),
    session_data: dict = Depends(get_current_session)
):
    """
    Complete onboarding by creating Smart Hub and Smart Matrix.
    
    Steps:
    1. Create Smart Hub with name and color
    2. Create Smart Matrix linked to the hub
    3. Store marketing option in hub settings
    
    Each step will return progress updates.
    """
    try:
        user_id = uuid.UUID(session_data.get("user_id"))
        logger.info("Starting onboarding", user_id=str(user_id), hub_name=request.hub_name)
        
        # Step 1: Create Smart Hub
        hub = await SmartHub.create(
            db=db,
            owner_id=user_id,
            name=request.hub_name,
            hub_color=str(request.hub_color_id),
            is_default=True,  # First hub is always default
            order_number=0,
            settings={
                "marketing_source_id": request.marketing_option_id,
                "onboarding_completed": True,
                "onboarding_date": datetime.utcnow().isoformat()
            }
        )
        
        logger.info("Smart hub created", hub_id=str(hub.id), user_id=str(user_id))
        
        # Step 2: Create Smart Matrix
        matrix = await SmartMatrix.create(
            db=db,
            smart_hub_id=hub.id,
            owner_id=user_id,
            name=request.matrix_name,
            order_number=0
        )
        
        logger.info("Smart matrix created", matrix_id=str(matrix.id), hub_id=str(hub.id))
        
        return OnboardingResponse(
            success=True,
            hub_id=str(hub.id),
            matrix_id=str(matrix.id),
            message="Onboarding completed successfully",
            step="complete"
        )
        
    except Exception as e:
        logger.error("Onboarding failed", error=str(e), user_id=str(user_id))
        raise HTTPException(
            status_code=500,
            detail=f"Failed to complete onboarding: {str(e)}"
        )


@router.post("/create-hub", response_model=OnboardingResponse)
async def create_hub_step(
    hub_name: str,
    hub_color_id: int,
    db: AsyncSession = Depends(get_db),
    session_data: dict = Depends(get_current_session)
):
    """
    Step 1: Create Smart Hub only.
    Returns hub_id to use for subsequent steps.
    """
    try:
        user_id = uuid.UUID(session_data.get("user_id"))
        
        hub = await SmartHub.create(
            db=db,
            owner_id=user_id,
            name=hub_name,
            hub_color=str(hub_color_id),
            is_default=True,
            order_number=0,
            settings={"onboarding_in_progress": True}
        )
        
        return OnboardingResponse(
            success=True,
            hub_id=str(hub.id),
            matrix_id="",
            message=f"Smart Hub '{hub_name}' created",
            step="hub_created"
        )
        
    except Exception as e:
        logger.error("Hub creation failed", error=str(e))
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/create-matrix", response_model=OnboardingResponse)
async def create_matrix_step(
    hub_id: str,
    matrix_name: str,
    marketing_option_id: Optional[int] = None,
    db: AsyncSession = Depends(get_db),
    session_data: dict = Depends(get_current_session)
):
    """
    Step 2: Create Smart Matrix for the hub.
    """
    try:
        user_id = uuid.UUID(session_data.get("user_id"))
        hub_uuid = uuid.UUID(hub_id)
        
        # Verify hub exists and belongs to user
        hub = await SmartHub.get_by_id(db, hub_uuid)
        if not hub or hub.owner_id != user_id:
            raise HTTPException(status_code=404, detail="Smart Hub not found")
        
        # Create matrix
        matrix = await SmartMatrix.create(
            db=db,
            smart_hub_id=hub_uuid,
            owner_id=user_id,
            name=matrix_name,
            order_number=0
        )
        
        # Update hub settings
        hub.settings.update({
            "marketing_source_id": marketing_option_id,
            "onboarding_completed": True,
            "onboarding_date": datetime.utcnow().isoformat()
        })
        await db.commit()
        
        return OnboardingResponse(
            success=True,
            hub_id=str(hub.id),
            matrix_id=str(matrix.id),
            message=f"Smart Matrix '{matrix_name}' created",
            step="complete"
        )
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Matrix creation failed", error=str(e))
        raise HTTPException(status_code=500, detail=str(e))
