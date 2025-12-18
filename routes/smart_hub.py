"""
Smart Hub Routes
API endpoints for Smart Hub management and current user profile
"""

from typing import Optional, Dict, Any
from fastapi import APIRouter, HTTPException, Depends, status, UploadFile, File
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, text
from sqlalchemy.orm import selectinload
import structlog
import os
import uuid
from pathlib import Path

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
                
                # Load smart hubs with hub colors and icons
                selectinload(UserProfile.smart_hubs)
                .selectinload(SmartHub.hub_color)
                .selectinload(OptionValue.theme_config),
                
                selectinload(UserProfile.smart_hubs)
                .selectinload(SmartHub.smartHub_icon),
                
                # Load navigation with current smart hub and its hub_color and icon relationships
                selectinload(UserProfile.navigation)
                .selectinload(UserNavigation.current_smart_hub)
                .selectinload(SmartHub.hub_color)
                .selectinload(OptionValue.theme_config),
                
                selectinload(UserProfile.navigation)
                .selectinload(UserNavigation.current_smart_hub)
                .selectinload(SmartHub.smartHub_icon)
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
            appearance_metadata = theme_config.theme_metadata or {}
            
            theme_data = {
                "header_overlay": theme_config.header_overlay_color,
                "background": theme_config.background_color,
                "text": theme_config.text_color,
                "appearance_text_color": theme_config.text_color,  # Add explicit appearance_text_color
                "menu": theme_config.menu_color,
                "border": theme_config.border_line_color,
                "user_button_color": theme_config.user_button_color or "#ffffff59",
                "user_button_hover": theme_config.user_button_hover or "#ffffff66",
                "user_button_icon": theme_config.user_button_icon or "#000000",
                "title_menu_color_light": theme_config.title_menu_color_light or "#d6d6d6",
                "border_line_color_light": theme_config.border_line_color_light or "#d6d6d680",
                "global_button_hover": theme_config.global_button_hover or "#d6d6d64d",
                "chat_bk_1": theme_config.chat_bk_1,  # Chat background gradient
                "prompt_bk": theme_config.prompt_bk,  # Prompt background color
                "prompt_text_color": theme_config.prompt_text_color,  # Prompt text color
                "ai_acknowledge_text_color": theme_config.ai_acknowledge_text_color,  # AI acknowledgment text color
                # Add appearance theme metadata properties
                "feedback_indicator_bk": appearance_metadata.get("feedback_indicator_bk", "#7F77F1")
            }
            
            # Add itheme solid_color for MainHeader background
            if profile.itheme and profile.itheme.theme_config:
                itheme_metadata = profile.itheme.theme_config.theme_metadata or {}
                solid_color_value = itheme_metadata.get("solid_color", "#7F77F1")
                theme_data["header_background"] = solid_color_value  # Default to ipurple
                theme_data["solid_color"] = solid_color_value  # Add solid_color for frontend components
                theme_data["bg_opacity"] = itheme_metadata.get("bg_opacity", "#7F77F125")
                theme_data["tone_button_bk_color"] = itheme_metadata.get("toneButton_bk_color", "#7F77F166")
                theme_data["tone_button_text_color"] = itheme_metadata.get("toneButton_text_color", "#6B63DD")
                theme_data["tone_button_border_color"] = itheme_metadata.get("toneButton_border_color", "#6B63DD")
                theme_data["button_bk_color"] = itheme_metadata.get("button_bk_color", "#7F77F1")
                theme_data["button_text_color"] = itheme_metadata.get("button_text_color", "#ffffff")
                theme_data["button_hover_color"] = itheme_metadata.get("button_hover_color", "#6B63DD")
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
            
            # Extract hub color from relationship (same pattern as avatar_color)
            hub_color = "#7F77F1"  # Default purple
            try:
                if hub.hub_color and hasattr(hub.hub_color, 'theme_config') and hub.hub_color.theme_config:
                    if hub.hub_color.theme_config.theme_metadata:
                        hub_color = hub.hub_color.theme_config.theme_metadata.get("color", "#7F77F1")
                    logger.info("Hub color loaded from relationship", hub_color=hub_color)
                else:
                    logger.info("Using default hub color", hub_color_id=hub.hub_color_id)
            except Exception as e:
                logger.warning("Failed to load hub color from relationship, using default", error=str(e), hub_color_id=hub.hub_color_id)
            
            # Extract hub icon metadata from icon_metadata table (same as profile icons)
            hub_icon_metadata = None
            logger.info("Checking hub icon relationship", 
                       smartHub_icon_id=hub.smartHub_icon_id,
                       has_smartHub_icon=hub.smartHub_icon is not None)
            
            if hub.smartHub_icon_id:
                try:
                    # Query icon_metadata table for icon details
                    icon_result = await db.execute(
                        text("""
                            SELECT icon_name, icon_prefix
                            FROM icon_metadata
                            WHERE option_value_id = :icon_id
                        """),
                        {"icon_id": hub.smartHub_icon_id}
                    )
                    icon_row = icon_result.fetchone()
                    if icon_row:
                        hub_icon_metadata = {
                            'icon_name': icon_row[0],
                            'icon_prefix': icon_row[1]
                        }
                        logger.info("Hub icon loaded from icon_metadata table", 
                                   icon_name=icon_row[0],
                                   icon_prefix=icon_row[1])
                    else:
                        logger.warning("No icon_metadata found for smartHub_icon_id", 
                                     smartHub_icon_id=hub.smartHub_icon_id)
                except Exception as e:
                    logger.error("Failed to load hub icon metadata from icon_metadata table", 
                               error=str(e),
                               smartHub_icon_id=hub.smartHub_icon_id)
            
            smart_hub_data = {
                "id": str(hub.id),
                "name": hub.name,
                "description": hub.description,
                "avatar": hub.avatar,
                "hub_color": hub_color,
                "hub_color_id": hub.hub_color_id,
                "smartHub_icon_id": hub.smartHub_icon_id,
                "avatar_display_option_value_id": hub.avatar_display_option_value_id,
                "smartHub_icon": {
                    "id": hub.smartHub_icon.id,
                    "value_name": hub.smartHub_icon.value_name,
                    "display_name": hub.smartHub_icon.display_name,
                    "icon_name": hub_icon_metadata.get("icon_name") if hub_icon_metadata else None,
                    "icon_prefix": hub_icon_metadata.get("icon_prefix") if hub_icon_metadata else None
                } if hub.smartHub_icon and hub_icon_metadata else None,
                "journey": hub.journey or "Validate Journey",  # Per-hub journey tier
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
                       hub_name=hub.name,
                       hub_color=hub_color)
        
        logger.info("Current smart hub retrieved successfully", 
                   user_id=user_id,
                   has_hub=smart_hub_data is not None,
                   has_theme=theme_data is not None)
        
        # Build smart hubs list with colors
        smart_hubs_list = []
        if profile.smart_hubs:
            for hub in profile.smart_hubs:
                hub_color_value = None
                if hub.hub_color and hub.hub_color.theme_config:
                    try:
                        hub_color_value = hub.hub_color.theme_config.theme_metadata.get("color")
                    except Exception as e:
                        logger.warning("Failed to extract hub color", hub_id=str(hub.id), error=str(e))
                
                smart_hubs_list.append({
                    "id": str(hub.id),
                    "name": hub.name,
                    "hub_color_id": hub.hub_color_id,
                    "color": hub_color_value,
                    "journey": hub.journey or "Validate Journey"
                })
        
        logger.info("Smart hubs loaded", count=len(smart_hubs_list))
        
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
                "smart_hubs": smart_hubs_list,
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


@router.patch("/profile/appearance")
async def update_appearance(
    appearance_id: int,
    session: Dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db)
):
    """
    Update user's appearance theme
    """
    try:
        user_id = session.get("user_id")
        
        if not user_id:
            logger.error("No user_id in session")
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="User ID not found in session"
            )
        
        logger.info("=== UPDATING APPEARANCE ===", user_id=user_id, appearance_id=appearance_id)
        
        # Update the appearance_id directly using SQL
        update_query = text("""
            UPDATE user_profiles 
            SET appearance_id = :appearance_id 
            WHERE user_id = :user_id
        """)
        
        result = await db.execute(
            update_query,
            {"appearance_id": appearance_id, "user_id": user_id}
        )
        
        logger.info("Update executed", rowcount=result.rowcount)
        
        if result.rowcount == 0:
            logger.error("No rows updated - profile not found", user_id=user_id)
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User profile not found"
            )
        
        await db.commit()
        
        logger.info("=== APPEARANCE UPDATED SUCCESSFULLY ===", user_id=user_id, appearance_id=appearance_id)
        
        return {
            "message": "Appearance updated successfully",
            "appearance_id": appearance_id,
            "user_id": user_id
        }
        
    except HTTPException:
        raise
    except Exception as e:
        await db.rollback()
        logger.error("=== FAILED TO UPDATE APPEARANCE ===", 
                    user_id=session.get("user_id"), 
                    appearance_id=appearance_id,
                    error=str(e),
                    error_type=type(e).__name__)
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to update appearance: {str(e)}"
        )


@router.patch("/profile/itheme")
async def update_user_itheme(
    itheme_id: int,
    session: Dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db)
):
    """
    Update user's iTheme preference
    """
    try:
        user_id = session.get("user_id")
        
        if not user_id:
            logger.error("No user_id in session")
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="User ID not found in session"
            )
        
        logger.info("=== UPDATING ITHEME ===", user_id=user_id, itheme_id=itheme_id)
        
        # Update the user's itheme_id in their profile
        update_query = text("""
            UPDATE user_profiles
            SET itheme_id = :itheme_id
            WHERE user_id = :user_id
            RETURNING user_id
        """)
        
        result = await db.execute(
            update_query,
            {"itheme_id": itheme_id, "user_id": user_id}
        )
        
        updated_user = result.fetchone()
        
        if not updated_user:
            logger.error("User profile not found", user_id=user_id)
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User profile not found"
            )
        
        await db.commit()
        
        logger.info("=== ITHEME UPDATED SUCCESSFULLY ===", user_id=user_id, itheme_id=itheme_id)
        
        return {
            "message": "iTheme updated successfully",
            "itheme_id": itheme_id,
            "user_id": user_id
        }
        
    except HTTPException:
        raise
    except Exception as e:
        await db.rollback()
        logger.error("=== FAILED TO UPDATE ITHEME ===", 
                    user_id=session.get("user_id"), 
                    itheme_id=itheme_id,
                    error=str(e),
                    error_type=type(e).__name__)
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to update itheme: {str(e)}"
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


@router.patch("/smart-hub/color")
async def update_smart_hub_color(
    smart_hub_id: str,
    hub_color_id: int,
    session: Dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db)
):
    """
    Update a smart hub's color scheme - Direct access, no searching
    """
    try:
        user_id = session.get("user_id")
        
        if not user_id:
            logger.error("No user_id in session")
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="User ID not found in session"
            )
        
        logger.info("=== UPDATING SMART HUB COLOR ===", 
                   user_id=user_id,
                   smart_hub_id=smart_hub_id,
                   hub_color_id=hub_color_id)
        
        # Verify the color option exists
        color_query = select(OptionValue).where(
            OptionValue.id == hub_color_id
        )
        color_result = await db.execute(color_query)
        color_option = color_result.scalar_one_or_none()
        
        if not color_option:
            logger.error("Invalid hub_color_id", hub_color_id=hub_color_id)
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Invalid hub color ID: {hub_color_id}"
            )
        
        # Direct update - no navigation search needed
        update_query = text("""
            UPDATE smart_hubs 
            SET hub_color_id = :hub_color_id
            WHERE id = :smart_hub_id
        """)
        
        result = await db.execute(
            update_query,
            {
                "hub_color_id": hub_color_id,
                "smart_hub_id": smart_hub_id
            }
        )
        
        logger.info("Update executed", rowcount=result.rowcount)
        
        if result.rowcount == 0:
            logger.error("No rows updated - smart hub not found", 
                        smart_hub_id=smart_hub_id)
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Smart hub not found"
            )
        
        await db.commit()
        
        logger.info("=== SMART HUB COLOR UPDATED SUCCESSFULLY ===", 
                   user_id=user_id,
                   smart_hub_id=smart_hub_id,
                   hub_color_id=hub_color_id)
        
        return {
            "message": "Smart hub color updated successfully",
            "smart_hub_id": smart_hub_id,
            "hub_color_id": hub_color_id
        }
        
    except HTTPException:
        raise
    except Exception as e:
        await db.rollback()
        logger.error("=== FAILED TO UPDATE SMART HUB COLOR ===", 
                    user_id=session.get("user_id"), 
                    hub_color_id=hub_color_id,
                    error=str(e),
                    error_type=type(e).__name__)
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to update smart hub color: {str(e)}"
        )


@router.patch("/smart-hub/icon")
async def update_smart_hub_icon(
    smart_hub_id: str,
    smartHub_icon_id: int,
    session: Dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db)
):
    """
    Update smart hub's icon - Direct access with smart_hub_id
    """
    try:
        user_id = session.get("user_id")
        
        if not user_id:
            logger.error("No user_id in session")
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="User ID not found in session"
            )
        
        logger.info("=== UPDATING SMART HUB ICON ===", 
                   user_id=user_id,
                   smart_hub_id=smart_hub_id,
                   smartHub_icon_id=smartHub_icon_id)
        
        # Update the smarthub_icon_id and set avatar_display_option to 'icon' (ID: 26)
        update_query = text("""
            UPDATE smart_hubs 
            SET smarthub_icon_id = :smartHub_icon_id,
                avatar_display_option_value_id = 26
            WHERE id = :smart_hub_id
        """)
        
        result = await db.execute(
            update_query,
            {
                "smartHub_icon_id": smartHub_icon_id,
                "smart_hub_id": smart_hub_id
            }
        )
        
        logger.info("Update executed", rowcount=result.rowcount)
        
        if result.rowcount == 0:
            logger.error("No rows updated - smart hub not found", smart_hub_id=smart_hub_id)
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Smart hub not found"
            )
        
        await db.commit()
        
        logger.info("=== SMART HUB ICON UPDATED SUCCESSFULLY ===", 
                   user_id=user_id,
                   smart_hub_id=smart_hub_id,
                   smartHub_icon_id=smartHub_icon_id)
        
        return {
            "message": "Smart hub icon updated successfully",
            "smart_hub_id": smart_hub_id,
            "smartHub_icon_id": smartHub_icon_id
        }
        
    except HTTPException:
        raise
    except Exception as e:
        await db.rollback()
        logger.error("=== FAILED TO UPDATE SMART HUB ICON ===", 
                    user_id=session.get("user_id"),
                    smart_hub_id=smart_hub_id,
                    smartHub_icon_id=smartHub_icon_id,
                    error=str(e),
                    error_type=type(e).__name__)
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to update smart hub icon: {str(e)}"
        )


@router.delete("/smart-hub/icon")
async def clear_smart_hub_icon(
    smart_hub_id: str,
    session: Dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db)
):
    """
    Clear smart hub's icon and reset to default avatar display - Direct access with smart_hub_id
    """
    try:
        user_id = session.get("user_id")
        
        if not user_id:
            logger.error("No user_id in session")
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="User ID not found in session"
            )
        
        logger.info("=== CLEARING SMART HUB ICON ===", 
                   user_id=user_id,
                   smart_hub_id=smart_hub_id)
        
        # Clear smarthub_icon_id and set avatar_display_option to 'default' (ID: 24)
        update_query = text("""
            UPDATE smart_hubs 
            SET smarthub_icon_id = NULL,
                avatar_display_option_value_id = 24
            WHERE id = :smart_hub_id
        """)
        
        result = await db.execute(
            update_query,
            {"smart_hub_id": smart_hub_id}
        )
        
        logger.info("Update executed", rowcount=result.rowcount)
        
        if result.rowcount == 0:
            logger.error("No rows updated - smart hub not found", smart_hub_id=smart_hub_id)
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Smart hub not found"
            )
        
        await db.commit()
        
        logger.info("=== SMART HUB ICON CLEARED SUCCESSFULLY ===", 
                   user_id=user_id,
                   smart_hub_id=smart_hub_id)
        
        return {
            "message": "Smart hub icon cleared successfully",
            "smart_hub_id": smart_hub_id
        }
        
    except HTTPException:
        raise
    except Exception as e:
        await db.rollback()
        logger.error("=== FAILED TO CLEAR SMART HUB ICON ===", 
                    user_id=session.get("user_id"),
                    smart_hub_id=smart_hub_id,
                    error=str(e),
                    error_type=type(e).__name__)
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to clear smart hub icon: {str(e)}"
        )


# ============================================
# Avatar Upload Endpoints
# ============================================

@router.post("/profile/avatar")
async def upload_profile_avatar(
    avatar: UploadFile = File(...),
    session: Dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db)
):
    """
    Upload user profile avatar image
    
    - Accepts image file upload
    - Stores file with unique filename
    - Updates user profile avatar_url
    - Sets avatar display mode to 'custom' (ID: 25)
    """
    try:
        user_id = session.get("user_id")
        if not user_id:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="User ID not found in session"
            )
        
        # Validate file type
        if not avatar.content_type or not avatar.content_type.startswith('image/'):
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="File must be an image"
            )
        
        # Create uploads directory if it doesn't exist
        upload_dir = Path("uploads/avatars")
        upload_dir.mkdir(parents=True, exist_ok=True)
        
        # Generate unique filename
        file_extension = Path(avatar.filename).suffix if avatar.filename else '.jpg'
        unique_filename = f"{uuid.uuid4()}{file_extension}"
        file_path = upload_dir / unique_filename
        
        # Save file
        contents = await avatar.read()
        with open(file_path, 'wb') as f:
            f.write(contents)
        
        # Update user profile
        result = await db.execute(
            select(UserProfile)
            .where(UserProfile.user_id == user_id)
        )
        profile = result.scalar_one_or_none()
        
        if not profile:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User profile not found"
            )
        
        # Update avatar_url and set display mode to custom (25)
        profile.avatar_url = f"/uploads/avatars/{unique_filename}"
        profile.avatar_display_option_value_id = 25  # 'custom' display mode
        
        await db.commit()
        
        logger.info("=== PROFILE AVATAR UPLOADED ===",
                   user_id=user_id,
                   filename=unique_filename,
                   avatar_url=profile.avatar_url)
        
        return {
            "message": "Avatar uploaded successfully",
            "avatar_url": profile.avatar_url
        }
        
    except HTTPException:
        raise
    except Exception as e:
        await db.rollback()
        logger.error("=== FAILED TO UPLOAD PROFILE AVATAR ===",
                    user_id=session.get("user_id"),
                    error=str(e),
                    error_type=type(e).__name__)
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to upload avatar: {str(e)}"
        )


@router.post("/smart-hub/avatar")
async def upload_smart_hub_avatar(
    smart_hub_id: int,
    avatar: UploadFile = File(...),
    session: Dict = Depends(get_current_session),
    db: AsyncSession = Depends(get_db)
):
    """
    Upload smart hub avatar image
    
    - Accepts image file upload
    - Stores file with unique filename
    - Updates smart hub avatar_url
    - Sets avatar display mode to 'custom' (ID: 25)
    """
    try:
        user_id = session.get("user_id")
        if not user_id:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="User ID not found in session"
            )
        
        # Verify smart hub exists and belongs to user
        result = await db.execute(
            select(SmartHub)
            .where(SmartHub.id == smart_hub_id)
            .where(SmartHub.user_id == user_id)
        )
        smart_hub = result.scalar_one_or_none()
        
        if not smart_hub:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Smart hub not found or access denied"
            )
        
        # Validate file type
        if not avatar.content_type or not avatar.content_type.startswith('image/'):
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="File must be an image"
            )
        
        # Create uploads directory if it doesn't exist
        upload_dir = Path("uploads/smart-hub-avatars")
        upload_dir.mkdir(parents=True, exist_ok=True)
        
        # Generate unique filename
        file_extension = Path(avatar.filename).suffix if avatar.filename else '.jpg'
        unique_filename = f"{uuid.uuid4()}{file_extension}"
        file_path = upload_dir / unique_filename
        
        # Save file
        contents = await avatar.read()
        with open(file_path, 'wb') as f:
            f.write(contents)
        
        # Update smart hub avatar and set display mode to custom (25)
        smart_hub.avatar = f"/uploads/smart-hub-avatars/{unique_filename}"
        smart_hub.avatar_display_option_value_id = 25  # 'custom' display mode
        
        await db.commit()
        
        logger.info("=== SMART HUB AVATAR UPLOADED ===",
                   user_id=user_id,
                   smart_hub_id=smart_hub_id,
                   filename=unique_filename,
                   avatar_url=smart_hub.avatar)
        
        return {
            "message": "Smart hub avatar uploaded successfully",
            "smart_hub_id": smart_hub_id,
            "avatar_url": smart_hub.avatar
        }
        
    except HTTPException:
        raise
    except Exception as e:
        await db.rollback()
        logger.error("=== FAILED TO UPLOAD SMART HUB AVATAR ===",
                    user_id=session.get("user_id"),
                    smart_hub_id=smart_hub_id,
                    error=str(e),
                    error_type=type(e).__name__)
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to upload smart hub avatar: {str(e)}"
        )

