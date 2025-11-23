"""
Appearance Configuration Routes
API endpoints for theme management and configuration
"""

from typing import List, Dict, Any, Optional
from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel, Field
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, text
import structlog

from config.database import get_db
from services.appearance_cache import appearance_cache, get_user_theme_colors, get_available_themes
from models.database_models import OptionSet, OptionValue, ThemeConfig

logger = structlog.get_logger()
router = APIRouter()

# ============================================
# Request/Response Models
# ============================================

class ThemeColorsResponse(BaseModel):
    """Response model for theme colors"""
    theme_name: str
    text_color: str
    background_color: str
    menu_color: str
    border_line_color: str

class ThemeResponse(BaseModel):
    """Response model for full theme information"""
    option_value_id: int
    value_name: str
    display_name: str
    theme_name: str
    sort_order: int
    colors: ThemeColorsResponse

class UpdateThemeColorsRequest(BaseModel):
    """Request model for updating theme colors"""
    text_color: str = Field(..., regex=r'^#[0-9A-Fa-f]{6}$', description="Hex color code")
    background_color: str = Field(..., regex=r'^#[0-9A-Fa-f]{6}$', description="Hex color code")
    menu_color: str = Field(..., regex=r'^#[0-9A-Fa-f]{6}$', description="Hex color code")
    border_line_color: str = Field(..., regex=r'^#[0-9A-Fa-f]{6}$', description="Hex color code")

# ============================================
# Theme Routes
# ============================================

@router.get("/themes", response_model=List[ThemeResponse])
async def get_all_themes():
    """Get all available appearance themes"""
    try:
        themes = await get_available_themes()
        
        response_themes = []
        for theme in themes:
            if theme.get('text_color'):  # Only include themes with color configuration
                response_themes.append(ThemeResponse(
                    option_value_id=theme['option_value_id'],
                    value_name=theme['value_name'],
                    display_name=theme['display_name'],
                    theme_name=theme['theme_name'],
                    sort_order=theme['sort_order'],
                    colors=ThemeColorsResponse(
                        theme_name=theme['theme_name'],
                        text_color=theme['text_color'],
                        background_color=theme['background_color'],
                        menu_color=theme['menu_color'],
                        border_line_color=theme['border_line_color']
                    )
                ))
        
        return response_themes
        
    except Exception as e:
        logger.error("Failed to get themes", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to retrieve themes")

@router.get("/themes/{theme_name}/colors", response_model=ThemeColorsResponse)
async def get_theme_colors(theme_name: str):
    """Get color configuration for a specific theme"""
    try:
        theme = appearance_cache.get_theme(theme_name)
        
        if not theme:
            raise HTTPException(status_code=404, detail=f"Theme '{theme_name}' not found")
        
        if not theme.get('text_color'):
            raise HTTPException(status_code=404, detail=f"Theme '{theme_name}' has no color configuration")
        
        return ThemeColorsResponse(
            theme_name=theme['theme_name'],
            text_color=theme['text_color'],
            background_color=theme['background_color'],
            menu_color=theme['menu_color'],
            border_line_color=theme['border_line_color']
        )
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Failed to get theme colors", theme_name=theme_name, error=str(e))
        raise HTTPException(status_code=500, detail="Failed to retrieve theme colors")

@router.put("/themes/{theme_name}/colors", response_model=ThemeColorsResponse)
async def update_theme_colors(
    theme_name: str,
    colors: UpdateThemeColorsRequest,
    db: AsyncSession = Depends(get_db)
):
    """Update color configuration for a specific theme"""
    try:
        # Verify theme exists in cache
        theme = appearance_cache.get_theme(theme_name)
        if not theme:
            raise HTTPException(status_code=404, detail=f"Theme '{theme_name}' not found")
        
        option_value_id = theme['option_value_id']
        
        # Update theme colors in database
        update_query = text("""
            UPDATE theme_configs 
            SET 
                text_color = :text_color,
                background_color = :background_color,
                menu_color = :menu_color,
                border_line_color = :border_line_color
            WHERE option_value_id = :option_value_id
            RETURNING name, text_color, background_color, menu_color, border_line_color
        """)
        
        result = await db.execute(update_query, {
            "option_value_id": option_value_id,
            "text_color": colors.text_color,
            "background_color": colors.background_color,
            "menu_color": colors.menu_color,
            "border_line_color": colors.border_line_color
        })
        
        updated_theme = result.fetchone()
        if not updated_theme:
            raise HTTPException(status_code=404, detail="Theme configuration not found")
        
        await db.commit()
        
        # Reload the cache to reflect changes
        await appearance_cache.reload_cache()
        
        logger.info("Theme colors updated", theme_name=theme_name)
        
        return ThemeColorsResponse(
            theme_name=updated_theme.name,
            text_color=updated_theme.text_color,
            background_color=updated_theme.background_color,
            menu_color=updated_theme.menu_color,
            border_line_color=updated_theme.border_line_color
        )
        
    except HTTPException:
        await db.rollback()
        raise
    except Exception as e:
        await db.rollback()
        logger.error("Failed to update theme colors", theme_name=theme_name, error=str(e))
        raise HTTPException(status_code=500, detail="Failed to update theme colors")

@router.get("/themes/names")
async def get_theme_names():
    """Get list of available theme names"""
    try:
        theme_names = appearance_cache.get_theme_names()
        return {
            "theme_names": theme_names,
            "default_theme": appearance_cache.get_default_theme(),
            "count": len(theme_names)
        }
        
    except Exception as e:
        logger.error("Failed to get theme names", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to retrieve theme names")

@router.post("/themes/reload")
async def reload_themes_cache():
    """Reload the themes cache from database (admin function)"""
    try:
        await appearance_cache.reload_cache()
        
        themes_count = len(appearance_cache._themes_cache)
        
        logger.info("Themes cache reloaded", themes_count=themes_count)
        
        return {
            "message": "Themes cache reloaded successfully",
            "themes_count": themes_count
        }
        
    except Exception as e:
        logger.error("Failed to reload themes cache", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to reload themes cache")

# ============================================
# Utility Routes
# ============================================

@router.get("/themes/{theme_name}/validate")
async def validate_theme(theme_name: str):
    """Validate if a theme name exists"""
    is_valid = appearance_cache.is_valid_theme(theme_name)
    
    return {
        "theme_name": theme_name,
        "is_valid": is_valid,
        "message": "Theme is valid" if is_valid else "Theme not found"
    }

@router.get("/option-sets")
async def get_option_sets():
    """Get all option sets"""
    try:
        return {
            "option_sets": list(appearance_cache._option_sets_cache.values()),
            "count": len(appearance_cache._option_sets_cache)
        }
        
    except Exception as e:
        logger.error("Failed to get option sets", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to retrieve option sets")