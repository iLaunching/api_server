"""
Smart Hub Routes
API endpoints for Smart Hub management and current user profile
"""

from typing import Optional, Dict, Any
from fastapi import APIRouter, HTTPException, Depends, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, text
from sqlalchemy.orm import selectinload
import structlog

from config.database import get_db
from auth.middleware import get_current_session
from models.database_models import UserNavigation, SmartHub, OptionValue, ThemeConfig
from models.user import UserProfile

logger = structlog.get_logger()
router = APIRouter()

# ============================================
# Current User Profile & Smart Hub
# ============================================

@router.get("/users/me/current-smart-hub")
async def get_current_smart_hub(
    session: Dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db)
):
    """
    Get current user's active Smart Hub with theme data via relations.
    NO SEARCH - Pure relational traversal for maximum performance.
    
    Relationship Flow:
    1. user_id (from JWT) → UserProfile (user_id FK)
    2. UserProfile → UserNavigation (user_profile_id FK)
    3. UserNavigation → current_smart_hub (current_smart_hub_id FK)
    4. UserProfile → appearance → ThemeConfig (appearance_id FK)
    
    All via direct foreign key relations - O(1) lookups!
    """
    try:
        user_id = session.get("user_id")
        
        if not user_id:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="User ID not found in session"
            )
        
        logger.info("Fetching current smart hub via relationship chain", user_id=user_id)
        
        # Step 1: Get UserProfile with ALL related data via eager loading
        # This loads: user, appearance → theme_config, itheme → theme_config, account_type, avatar_color
        profile_query = (
            select(UserProfile)
            .options(
                # Load user to get first_name and last_name
                selectinload(UserProfile.user),
                
                # Load appearance with theme config
                selectinload(UserProfile.appearance)
                .selectinload(OptionValue.theme_config),
                
                # Load itheme with theme config
                selectinload(UserProfile.itheme)
                .selectinload(OptionValue.theme_config),
                
                # Load account type
                selectinload(UserProfile.account_type),
                
                # Load avatar color with theme config
                selectinload(UserProfile.avatar_color)
                .selectinload(OptionValue.theme_config),
                
                # Load profile icon
                selectinload(UserProfile.profile_icon),
                
                # Load navigation with current smart hub
                selectinload(UserProfile.navigation)
                .selectinload(UserNavigation.current_smart_hub)
            )
            .where(UserProfile.user_id == user_id)
        )
        
        result = await db.execute(profile_query)
        profile = result.scalar_one_or_none()
        
        if not profile:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User profile not found"
            )
        
        logger.info("User profile loaded", 
                   profile_id=str(profile.id),
                   has_navigation=profile.navigation is not None)
        
        # Step 2: Check if navigation exists, if not create it
        navigation = profile.navigation
        
        if not navigation:
            logger.info("Creating user navigation", user_profile_id=str(profile.id))
            navigation = UserNavigation(user_profile_id=profile.id)
            db.add(navigation)
            await db.commit()
            await db.refresh(navigation, ['current_smart_hub'])
            logger.info("User navigation created", navigation_id=str(navigation.id))
        
        # Step 2.5: Load icon metadata if profile has an icon
        icon_metadata = None
        if profile.profile_icon_id:
            icon_result = await db.execute(
                text("""
                    SELECT icon_name, icon_prefix
                    FROM icon_metadata
                    WHERE option_value_id = :icon_id
                """),
                {"icon_id": profile.profile_icon_id}
            )
            icon_row = icon_result.fetchone()
            if icon_row:
                icon_metadata = {"icon_name": icon_row[0], "icon_prefix": icon_row[1]}
        
        # Step 3: Build theme data from appearance + itheme relations (no search!)
        theme_data = None
        if profile.appearance and profile.appearance.theme_config:
            theme_config = profile.appearance.theme_config
            
            theme_data = {
                "header_overlay": theme_config.header_overlay_color,
                "background": theme_config.background_color,
                "text": theme_config.text_color,
                "menu": theme_config.menu_color,
                "border": theme_config.border_line_color,
                "user_button_color": theme_config.user_button_color or "#ffffff59",
                "user_button_hover": theme_config.user_button_hover or "#ffffff66",
                "user_button_icon": theme_config.user_button_icon or "#000000",
                "title_menu_color_light": theme_config.title_menu_color_light or "#d6d6d6",
                "border_line_color_light": theme_config.border_line_color_light or "#d6d6d680",
                "global_button_hover": theme_config.global_button_hover or "#d6d6d64d"
            }
            
            # Add itheme solid_color for MainHeader background
            if profile.itheme and profile.itheme.theme_config:
                itheme_metadata = profile.itheme.theme_config.theme_metadata or {}
                theme_data["header_background"] = itheme_metadata.get("solid_color", "#7F77F1")  # Default to ipurple
                logger.info("Theme data loaded", 
                           appearance_name=profile.appearance.value_name,
                           itheme_name=profile.itheme.value_name,
                           header_bg=theme_data["header_background"])
            else:
                logger.info("Theme data loaded from appearance only", 
                           appearance_name=profile.appearance.value_name)
        
        # Step 4: Build smart hub data from navigation relation (no search!)
        smart_hub_data = None
        if navigation.current_smart_hub:
            hub = navigation.current_smart_hub
            smart_hub_data = {
                "id": str(hub.id),
                "name": hub.name,
                "description": hub.description,
                "avatar": hub.avatar,
                "hub_color": hub.hub_color,
                "owner_id": str(hub.owner_id),
                "is_default": hub.is_default,
                "created_at": hub.created_at.isoformat() if hub.created_at else None,
                "modified_at": hub.modified_at.isoformat() if hub.modified_at else None,
                # TODO: Add team members when team feature is implemented
                "your_role": "owner" if str(hub.owner_id) == str(user_id) else "member",
                "team_members": []  # Placeholder for team members
            }
            logger.info("Smart hub loaded from navigation", 
                       hub_id=str(hub.id),
                       hub_name=hub.name)
        
        logger.info("Current smart hub retrieved successfully", 
                   user_id=user_id,
                   has_hub=smart_hub_data is not None,
                   has_theme=theme_data is not None)
        
        return {
            "smart_hub": smart_hub_data,
            "theme": theme_data,
            "profile": {
                "id": str(profile.id),
                "user_id": str(profile.user_id),
                "first_name": profile.user.first_name if profile.user else "",
                "surname": profile.user.last_name if profile.user else "",
                "timezone": profile.timezone,
                "language": profile.language,
                "onboarding_completed": profile.onboarding_completed,
                "appearance": {
                    "id": profile.appearance.id,
                    "value_name": profile.appearance.value_name,
                    "display_name": profile.appearance.display_name
                } if profile.appearance else None,
                "itheme": {
                    "id": profile.itheme.id,
                    "value_name": profile.itheme.value_name,
                    "display_name": profile.itheme.display_name
                } if profile.itheme else None,
                "avatar_color": {
                    "id": profile.avatar_color.id,
                    "value_name": profile.avatar_color.value_name,
                    "display_name": profile.avatar_color.display_name,
                    "color": profile.avatar_color.theme_config.theme_metadata.get("color", "#4361EE") if profile.avatar_color.theme_config and profile.avatar_color.theme_config.theme_metadata else "#4361EE"
                } if profile.avatar_color else None,
                "avatar_display_option_value_id": profile.avatar_display_option_value_id,
                "profile_icon": {
                    "id": profile.profile_icon.id,
                    "value_name": profile.profile_icon.value_name,
                    "display_name": profile.profile_icon.display_name,
                    "icon_name": icon_metadata["icon_name"] if icon_metadata else None,
                    "icon_prefix": icon_metadata["icon_prefix"] if icon_metadata else None
                } if profile.profile_icon and icon_metadata else None
            }
        }
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Failed to get current smart hub", 
                    user_id=session.get("user_id"), 
                    error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve current Smart Hub"
        )


@router.get("/users/me/profile")
async def get_current_user_profile(
    session: Dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db)
):
    """
    Get current user's profile with all relations.
    Simpler endpoint that just returns profile data without Smart Hub.
    """
    try:
        user_id = session.get("user_id")
        
        if not user_id:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="User ID not found in session"
            )
        
        logger.info("Fetching user profile", user_id=user_id)
        
        # Get user profile with eager loading
        query = (
            select(UserProfile)
            .options(
                selectinload(UserProfile.appearance).selectinload(OptionValue.theme_config),
                selectinload(UserProfile.itheme).selectinload(OptionValue.theme_config),
                selectinload(UserProfile.account_type)
            )
            .where(UserProfile.user_id == user_id)
        )
        
        result = await db.execute(query)
        profile = result.scalar_one_or_none()
        
        if not profile:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User profile not found"
            )
        
        # Build theme data
        theme_data = None
        if profile.appearance and profile.appearance.theme_config:
            theme_config = profile.appearance.theme_config
            theme_data = {
                "header_overlay": theme_config.header_overlay_color,
                "background": theme_config.background_color,
                "text": theme_config.text_color,
                "menu": theme_config.menu_color,
                "border": theme_config.border_line_color
            }
        
        return {
            "profile": profile.to_dict(),
            "theme": theme_data
        }
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Failed to get user profile", 
                    user_id=session.get("user_id"), 
                    error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to retrieve user profile"
        )


@router.post("/smart-hubs/{hub_id}/switch")
async def switch_smart_hub(
    hub_id: str,
    session: Dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db)
):
    """
    Switch to a different Smart Hub (instant context switch).
    Updates user_navigation.current_smart_hub_id - ONE update, no search!
    """
    try:
        user_id = session.get("user_id")
        
        if not user_id:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="User ID not found in session"
            )
        
        logger.info("Switching smart hub", user_id=user_id, hub_id=hub_id)
        
        # Verify hub exists and user has access (owner check for now)
        hub_query = select(SmartHub).where(
            SmartHub.id == hub_id,
            SmartHub.owner_id == user_id,
            SmartHub.is_active == True
        )
        
        hub_result = await db.execute(hub_query)
        hub = hub_result.scalar_one_or_none()
        
        if not hub:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Access denied to this Smart Hub or hub not found"
            )
        
        # Get user profile
        profile_query = select(UserProfile).where(UserProfile.user_id == user_id)
        profile_result = await db.execute(profile_query)
        profile = profile_result.scalar_one_or_none()
        
        if not profile:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User profile not found"
            )
        
        # Get or create navigation
        nav_query = select(UserNavigation).where(
            UserNavigation.user_profile_id == profile.id
        )
        nav_result = await db.execute(nav_query)
        navigation = nav_result.scalar_one_or_none()
        
        if not navigation:
            navigation = UserNavigation(
                user_profile_id=profile.id,
                current_smart_hub_id=hub_id
            )
            db.add(navigation)
        else:
            navigation.current_smart_hub_id = hub_id
        
        await db.commit()
        
        logger.info("Smart hub switched successfully", 
                   user_id=user_id, 
                   hub_id=hub_id)
        
        return {
            "message": "Smart Hub switched successfully",
            "smart_hub_id": hub_id,
            "smart_hub_name": hub.name
        }
        
    except HTTPException:
        raise
    except Exception as e:
        await db.rollback()
        logger.error("Failed to switch smart hub", 
                    user_id=session.get("user_id"), 
                    hub_id=hub_id,
                    error=str(e))
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to switch Smart Hub"
        )


@router.patch("/profile/avatar-color")
async def update_avatar_color(
    avatar_color_id: int,
    session: Dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db)
):
    """
    Update user's avatar color
    """
    try:
        user_id = session.get("user_id")
        
        if not user_id:
            logger.error("No user_id in session")
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="User ID not found in session"
            )
        
        logger.info("=== UPDATING AVATAR COLOR ===", user_id=user_id, avatar_color_id=avatar_color_id)
        
        # Update the avatar_color_id directly using SQL
        update_query = text("""
            UPDATE user_profiles 
            SET avatar_color_id = :avatar_color_id 
            WHERE user_id = :user_id
        """)
        
        result = await db.execute(
            update_query,
            {"avatar_color_id": avatar_color_id, "user_id": user_id}
        )
        
        logger.info("Update executed", rowcount=result.rowcount)
        
        if result.rowcount == 0:
            logger.error("No rows updated - profile not found", user_id=user_id)
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User profile not found"
            )
        
        await db.commit()
        
        logger.info("=== AVATAR COLOR UPDATED SUCCESSFULLY ===", user_id=user_id, avatar_color_id=avatar_color_id)
        
        return {
            "message": "Avatar color updated successfully",
            "avatar_color_id": avatar_color_id,
            "user_id": user_id
        }
        
    except HTTPException:
        raise
    except Exception as e:
        await db.rollback()
        logger.error("=== FAILED TO UPDATE AVATAR COLOR ===", 
                    user_id=session.get("user_id"), 
                    avatar_color_id=avatar_color_id,
                    error=str(e),
                    error_type=type(e).__name__)
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to update avatar color: {str(e)}"
        )


@router.patch("/profile/icon")
async def update_profile_icon(
    profile_icon_id: int,
    session: Dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db)
):
    """
    Update user's profile icon
    """
    try:
        user_id = session.get("user_id")
        
        if not user_id:
            logger.error("No user_id in session")
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="User ID not found in session"
            )
        
        logger.info("=== UPDATING PROFILE ICON ===", user_id=user_id, profile_icon_id=profile_icon_id)
        
        # Update the profile_icon_id and set avatar_display_option to 'icon' (ID: 26)
        update_query = text("""
            UPDATE user_profiles 
            SET profile_icon_id = :profile_icon_id,
                avatar_display_option_value_id = 26
            WHERE user_id = :user_id
        """)
        
        result = await db.execute(
            update_query,
            {"profile_icon_id": profile_icon_id, "user_id": user_id}
        )
        
        logger.info("Update executed", rowcount=result.rowcount)
        
        if result.rowcount == 0:
            logger.error("No rows updated - profile not found", user_id=user_id)
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User profile not found"
            )
        
        await db.commit()
        
        logger.info("=== PROFILE ICON UPDATED SUCCESSFULLY ===", user_id=user_id, profile_icon_id=profile_icon_id)
        
        return {
            "message": "Profile icon updated successfully",
            "profile_icon_id": profile_icon_id,
            "user_id": user_id
        }
        
    except HTTPException:
        raise
    except Exception as e:
        await db.rollback()
        logger.error("=== FAILED TO UPDATE PROFILE ICON ===", 
                    user_id=session.get("user_id"), 
                    profile_icon_id=profile_icon_id,
                    error=str(e),
                    error_type=type(e).__name__)
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to update profile icon: {str(e)}"
        )


@router.delete("/profile/icon")
async def clear_profile_icon(
    session: Dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db)
):
    """
    Clear user's profile icon and reset to default avatar display
    """
    try:
        user_id = session.get("user_id")
        
        if not user_id:
            logger.error("No user_id in session")
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="User ID not found in session"
            )
        
        logger.info("=== CLEARING PROFILE ICON ===", user_id=user_id)
        
        # Clear profile_icon_id and set avatar_display_option to 'default' (ID: 24)
        update_query = text("""
            UPDATE user_profiles 
            SET profile_icon_id = NULL,
                avatar_display_option_value_id = 24
            WHERE user_id = :user_id
        """)
        
        result = await db.execute(
            update_query,
            {"user_id": user_id}
        )
        
        logger.info("Update executed", rowcount=result.rowcount)
        
        if result.rowcount == 0:
            logger.error("No rows updated - profile not found", user_id=user_id)
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User profile not found"
            )
        
        await db.commit()
        
        logger.info("=== PROFILE ICON CLEARED SUCCESSFULLY ===", user_id=user_id)
        
        return {
            "message": "Profile icon cleared successfully",
            "user_id": user_id
        }
        
    except HTTPException:
        raise
    except Exception as e:
        await db.rollback()
        logger.error("=== FAILED TO CLEAR PROFILE ICON ===", 
                    user_id=session.get("user_id"), 
                    error=str(e),
                    error_type=type(e).__name__)
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to clear profile icon: {str(e)}"
        )
