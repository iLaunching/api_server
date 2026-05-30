"""Resolve catalog wallpaper ids to delivery URLs via the media server manifest."""

from __future__ import annotations

import time
from typing import Any

import httpx
import structlog

from services.media_delivery import build_delivery_url, media_base_url, pick_width_bucket

logger = structlog.get_logger()

_manifest_cache: dict[str, Any] = {"expires_at": 0.0, "data": None}
_CACHE_TTL_SECONDS = 300


async def fetch_wallpaper_manifest() -> dict[str, Any] | None:
    now = time.time()
    if _manifest_cache["data"] is not None and _manifest_cache["expires_at"] > now:
        return _manifest_cache["data"]

    base = media_base_url("catalog")
    url = f"{base}/catalog/v1/wallpaper-collections"

    try:
        async with httpx.AsyncClient(timeout=30.0) as client:
            response = await client.get(url, headers={"Accept": "application/json"})
            if response.status_code >= 400:
                logger.warning("wallpaper_manifest_fetch_failed", status=response.status_code)
                return _manifest_cache["data"]
            data = response.json()
            _manifest_cache["data"] = data
            _manifest_cache["expires_at"] = now + _CACHE_TTL_SECONDS
            return data
    except Exception as exc:
        logger.warning("wallpaper_manifest_fetch_error", error=str(exc))
        return _manifest_cache["data"]


async def resolve_catalog_photo(
    photo_id: str,
    *,
    width_px: int = 1950,
) -> dict[str, str] | None:
    if not photo_id or not photo_id.strip():
        return None
    manifest = await fetch_wallpaper_manifest()
    if not manifest:
        return None

    target_id = photo_id.strip()
    for collection in manifest.get("collections") or []:
        collection_slug = collection.get("slug") or ""
        for item in collection.get("items") or []:
            if item.get("id") != target_id:
                continue
            object_path = item.get("object_path")
            if not object_path:
                return None
            w = pick_width_bucket(width_px)
            delivery_url = build_delivery_url(
                object_path=object_path,
                lane="catalog",
                width=w,
                crop="fit",
            )
            return {
                "media_photo_id": target_id,
                "object_path": object_path,
                "delivery_url": delivery_url,
                "title": (item.get("title") or target_id).strip(),
                "collection_slug": collection_slug,
            }
    return None


async def fetch_catalog_object_bytes(object_path: str) -> tuple[bytes, str]:
    """Fetch catalog master bytes via media worker raw URL."""
    path = object_path.lstrip("/")
    base = media_base_url("catalog").rstrip("/")
    url = f"{base}/raw/catalog/{path}"

    async with httpx.AsyncClient(timeout=120.0) as client:
        response = await client.get(url)
        if response.status_code >= 400:
            logger.error(
                "catalog_object_fetch_failed",
                status=response.status_code,
                object_path=path,
            )
            response.raise_for_status()
        content_type = (response.headers.get("content-type") or "image/webp").split(";")[0]
        return response.content, content_type.strip().lower()
