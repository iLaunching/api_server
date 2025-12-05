"""
User Navigation API routes for managing current Smart Hub and navigation state.
"""

import uuid
from typing import Optional
from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel
from sqlalchemy.ext.asyncio import AsyncSession
import structlog

from config.database import get_db
from models.database_models import SmartHub
from models.user_navigation import UserNavigation
from auth.middleware import get_current_session

logger = structlog.get_logger()

router = APIRouter(prefix="/api/v1/navigation", tags=["navigation"])


class NavigationResponse(BaseModel):
    """Response model for navigation data"""
    user_id: str
    current_smart_hub_id: Optional[str]
    current_smart_hub: Optional[dict] = None


class UpdateCurrentHubRequest(BaseModel):
    """Request model for updating current Smart Hub"""
    smart_hub_id: str


@router.get("/current", response_model=NavigationResponse)
async def get_current_navigation(
    db: AsyncSession = Depends(get_db),
    session_data: dict = Depends(get_current_session)
):
    """
    Get user's current navigation state including active Smart Hub.
    """
    try:
        user_id = uuid.UUID(session_data.get("user_id"))
        
        # Get or create navigation record
        navigation = await UserNavigation.get_or_create(db, user_id)
        
        # Get Smart Hub details if set
        hub_data = None
        if navigation.current_smart_hub_id:
            hub = await SmartHub.get_by_id(db, navigation.current_smart_hub_id)
            if hub:
                hub_data = hub.to_dict()
        
        return NavigationResponse(
            user_id=str(user_id),
            current_smart_hub_id=str(navigation.current_smart_hub_id) if navigation.current_smart_hub_id else None,
            current_smart_hub=hub_data
        )
        
    except Exception as e:
        logger.error("Failed to get navigation", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to get navigation state")


@router.put("/current-hub")
async def update_current_hub(
    request: UpdateCurrentHubRequest,
    db: AsyncSession = Depends(get_db),
    session_data: dict = Depends(get_current_session)
):
    """
    Update user's current active Smart Hub.
    Used for quick navigation and remembering last viewed hub.
    """
    try:
        user_id = uuid.UUID(session_data.get("user_id"))
        hub_id = uuid.UUID(request.smart_hub_id)
        
        # Verify hub exists and belongs to user
        hub = await SmartHub.get_by_id(db, hub_id)
        if not hub:
            raise HTTPException(status_code=404, detail="Smart Hub not found")
        
        if hub.owner_id != user_id:
            raise HTTPException(status_code=403, detail="Not authorized to access this Smart Hub")
        
        # Get or create navigation record
        navigation = await UserNavigation.get_or_create(db, user_id)
        
        # Update current hub
        await navigation.update_current_hub(db, hub_id)
        
        return {
            "success": True,
            "message": "Current Smart Hub updated",
            "current_smart_hub_id": str(hub_id),
            "hub_name": hub.name
        }
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Failed to update current hub", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to update current Smart Hub")


@router.get("/hubs")
async def get_user_hubs(
    db: AsyncSession = Depends(get_db),
    session_data: dict = Depends(get_current_session)
):
    """
    Get all Smart Hubs for the current user for quick navigation.
    """
    try:
        user_id = uuid.UUID(session_data.get("user_id"))
        
        # Get all hubs for user
        hubs = await SmartHub.get_user_hubs(db, user_id, active_only=True)
        
        # Get current navigation
        navigation = await UserNavigation.get_or_create(db, user_id)
        
        return {
            "hubs": [hub.to_dict() for hub in hubs],
            "current_smart_hub_id": str(navigation.current_smart_hub_id) if navigation.current_smart_hub_id else None,
            "count": len(hubs)
        }
        
    except Exception as e:
        logger.error("Failed to get user hubs", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to get Smart Hubs")
