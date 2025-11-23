"""
Appearance Configuration Cache Service
Fast access to appearance themes and option sets
"""

import asyncio
from typing import Dict, Any, Optional, List
from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession
from config.database import get_db
import structlog

logger = structlog.get_logger()

class AppearanceCache:
    """Static appearance configuration cache for fast theme access"""
    
    def __init__(self):
        self._themes_cache: Dict[str, Dict[str, Any]] = {}
        self._option_sets_cache: Dict[str, Dict[str, Any]] = {}
        self._loaded = False
    
    async def load_cache(self):
        """Load all appearance configuration data into memory at startup"""
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
                        tc.theme_metadata as metadata
                    FROM option_sets os
                    JOIN option_values ov ON os.id = ov.option_set_id
                    LEFT JOIN theme_configs tc ON ov.id = tc.option_value_id
                    WHERE ov.is_active = true
                    ORDER BY os.name, ov.sort_order
                """)
                
                result = await db.execute(query)
                rows = result.fetchall()
                
                # Build the themes cache
                for row in rows:
                    theme_key = row.value_name
                    self._themes_cache[theme_key] = {
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
                        'metadata': row.metadata or {}
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
                    "Appearance cache loaded",
                    themes_count=len(self._themes_cache),
                    option_sets_count=len(self._option_sets_cache)
                )
                break  # Exit the async generator
                
        except Exception as e:
            logger.error("Failed to load appearance cache", error=str(e))
            raise
    
    def get_theme(self, theme_name: str) -> Optional[Dict[str, Any]]:
        """Get theme configuration by name (nanosecond lookup)"""
        return self._themes_cache.get(theme_name)
    
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
        """Get all available themes sorted by display order"""
        themes = list(self._themes_cache.values())
        # Filter only appearance themes and sort by order
        appearance_themes = [
            theme for theme in themes 
            if theme.get('set_name') == 'appearance'
        ]
        return sorted(appearance_themes, key=lambda x: x.get('sort_order', 0))
    
    def get_theme_names(self) -> List[str]:
        """Get list of available theme names"""
        return [
            theme['value_name'] for theme in self.get_all_themes()
        ]
    
    def get_option_set(self, set_name: str) -> Optional[Dict[str, Any]]:
        """Get option set by name"""
        return self._option_sets_cache.get(set_name)
    
    def get_themes_by_set(self, set_name: str) -> List[Dict[str, Any]]:
        """Get all themes for a specific option set"""
        return [
            theme for theme in self._themes_cache.values()
            if theme.get('set_name') == set_name
        ]
    
    def is_valid_theme(self, theme_name: str) -> bool:
        """Check if a theme name is valid"""
        return theme_name in self._themes_cache
    
    def get_default_theme(self) -> str:
        """Get the default theme name (first in sort order)"""
        themes = self.get_all_themes()
        if themes:
            return themes[0]['value_name']
        return 'sun'  # Fallback default
    
    async def reload_cache(self):
        """Reload the cache (useful for dynamic updates)"""
        self._loaded = False
        self._themes_cache.clear()
        self._option_sets_cache.clear()
        await self.load_cache()

# Global cache instance
appearance_cache = AppearanceCache()

# Utility functions for easy access
async def get_user_theme_colors(theme_name: str) -> Dict[str, str]:
    """Convenience function to get theme colors"""
    return appearance_cache.get_theme_colors(theme_name)

async def get_available_themes() -> List[Dict[str, Any]]:
    """Convenience function to get all available themes"""
    return appearance_cache.get_all_themes()

async def validate_theme_name(theme_name: str) -> bool:
    """Convenience function to validate theme name"""
    return appearance_cache.is_valid_theme(theme_name)