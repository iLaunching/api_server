"""
Authentication and session management middleware.
"""

import os
import uuid
import httpx
from datetime import datetime, timedelta
from typing import Optional, Dict
from fastapi import HTTPException, Depends, Request
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from sqlalchemy.ext.asyncio import AsyncSession
import structlog

from config.database import get_db
from models.user_navigation import UserNavigation

logger = structlog.get_logger()

# Bearer token security
security = HTTPBearer(auto_error=False)

# Auth API URL
AUTH_API_URL = os.getenv("AUTH_API_URL", "https://ilaunching-servers-production-auth.up.railway.app")

async def get_current_session(
    credentials: Optional[HTTPAuthorizationCredentials] = Depends(security),
    db: AsyncSession = Depends(get_db)
) -> Dict:
    """
    Validate JWT token with auth-api and return user session data.
    Creates user_navigation record on first API access (part of signup flow).
    """
    
    if not credentials:
        logger.warning("No authorization credentials provided")
        raise HTTPException(
            status_code=401,
            detail="Missing authorization token",
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    token = credentials.credentials
    logger.info("Validating token with auth-api", auth_api_url=AUTH_API_URL)
    
    # Validate token with auth-api
    try:
        async with httpx.AsyncClient() as client:
            response = await client.get(
                f"{AUTH_API_URL}/api/v1/auth/me",
                headers={"Authorization": f"Bearer {token}"},
                timeout=5.0
            )
            
            logger.info("Auth API response", status=response.status_code)
            
            if response.status_code == 401:
                logger.warning("Token validation failed - 401 from auth-api")
                raise HTTPException(
                    status_code=401,
                    detail="Invalid or expired token",
                    headers={"WWW-Authenticate": "Bearer"},
                )
            
            if response.status_code != 200:
                logger.error("Auth API error", status=response.status_code, response=response.text)
                raise HTTPException(
                    status_code=401,
                    detail="Failed to validate token",
                    headers={"WWW-Authenticate": "Bearer"},
                )
            
            user_data = response.json()
            user_id = uuid.UUID(user_data["user"]["id"])
            logger.info("Token validated successfully", user_id=str(user_id))
            
            # Create user_navigation record if it doesn't exist (on first API access after signup)
            navigation = await UserNavigation.get_by_user_id(db, user_id)
            if not navigation:
                navigation = await UserNavigation.create(db=db, user_id=user_id)
                logger.info("User navigation created on first API access", user_id=str(user_id))
            
            # Return session data with user_id and token
            return {
                "user_id": str(user_id),
                "email": user_data["user"]["email"],
                "first_name": user_data["user"].get("first_name"),
                "last_name": user_data["user"].get("last_name"),
                "access_token": token,  # Include token for subsequent API calls
            }
            
    except httpx.TimeoutException:
        logger.error("Auth API timeout")
        raise HTTPException(
            status_code=503,
            detail="Authentication service unavailable",
        )
    except httpx.RequestError as e:
        logger.error("Auth API request error", error=str(e))
        raise HTTPException(
            status_code=503,
            detail="Authentication service unavailable",
        )
    except Exception as e:
        logger.error("Unexpected auth error", error=str(e))
        raise HTTPException(
            status_code=401,
            detail="Authentication failed",
        )

def validate_bubble_request(request: Request) -> bool:
    """
    Validate that the request is coming from a Bubble app.
    This is a basic validation - enhance with proper API keys in production.
    """
    
    # Check for Bubble-specific headers
    user_agent = request.headers.get("user-agent", "")
    referer = request.headers.get("referer", "")
    origin = request.headers.get("origin", "")
    
    # Allow requests from Bubble domains
    bubble_domains = [
        "bubbleapps.io",
        "localhost",  # For development
        "127.0.0.1"   # For local testing
    ]
    
    # Check if request is from a valid domain
    for domain in bubble_domains:
        if domain in referer or domain in origin:
            return True
    
    # Allow if no origin/referer (API testing tools)
    if not referer and not origin:
        return True
    
    return False

async def validate_api_key(
    request: Request,
    credentials: Optional[HTTPAuthorizationCredentials] = Depends(security)
) -> bool:
    """
    Validate API key for production use.
    Currently disabled for development - enable in production.
    """
    
    # Get API key from environment
    valid_api_key = os.getenv("API_KEY")
    
    # Skip validation if no API key is set (development mode)
    if not valid_api_key:
        return True
    
    # Check for API key in Authorization header
    if credentials:
        provided_key = credentials.credentials
        if provided_key == valid_api_key:
            return True
    
    # Check for API key in custom header
    api_key_header = request.headers.get("X-API-Key")
    if api_key_header == valid_api_key:
        return True
    
    # Check for API key in query parameter
    api_key_param = request.query_params.get("api_key")
    if api_key_param == valid_api_key:
        return True
    
    return False