"""Resolve catalog wallpaper ids to delivery URLs via the media server catalog index."""

from __future__ import annotations

import asyncio
import time
from typing import Any

import httpx
import structlog

from services.media_delivery import (
    build_delivery_url,
    infer_catalog_asset_type,
    media_base_url,
    normalize_catalog_object_path,
    normalize_catalog_delivery_url,
    pick_width_bucket,
)

logger = structlog.get_logger()

_manifest_cache: dict[str, Any] = {"expires_at": 0.0, "data": None}
_asset_by_id_cache: dict[str, tuple[float, dict[str, Any] | None]] = {}
_CACHE_TTL_SECONDS = 300


async def fetch_wallpaper_collections(*, include_items: bool = False) -> dict[str, Any] | None:
    """Category metadata (no embedded items unless include_items=True)."""
    now = time.time()
    cache_key = "with_items" if include_items else "metadata"
    if (
        _manifest_cache.get("mode") == cache_key
        and _manifest_cache["data"] is not None
        and _manifest_cache["expires_at"] > now
    ):
        return _manifest_cache["data"]

    base = media_base_url("catalog")
    params = {}
    if include_items:
        params["include_items"] = "true"

    url = f"{base}/catalog/v1/media-collections"

    try:
        async with httpx.AsyncClient(timeout=30.0) as client:
            response = await client.get(url, params=params, headers={"Accept": "application/json"})
            if response.status_code >= 400:
                logger.warning("wallpaper_collections_fetch_failed", status=response.status_code)
                return _manifest_cache["data"]
            data = response.json()
            _manifest_cache["data"] = data
            _manifest_cache["expires_at"] = now + _CACHE_TTL_SECONDS
            _manifest_cache["mode"] = cache_key
            return data
    except Exception as exc:
        logger.warning("wallpaper_collections_fetch_error", error=str(exc))
        return _manifest_cache["data"]


async def fetch_wallpaper_manifest() -> dict[str, Any] | None:
    """Backward-compatible alias — metadata-only collections."""
    return await fetch_wallpaper_collections(include_items=False)


async def fetch_catalog_assets_page(
    *,
    asset_type: str = "photo",
    category: str | None = None,
    query: str | None = None,
    offset: int = 0,
    limit: int = 24,
    width_px: int = 1950,
) -> dict[str, Any] | None:
    base = media_base_url("catalog")
    w = pick_width_bucket(width_px)
    params: dict[str, str | int] = {
        "type": asset_type,
        "offset": max(0, offset),
        "limit": max(1, min(limit, 100)),
        "cover_w": w,
        "preview_w": min(w, 650),
    }
    if category:
        params["category"] = category
    if query:
        params["q"] = query

    url = f"{base}/catalog/v1/assets"
    try:
        async with httpx.AsyncClient(timeout=30.0) as client:
            response = await client.get(url, params=params, headers={"Accept": "application/json"})
            if response.status_code >= 400:
                logger.warning("catalog_assets_fetch_failed", status=response.status_code)
                return None
            return response.json()
    except Exception as exc:
        logger.warning("catalog_assets_fetch_error", error=str(exc))
        return None


async def fetch_catalog_asset_by_id(
    photo_id: str,
    *,
    width_px: int = 1950,
) -> dict[str, Any] | None:
    if not photo_id or not photo_id.strip():
        return None

    key = photo_id.strip()
    now = time.time()
    cached = _asset_by_id_cache.get(key)
    if cached and cached[0] > now:
        return cached[1]

    base = media_base_url("catalog")
    w = pick_width_bucket(width_px)
    url = f"{base}/catalog/v1/assets/{key}"
    params = {"cover_w": w, "preview_w": min(w, 650)}

    item: dict[str, Any] | None = None
    try:
        async with httpx.AsyncClient(timeout=30.0) as client:
            response = await client.get(url, params=params, headers={"Accept": "application/json"})
            if response.status_code == 404:
                item = None
            elif response.status_code >= 400:
                logger.warning(
                    "catalog_asset_fetch_failed",
                    status=response.status_code,
                    photo_id=photo_id,
                )
                item = cached[1] if cached else None
            else:
                payload = response.json()
                item = payload.get("item")
    except Exception as exc:
        logger.warning("catalog_asset_fetch_error", error=str(exc), photo_id=photo_id)
        item = cached[1] if cached else None

    _asset_by_id_cache[key] = (now + _CACHE_TTL_SECONDS, item)
    return item


def catalog_delivery_urls_from_object_path(
    object_path: str,
    *,
    asset_type: str | None = None,
    width_px: int = 1950,
    preview_width_px: int = 200,
) -> tuple[str, str] | None:
    """Build cover + preview delivery URLs locally (no worker HTTP)."""
    path = normalize_catalog_object_path(object_path)
    if not path:
        return None
    at = infer_catalog_asset_type(path, asset_type)
    is_vector = at == "vector"
    cover_w = pick_width_bucket(width_px)
    preview_w = pick_width_bucket(preview_width_px)
    if is_vector:
        cover = build_delivery_url(
            object_path=path, lane="catalog", raw=True
        )
        preview = cover
    else:
        cover = build_delivery_url(
            object_path=path,
            lane="catalog",
            width=cover_w,
            crop="fit",
        )
        preview = build_delivery_url(
            object_path=path,
            lane="catalog",
            width=preview_w,
            crop="fill",
        )
    return (
        normalize_catalog_delivery_url(cover),
        normalize_catalog_delivery_url(preview),
    )


def catalog_delivery_urls_from_item(
    item: dict[str, Any],
    *,
    width_px: int = 1950,
    preview_width_px: int = 200,
) -> tuple[str, str] | None:
    object_path = item.get("object_path")
    if not object_path:
        return None
    return catalog_delivery_urls_from_object_path(
        str(object_path),
        asset_type=item.get("type"),
        width_px=width_px,
        preview_width_px=preview_width_px,
    )


async def prefetch_catalog_assets_by_ids(
    photo_ids: list[str],
) -> dict[str, dict[str, Any]]:
    """Parallel fetch for unique catalog ids (cached)."""
    unique = list(dict.fromkeys(id.strip() for id in photo_ids if id and id.strip()))
    if not unique:
        return {}
    results = await asyncio.gather(
        *(fetch_catalog_asset_by_id(photo_id) for photo_id in unique)
    )
    return {
        photo_id: item
        for photo_id, item in zip(unique, results)
        if item is not None
    }


async def resolve_catalog_photo(
    photo_id: str,
    *,
    width_px: int = 1950,
    crop: str = "fit",
) -> dict[str, str] | None:
    if not photo_id or not photo_id.strip():
        return None

    item = await fetch_catalog_asset_by_id(photo_id.strip(), width_px=width_px)
    if not item:
        return None

    object_path = item.get("object_path")
    if not object_path:
        return None

    object_path = normalize_catalog_object_path(object_path)
    asset_type = infer_catalog_asset_type(object_path, item.get("type"))
    urls = catalog_delivery_urls_from_object_path(
        object_path,
        asset_type=asset_type,
        width_px=width_px,
        preview_width_px=min(width_px, 650),
    )
    if not urls:
        return None
    delivery_url = urls[0]
    return {
        "media_photo_id": photo_id.strip(),
        "object_path": object_path,
        "delivery_url": delivery_url,
        "title": (item.get("title") or photo_id).strip(),
        "collection_slug": (item.get("category_slug") or item.get("collection_slug") or "").strip(),
        "type": asset_type,
    }


async def fetch_catalog_object_bytes(object_path: str) -> tuple[bytes, str]:
    """Fetch catalog master bytes via media worker raw URL."""
    path = normalize_catalog_object_path(object_path.lstrip("/"))
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
