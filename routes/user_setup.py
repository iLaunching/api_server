"""
User Setup API - Called by auth-api during signup to initialize user data
"""

import uuid
from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel
from sqlalchemy.ext.asyncio import AsyncSession
import structlog

from config.database import get_db
from models.user_navigation import UserNavigation

logger = structlog.get_logger()

router = APIRouter(prefix="/api/v1/user-setup", tags=["user-setup"])


class CreateUserSetupRequest(BaseModel):
    """Request from auth-api to initialize user in api-server"""
    user_id: str
    api_key: str  # Shared secret between auth-api and api-server


@router.post("/initialize")
async def initialize_user(
    request: CreateUserSetupRequest,
    db: AsyncSession = Depends(get_db)
):
    """
    Initialize user data in api-server database.
    Called by auth-api immediately after user signup.
    
    Creates:
    - user_navigation record (global navigation system)
    """
    try:
        # Verify API key
        import os
        expected_api_key = os.getenv("INTERNAL_API_KEY", "your-secret-key-here")
        if request.api_key != expected_api_key:
            logger.warning("Unauthorized user setup attempt", user_id=request.user_id)
            raise HTTPException(status_code=403, detail="Unauthorized")
        
        user_id = uuid.UUID(request.user_id)
        
        # Check if already initialized
        existing_navigation = await UserNavigation.get_by_user_id(db, user_id)
        if existing_navigation:
            logger.info("User already initialized", user_id=str(user_id))
            return {
                "success": True,
                "message": "User already initialized",
                "user_id": str(user_id)
            }
        
        # Create user_navigation record
        navigation = await UserNavigation.create(db=db, user_id=user_id)
        logger.info("User initialized in api-server", user_id=str(user_id))
        
        return {
            "success": True,
            "message": "User initialized successfully",
            "user_id": str(user_id),
            "navigation_id": str(navigation.id)
        }
        
    except ValueError:
        raise HTTPException(status_code=400, detail="Invalid user_id format")
    except Exception as e:
        logger.error("Failed to initialize user", error=str(e), user_id=request.user_id)
        raise HTTPException(status_code=500, detail="Failed to initialize user")
