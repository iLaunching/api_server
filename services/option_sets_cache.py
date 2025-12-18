"""
Option Sets Configuration Cache Service
Fast access to all option sets: appearance, itheme, avatar_display, etc.
"""

import asyncio
from typing import Dict, Any, Optional, List
from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession
from config.database import get_db
import structlog

logger = structlog.get_logger()

class OptionSetsCache:
    """Static option sets configuration cache for fast access to all option sets"""
    
    def __init__(self):
        self._options_cache: Dict[str, Dict[str, Any]] = {}
        self._option_sets_cache: Dict[str, Dict[str, Any]] = {}
        self._loaded = False
    
    async def load_cache(self):
        """Load all option sets configuration data into memory at startup"""
        if self._loaded:
            return
            
        try:
            async for db in get_db():
                # Load all appearance themes with a single optimized query
                query = text("""
                    SELECT 
                        os.name as set_name,
                        ov.id as option_value_id,
                        ov.value_name,
                        ov.display_name,
                        ov.sort_order,
                        tc.id as theme_config_id,
                        tc.name as theme_name,
                        tc.text_color,
                        tc.background_color,
                        tc.menu_color,
                        tc.border_line_color,
                        tc.chat_bk_1,
                        tc.theme_metadata as metadata,
                        im.icon_name,
                        im.icon_prefix,
                        im.icon_category,
                        im.unicode as icon_unicode
                    FROM option_sets os
                    JOIN option_values ov ON os.id = ov.option_set_id
                    LEFT JOIN theme_configs tc ON ov.id = tc.option_value_id
                    LEFT JOIN icon_metadata im ON ov.id = im.option_value_id
                    WHERE ov.is_active = true
                    ORDER BY os.name, ov.sort_order
                """)
                
                result = await db.execute(query)
                rows = result.fetchall()
                
                # Build the options cache (all option values from all option sets)
                for row in rows:
                    option_key = row.value_name
                    
                    # Build metadata - combine theme_metadata and icon metadata
                    metadata = row.metadata or {}
                    if row.icon_name:
                        # This is an icon, add icon metadata
                        metadata.update({
                            'icon_name': row.icon_name,
                            'icon_prefix': row.icon_prefix,
                            'icon_category': row.icon_category or 'general',
                            'unicode': row.icon_unicode
                        })
                    
                    self._options_cache[option_key] = {
                        'option_value_id': row.option_value_id,
                        'set_name': row.set_name,
                        'value_name': row.value_name,
                        'display_name': row.display_name,
                        'sort_order': row.sort_order,
                        'theme_config_id': row.theme_config_id,
                        'theme_name': row.theme_name,
                        'text_color': row.text_color,
                        'background_color': row.background_color,
                        'menu_color': row.menu_color,
                        'border_line_color': row.border_line_color,
                        'chat_bk_1': row.chat_bk_1,
                        'metadata': metadata
                    }
                
                # Load option sets
                option_sets_query = text("""
                    SELECT id, name, description, created_at
                    FROM option_sets
                    ORDER BY name
                """)
                
                sets_result = await db.execute(option_sets_query)
                sets_rows = sets_result.fetchall()
                
                for row in sets_rows:
                    self._option_sets_cache[row.name] = {
                        'id': row.id,
                        'name': row.name,
                        'description': row.description,
                        'created_at': row.created_at.isoformat() if row.created_at else None
                    }
                
                self._loaded = True
                logger.info(
                    "Option sets cache loaded",
                    options_count=len(self._options_cache),
                    option_sets_count=len(self._option_sets_cache)
                )
                break  # Exit the async generator
                
        except Exception as e:
            logger.error("Failed to load option sets cache", error=str(e))
            raise
    
    def get_option(self, value_name: str) -> Optional[Dict[str, Any]]:
        """Get option configuration by value_name (nanosecond lookup)"""
        return self._options_cache.get(value_name)
    
    def get_theme(self, theme_name: str) -> Optional[Dict[str, Any]]:
        """Get theme configuration by name - alias for get_option() for backwards compatibility"""
        return self.get_option(theme_name)
    
    def get_theme_colors(self, theme_name: str) -> Dict[str, str]:
        """Get all theme colors for a specific theme"""
        theme = self.get_theme(theme_name)
        if not theme:
            # Return default theme colors if theme not found
            return {
                'text_color': '#000000',
                'background_color': '#FFFFFF',
                'menu_color': '#F8F9FA',
                'border_line_color': '#DEE2E6'
            }
        
        return {
            'text_color': theme.get('text_color', '#000000'),
            'background_color': theme.get('background_color', '#FFFFFF'),
            'menu_color': theme.get('menu_color', '#F8F9FA'),
            'border_line_color': theme.get('border_line_color', '#DEE2E6')
        }
    
    def get_all_themes(self) -> List[Dict[str, Any]]:
        """Get all available appearance themes sorted by display order"""
        options = list(self._options_cache.values())
        # Filter only appearance themes and sort by order
        appearance_themes = [
            option for option in options 
            if option.get('set_name') == 'appearance'
        ]
        return sorted(appearance_themes, key=lambda x: x.get('sort_order', 0))
    
    def get_all_ithemes(self) -> List[Dict[str, Any]]:
        """Get all available iTheme gradient themes sorted by display order"""
        options = list(self._options_cache.values())
        ithemes = [
            option for option in options 
            if option.get('set_name') == 'itheme'
        ]
        return sorted(ithemes, key=lambda x: x.get('sort_order', 0))
    
    def get_all_avatar_display_options(self) -> List[Dict[str, Any]]:
        """Get all avatar display options sorted by display order"""
        options = list(self._options_cache.values())
        avatar_options = [
            option for option in options 
            if option.get('set_name') == 'avatar_display'
        ]
        return sorted(avatar_options, key=lambda x: x.get('sort_order', 0))
    
    def get_theme_names(self) -> List[str]:
        """Get list of available theme names"""
        return [
            theme['value_name'] for theme in self.get_all_themes()
        ]
    
    def get_option_set(self, set_name: str) -> Optional[Dict[str, Any]]:
        """Get option set by name"""
        return self._option_sets_cache.get(set_name)
    
    def get_options_by_set(self, set_name: str) -> List[Dict[str, Any]]:
        """Get all options for a specific option set"""
        return [
            option for option in self._options_cache.values()
            if option.get('set_name') == set_name
        ]
    
    def is_valid_option(self, value_name: str) -> bool:
        """Check if an option value_name is valid"""
        return value_name in self._options_cache
    
    def is_valid_theme(self, theme_name: str) -> bool:
        """Check if a theme name is valid - alias for is_valid_option() for backwards compatibility"""
        return self.is_valid_option(theme_name)
    
    def get_default_theme(self) -> str:
        """Get the default theme name (first in sort order)"""
        themes = self.get_all_themes()
        if themes:
            return themes[0]['value_name']
        return 'sun'  # Fallback default
    
    async def reload_cache(self):
        """Reload the cache (useful for dynamic updates)"""
        self._loaded = False
        self._options_cache.clear()
        self._option_sets_cache.clear()
        await self.load_cache()

# Global cache instance
option_sets_cache = OptionSetsCache()

# Utility functions for easy access
async def get_user_theme_colors(theme_name: str) -> Dict[str, str]:
    """Convenience function to get theme colors"""
    return option_sets_cache.get_theme_colors(theme_name)

async def get_available_themes() -> List[Dict[str, Any]]:
    """Convenience function to get all available appearance themes"""
    return option_sets_cache.get_all_themes()

async def validate_theme_name(theme_name: str) -> bool:
    """Convenience function to validate theme name"""
    return option_sets_cache.is_valid_theme(theme_name)

async def get_available_ithemes() -> List[Dict[str, Any]]:
    """Convenience function to get all available iThemes"""
    return option_sets_cache.get_all_ithemes()

async def get_available_avatar_display_options() -> List[Dict[str, Any]]:
    """Convenience function to get all available avatar display options"""
    return option_sets_cache.get_all_avatar_display_options()
