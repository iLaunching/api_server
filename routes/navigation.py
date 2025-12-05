"""
User Navigation API routes - Global navigation system for entire application
Manages current position across all app features (Smart Hubs, Smart Matrices, Designs, etc.)
"""

import uuid
from typing import Optional
from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel
from sqlalchemy.ext.asyncio import AsyncSession
import structlog

from config.database import get_db
from models.database_models import SmartHub, SmartMatrix
from models.user_navigation import UserNavigation
from auth.middleware import get_current_session

logger = structlog.get_logger()

router = APIRouter(prefix="/api/v1/navigation", tags=["navigation"])


class NavigationResponse(BaseModel):
    """Response model for global navigation data"""
    user_id: str
    current_smart_hub_id: Optional[str] = None
    current_smart_matrix_id: Optional[str] = None
    current_smart_hub: Optional[dict] = None
    current_smart_matrix: Optional[dict] = None


class SetSmartHubRequest(BaseModel):
    """Request model for setting current Smart Hub"""
    smart_hub_id: str


class SetSmartMatrixRequest(BaseModel):
    """Request model for setting current Smart Matrix"""
    smart_matrix_id: str


@router.get("/current", response_model=NavigationResponse)
async def get_current_navigation(
    db: AsyncSession = Depends(get_db),
    session_data: dict = Depends(get_current_session)
):
    """
    Get user's current global navigation state across all features.
    """
    try:
        user_id = uuid.UUID(session_data.get("user_id"))
        
        # Get navigation record (should exist from signup)
        navigation = await UserNavigation.get_by_user_id(db, user_id)
        if not navigation:
            raise HTTPException(status_code=404, detail="Navigation record not found - please contact support")
        
        # Get Smart Hub details if set
        hub_data = None
        if navigation.current_smart_hub_id:
            hub = await SmartHub.get_by_id(db, navigation.current_smart_hub_id)
            if hub:
                hub_data = hub.to_dict()
        
        # Get Smart Matrix details if set
        matrix_data = None
        if navigation.current_smart_matrix_id:
            matrix = await SmartMatrix.get_by_id(db, navigation.current_smart_matrix_id)
            if matrix:
                matrix_data = matrix.to_dict()
        
        return NavigationResponse(
            user_id=str(user_id),
            current_smart_hub_id=str(navigation.current_smart_hub_id) if navigation.current_smart_hub_id else None,
            current_smart_matrix_id=str(navigation.current_smart_matrix_id) if navigation.current_smart_matrix_id else None,
            current_smart_hub=hub_data,
            current_smart_matrix=matrix_data
        )
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Failed to get navigation", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to get navigation state")


@router.put("/smart-hub")
async def set_current_smart_hub(
    request: SetSmartHubRequest,
    db: AsyncSession = Depends(get_db),
    session_data: dict = Depends(get_current_session)
):
    """
    Set/replace current Smart Hub in global navigation.
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
        
        # Get navigation record
        navigation = await UserNavigation.get_by_user_id(db, user_id)
        if not navigation:
            raise HTTPException(status_code=404, detail="Navigation record not found - please contact support")
        
        # Set current hub
        await navigation.set_current_smart_hub(db, hub_id)
        
        return {
            "success": True,
            "message": "Current Smart Hub set",
            "current_smart_hub_id": str(hub_id),
            "hub_name": hub.name
        }
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Failed to set current hub", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to set current Smart Hub")


@router.delete("/smart-hub")
async def clear_current_smart_hub(
    db: AsyncSession = Depends(get_db),
    session_data: dict = Depends(get_current_session)
):
    """
    Clear current Smart Hub from global navigation.
    """
    try:
        user_id = uuid.UUID(session_data.get("user_id"))
        
        # Get navigation record
        navigation = await UserNavigation.get_by_user_id(db, user_id)
        if not navigation:
            raise HTTPException(status_code=404, detail="Navigation record not found")
        
        # Clear current hub
        await navigation.clear_current_smart_hub(db)
        
        return {
            "success": True,
            "message": "Current Smart Hub cleared"
        }
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Failed to clear current hub", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to clear current Smart Hub")


@router.put("/smart-matrix")
async def set_current_smart_matrix(
    request: SetSmartMatrixRequest,
    db: AsyncSession = Depends(get_db),
    session_data: dict = Depends(get_current_session)
):
    """
    Set/replace current Smart Matrix in global navigation.
    """
    try:
        user_id = uuid.UUID(session_data.get("user_id"))
        matrix_id = uuid.UUID(request.smart_matrix_id)
        
        # Verify matrix exists
        matrix = await SmartMatrix.get_by_id(db, matrix_id)
        if not matrix:
            raise HTTPException(status_code=404, detail="Smart Matrix not found")
        
        # Verify matrix belongs to user's hub
        hub = await SmartHub.get_by_id(db, matrix.smart_hub_id)
        if not hub or hub.owner_id != user_id:
            raise HTTPException(status_code=403, detail="Not authorized to access this Smart Matrix")
        
        # Get navigation record
        navigation = await UserNavigation.get_by_user_id(db, user_id)
        if not navigation:
            raise HTTPException(status_code=404, detail="Navigation record not found - please contact support")
        
        # Set current matrix
        await navigation.set_current_smart_matrix(db, matrix_id)
        
        return {
            "success": True,
            "message": "Current Smart Matrix set",
            "current_smart_matrix_id": str(matrix_id)
        }
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Failed to set current matrix", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to set current Smart Matrix")


@router.delete("/smart-matrix")
async def clear_current_smart_matrix(
    db: AsyncSession = Depends(get_db),
    session_data: dict = Depends(get_current_session)
):
    """
    Clear current Smart Matrix from global navigation.
    """
    try:
        user_id = uuid.UUID(session_data.get("user_id"))
        
        # Get navigation record
        navigation = await UserNavigation.get_by_user_id(db, user_id)
        if not navigation:
            raise HTTPException(status_code=404, detail="Navigation record not found")
        
        # Clear current matrix
        await navigation.clear_current_smart_matrix(db)
        
        return {
            "success": True,
            "message": "Current Smart Matrix cleared"
        }
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Failed to clear current matrix", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to clear current Smart Matrix")


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
        navigation = await UserNavigation.get_by_user_id(db, user_id)
        if not navigation:
            navigation = await UserNavigation.get_or_create(db, user_id)
        
        return {
            "hubs": [hub.to_dict() for hub in hubs],
            "current_smart_hub_id": str(navigation.current_smart_hub_id) if navigation.current_smart_hub_id else None,
            "count": len(hubs)
        }
        
    except Exception as e:
        logger.error("Failed to get user hubs", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to get Smart Hubs")
