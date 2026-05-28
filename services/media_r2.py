"""Upload bytes to ilaunching_media_server internal ingest (user + catalog buckets)."""

from __future__ import annotations

import os
import re
import uuid

import httpx
import structlog

logger = structlog.get_logger()

USER_WALLPAPER_PATH = re.compile(
    r"^users/[0-9a-fA-F-]{36}/wallpapers/[0-9a-fA-F-]{36}\.(webp|jpe?g|png)$"
)

ALLOWED_IMAGE_CONTENT_TYPES = frozenset(
    {
        "image/webp",
        "image/jpeg",
        "image/jpg",
        "image/png",
    }
)


def wallpaper_object_path(user_id: uuid.UUID, upload_id: uuid.UUID, ext: str) -> str:
    return f"users/{user_id}/wallpapers/{upload_id}.{ext}"


def extension_for_content_type(content_type: str) -> str:
    ct = (content_type or "").split(";")[0].strip().lower()
    if ct == "image/webp":
        return "webp"
    if ct in ("image/jpeg", "image/jpg"):
        return "jpg"
    if ct == "image/png":
        return "png"
    return "webp"


async def put_user_object(
    object_path: str,
    body: bytes,
    content_type: str,
) -> None:
    if not USER_WALLPAPER_PATH.match(object_path):
        raise ValueError("invalid_user_wallpaper_object_path")

    worker_url = (os.getenv("MEDIA_WORKER_URL") or "").rstrip("/")
    ingest_secret = os.getenv("MEDIA_INGEST_SECRET") or os.getenv("INGEST_SECRET")
    if not worker_url or not ingest_secret:
        raise RuntimeError("MEDIA_WORKER_URL and MEDIA_INGEST_SECRET must be configured")

    key = f"raw/{object_path}"
    url = f"{worker_url}/media/v1/internal/object"
    params = {"key": key}

    async with httpx.AsyncClient(timeout=120.0) as client:
        response = await client.put(
            url,
            params=params,
            content=body,
            headers={
                "Authorization": f"Bearer {ingest_secret}",
                "Content-Type": content_type,
            },
        )
        if response.status_code >= 400:
            logger.error(
                "media_worker_ingest_failed",
                status=response.status_code,
                body=response.text[:500],
                key=key,
            )
            response.raise_for_status()
