"""
Onboarding API routes for creating Smart Hub and Smart Matrix during user onboarding.
"""

import os
import uuid
import httpx
from datetime import datetime
from typing import Optional
from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel, Field
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func
from sqlalchemy.orm import selectinload
import structlog

from config.database import get_db
from models.database_models import SmartHub, SmartMatrix, UserNavigation
from models.user import User, UserProfile
from auth.middleware import get_current_session

logger = structlog.get_logger()

router = APIRouter(prefix="/api/v1/onboarding", tags=["onboarding"])

# Auth API URL
AUTH_API_URL = os.getenv("AUTH_API_URL", "https://auth-server-production-b51c.up.railway.app")


async def update_user_onboarding_status(user_id: uuid.UUID, session_data: dict):
    """Update user's onboarding_completed status in auth-api"""
    try:
        access_token = session_data.get("access_token")
        if not access_token:
            logger.warning("No access token available for onboarding status update")
            return
            
        async with httpx.AsyncClient() as client:
            response = await client.patch(
                f"{AUTH_API_URL}/api/v1/profile/onboarding",
                headers={"Authorization": f"Bearer {access_token}"},
                timeout=5.0
            )
            
            if response.status_code == 200:
                logger.info("User onboarding status updated", user_id=str(user_id))
            else:
                logger.warning("Failed to update onboarding status", 
                             user_id=str(user_id), 
                             status=response.status_code,
                             response=response.text)
                
    except Exception as e:
        # Don't fail the onboarding if this fails - just log it
        logger.error("Error updating onboarding status", user_id=str(user_id), error=str(e))


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
            hub_color_id=request.hub_color_id,
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
        
        # Step 3: Update UserNavigation to set current_smart_hub_id using relationships
        # Load user with profile and navigation relationships
        result = await db.execute(
            select(User)
            .options(selectinload(User.profile).selectinload(UserProfile.navigation))
            .where(User.id == user_id)
        )
        user = result.scalar_one_or_none()
        
        if user and user.profile and user.profile.navigation:
            user.profile.navigation.current_smart_hub_id = hub.id
            await db.commit()
            logger.info("User navigation updated via relationships", user_id=str(user_id), hub_id=str(hub.id))
        else:
            logger.warning("User, profile, or navigation not found", user_id=str(user_id))
        
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
    journey: Optional[str] = "Validate Journey",
    use_case_id: Optional[int] = None,
    db: AsyncSession = Depends(get_db),
    session_data: dict = Depends(get_current_session)
):
    """
    Step 1: Create Smart Hub only.
    Returns hub_id to use for subsequent steps.
    """
    try:
        user_id = uuid.UUID(session_data.get("user_id"))
        
        # Check if user already has a default hub
        existing_default_hub = await db.execute(
            select(SmartHub).where(
                SmartHub.owner_id == user_id,
                SmartHub.is_default == True
            )
        )
        has_default_hub = existing_default_hub.scalar_one_or_none() is not None
        
        # Get max order_number for user's existing hubs to assign next order
        max_order_result = await db.execute(
            select(func.max(SmartHub.order_number)).where(
                SmartHub.owner_id == user_id,
                SmartHub.is_active == True
            )
        )
        max_order = max_order_result.scalar()
        next_order = (max_order + 1) if max_order is not None else 0
        
        logger.info("Creating hub with order_number", 
                   user_id=str(user_id),
                   has_default_hub=has_default_hub,
                   next_order=next_order,
                   max_existing_order=max_order)
        
        # Only set is_default=True if user doesn't have a default hub yet
        hub = await SmartHub.create(
            db=db,
            owner_id=user_id,
            name=hub_name,
            hub_color_id=hub_color_id,
            use_case_id=use_case_id,
            journey=journey,
            is_default=not has_default_hub,  # Only set default if no default exists
            order_number=next_order,
            settings={"onboarding_in_progress": True}
        )
        
        # Update UserNavigation to set current_smart_hub_id using relationships
        result = await db.execute(
            select(User)
            .options(selectinload(User.profile).selectinload(UserProfile.navigation))
            .where(User.id == user_id)
        )
        user = result.scalar_one_or_none()
        
        if user and user.profile and user.profile.navigation:
            user.profile.navigation.current_smart_hub_id = hub.id
            await db.commit()
            logger.info("User navigation updated via relationships", user_id=str(user_id), hub_id=str(hub.id))
        
        return OnboardingResponse(
            success=True,
            hub_id=str(hub.id),
            matrix_id="",
            message=f"Smart Hub '{hub_name}' created",
            step="hub_created"
        )
        
    except Exception as e:
        logger.error("Hub creation failed", error=str(e), error_type=type(e).__name__, hub_name=hub_name, hub_color_id=hub_color_id, user_id=str(user_id))
        import traceback
        logger.error("Hub creation traceback", traceback=traceback.format_exc())
        raise HTTPException(status_code=500, detail=f"Hub creation failed: {str(e)}")


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
        
        # Update user's onboarding status in auth-api
        await update_user_onboarding_status(user_id, session_data)
        
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
