"""
Icon Library Routes
API endpoints for Font Awesome icon management
"""

from typing import List, Dict, Any, Optional
from fastapi import APIRouter, HTTPException, Query
from pydantic import BaseModel
import structlog

from services.option_sets_cache import option_sets_cache

logger = structlog.get_logger()
router = APIRouter()

# ============================================
# Response Models
# ============================================

class IconResponse(BaseModel):
    """Response model for a single icon"""
    option_value_id: int
    value_name: str
    display_name: str
    icon_name: str
    icon_prefix: str
    icon_category: str
    unicode: Optional[str] = None

class IconListResponse(BaseModel):
    """Response model for icon list"""
    icons: List[IconResponse]
    total: int
    categories: List[str]

class IconCategoryResponse(BaseModel):
    """Response model for icons by category"""
    category: str
    icons: List[IconResponse]
    count: int

# ============================================
# Routes
# ============================================

@router.get("/icons", response_model=IconListResponse)
async def get_all_icons(
    category: Optional[str] = Query(None, description="Filter by category"),
    prefix: Optional[str] = Query(None, description="Filter by prefix (fas, far, fab)"),
    search: Optional[str] = Query(None, description="Search in display name"),
    limit: int = Query(100, ge=1, le=500, description="Max icons to return"),
    offset: int = Query(0, ge=0, description="Pagination offset")
):
    """
    Get all icons from the icon library with optional filters
    """
    try:
        # Get all icons from cache
        all_icons = option_sets_cache.get_options_by_set('icon_library')
        
        # Apply filters
        filtered_icons = all_icons
        
        if category:
            filtered_icons = [
                icon for icon in filtered_icons 
                if icon.get('metadata', {}).get('icon_category') == category
            ]
        
        if prefix:
            filtered_icons = [
                icon for icon in filtered_icons 
                if icon.get('metadata', {}).get('icon_prefix') == prefix
            ]
        
        if search:
            search_lower = search.lower()
            filtered_icons = [
                icon for icon in filtered_icons 
                if search_lower in icon.get('display_name', '').lower() or 
                   search_lower in icon.get('metadata', {}).get('icon_name', '').lower()
            ]
        
        # Get unique categories
        categories = list(set(
            icon.get('metadata', {}).get('icon_category', 'general') 
            for icon in all_icons
        ))
        categories.sort()
        
        # Pagination
        total = len(filtered_icons)
        paginated_icons = filtered_icons[offset:offset + limit]
        
        # Format response
        icon_responses = []
        for icon in paginated_icons:
            metadata = icon.get('metadata', {})
            icon_responses.append(IconResponse(
                option_value_id=icon['option_value_id'],
                value_name=icon['value_name'],
                display_name=icon['display_name'],
                icon_name=metadata.get('icon_name', ''),
                icon_prefix=metadata.get('icon_prefix', 'fas'),
                icon_category=metadata.get('icon_category', 'general'),
                unicode=metadata.get('unicode')
            ))
        
        logger.info("Icons retrieved", 
                   total=total, 
                   returned=len(icon_responses),
                   category=category,
                   prefix=prefix,
                   search=search)
        
        return IconListResponse(
            icons=icon_responses,
            total=total,
            categories=categories
        )
        
    except Exception as e:
        logger.error("Failed to get icons", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to retrieve icons")


@router.get("/icons/categories", response_model=List[IconCategoryResponse])
async def get_icons_by_category():
    """
    Get all icons grouped by category
    """
    try:
        all_icons = option_sets_cache.get_options_by_set('icon_library')
        
        # Group by category
        by_category: Dict[str, List[Dict]] = {}
        for icon in all_icons:
            category = icon.get('metadata', {}).get('icon_category', 'general')
            if category not in by_category:
                by_category[category] = []
            by_category[category].append(icon)
        
        # Format response
        response = []
        for category, icons in sorted(by_category.items()):
            icon_responses = []
            for icon in icons:
                metadata = icon.get('metadata', {})
                icon_responses.append(IconResponse(
                    option_value_id=icon['option_value_id'],
                    value_name=icon['value_name'],
                    display_name=icon['display_name'],
                    icon_name=metadata.get('icon_name', ''),
                    icon_prefix=metadata.get('icon_prefix', 'fas'),
                    icon_category=category,
                    unicode=metadata.get('unicode')
                ))
            
            response.append(IconCategoryResponse(
                category=category,
                icons=icon_responses,
                count=len(icon_responses)
            ))
        
        logger.info("Icons by category retrieved", categories=len(response))
        return response
        
    except Exception as e:
        logger.error("Failed to get icons by category", error=str(e))
        raise HTTPException(status_code=500, detail="Failed to retrieve icons by category")


@router.get("/icons/{icon_id}", response_model=IconResponse)
async def get_icon_by_id(icon_id: int):
    """
    Get a specific icon by option_value_id
    """
    try:
        all_icons = option_sets_cache.get_options_by_set('icon_library')
        
        icon = next((i for i in all_icons if i['option_value_id'] == icon_id), None)
        
        if not icon:
            raise HTTPException(status_code=404, detail=f"Icon with ID {icon_id} not found")
        
        metadata = icon.get('metadata', {})
        
        return IconResponse(
            option_value_id=icon['option_value_id'],
            value_name=icon['value_name'],
            display_name=icon['display_name'],
            icon_name=metadata.get('icon_name', ''),
            icon_prefix=metadata.get('icon_prefix', 'fas'),
            icon_category=metadata.get('icon_category', 'general'),
            unicode=metadata.get('unicode')
        )
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error("Failed to get icon", icon_id=icon_id, error=str(e))
        raise HTTPException(status_code=500, detail="Failed to retrieve icon")


@router.get("/icons/search/{query}", response_model=IconListResponse)
async def search_icons(
    query: str,
    limit: int = Query(50, ge=1, le=200)
):
    """
    Search icons by name or display name
    """
    try:
        all_icons = option_sets_cache.get_options_by_set('icon_library')
        
        query_lower = query.lower()
        matching_icons = [
            icon for icon in all_icons 
            if query_lower in icon.get('display_name', '').lower() or 
               query_lower in icon.get('metadata', {}).get('icon_name', '').lower()
        ]
        
        # Limit results
        matching_icons = matching_icons[:limit]
        
        # Format response
        icon_responses = []
        for icon in matching_icons:
            metadata = icon.get('metadata', {})
            icon_responses.append(IconResponse(
                option_value_id=icon['option_value_id'],
                value_name=icon['value_name'],
                display_name=icon['display_name'],
                icon_name=metadata.get('icon_name', ''),
                icon_prefix=metadata.get('icon_prefix', 'fas'),
                icon_category=metadata.get('icon_category', 'general'),
                unicode=metadata.get('unicode')
            ))
        
        # Get unique categories from all icons (for filter options)
        categories = list(set(
            icon.get('metadata', {}).get('icon_category', 'general') 
            for icon in all_icons
        ))
        categories.sort()
        
        logger.info("Icon search completed", query=query, results=len(icon_responses))
        
        return IconListResponse(
            icons=icon_responses,
            total=len(icon_responses),
            categories=categories
        )
        
    except Exception as e:
        logger.error("Failed to search icons", query=query, error=str(e))
        raise HTTPException(status_code=500, detail="Failed to search icons")
