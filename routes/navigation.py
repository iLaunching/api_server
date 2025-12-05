"""
User Navigation API routes for managing current Smart Hub and other navigation contexts.
"""

import uuid
from typing import Optional, Dict, Any
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
    navigation_state: Dict[str, Any] = {}


class UpdateCurrentHubRequest(BaseModel):
    """Request model for updating current Smart Hub"""
    smart_hub_id: str


class UpdateNavigationStateRequest(BaseModel):
    """Request model for updating navigation state contexts"""
    state_updates: Dict[str, Any]


@router.get("/current", response_model=NavigationResponse)
async def get_current_navigation(
    db: AsyncSession = Depends(get_db),
    session_data: dict = Depends(get_current_session)
):
    """
    Get user's current navigation state including active Smart Hub and other contexts.
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
            current_smart_hub=hub_data,
            navigation_state=navigation.navigation_state or {}
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


@router.put("/state")
async def update_navigation_state(
    request: UpdateNavigationStateRequest,
    db: AsyncSession = Depends(get_db),
    session_data: dict = Depends(get_current_session)
):
    """
    Update navigation state with additional contexts.
    
    Examples:
    - Set current view: {"state_updates": {"current_view": "dashboard"}}
    - Set current project: {"state_updates": {"current_project_id": "uuid-here"}}
    - Set filters: {"state_updates": {"filters": {"status": "active"}}}
    - Set breadcrumbs: {"state_updates": {"breadcrumbs": ["home", "projects", "project-1"]}}
    """
    try:
        user_id = uuid.UUID(session_data.get("user_id"))
        
        # Get or create navigation record
        navigation = await UserNavigation.get_or_create(db, user_id)
        
        # Update navigation state
        await navigation.update_navigation_state(db, request.state_updates)
        
        return {
            "success": True,
            "message": "Navigation state updated",
            "navigation_state": navigation.navigation_state
        }
        
    except Exception as e:
        logger.error("Failed to update navigation state", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to update navigation state")


@router.delete("/state/{context_key}")
async def clear_navigation_context(
    context_key: str,
    db: AsyncSession = Depends(get_db),
    session_data: dict = Depends(get_current_session)
):
    """
    Clear a specific context from navigation state.
    
    Example: DELETE /state/current_project_id
    """
    try:
        user_id = uuid.UUID(session_data.get("user_id"))
        
        # Get navigation record
        navigation = await UserNavigation.get_by_user_id(db, user_id)
        if not navigation:
            raise HTTPException(status_code=404, detail="Navigation record not found")
        
        # Clear context
        await navigation.clear_context(db, context_key)
        
        return {
            "success": True,
            "message": f"Context '{context_key}' cleared",
            "navigation_state": navigation.navigation_state
        }
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Failed to clear navigation context", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to clear navigation context")
