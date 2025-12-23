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
from sqlalchemy import select
import structlog

logger = structlog.get_logger()

# Bearer token security
security = HTTPBearer(auto_error=False)

# Auth API URL
AUTH_API_URL = os.getenv("AUTH_API_URL", "https://ilaunching-servers-production-auth.up.railway.app")

async def get_current_session(credentials: Optional[HTTPAuthorizationCredentials] = Depends(security)) -> Dict:
    """
    Validate JWT token with auth-api and return user session data.
    This calls the auth-api /api/auth/me endpoint to validate the token.
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
            logger.info("Token validated successfully", user_id=user_data["user"]["id"])
            
            # Check if account is marked for deletion
            from config.database import get_db
            from models.user import User
            
            user_id = user_data["user"]["id"]
            async for db in get_db():
                result = await db.execute(
                    select(User).where(User.id == user_id)
                )
                user = result.scalar_one_or_none()
                
                if user and user.is_deleted:
                    logger.warning("Access blocked - account marked for deletion", user_id=user_id)
                    raise HTTPException(
                        status_code=403,
                        detail="Account is scheduled for deletion and access has been revoked",
                    )
                break
            
            # Return session data with user_id and token
            return {
                "user_id": user_data["user"]["id"],
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