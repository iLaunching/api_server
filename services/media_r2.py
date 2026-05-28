"""Upload bytes to ilaunching_media_server internal ingest (user + catalog buckets)."""

from __future__ import annotations

import re
import uuid

import httpx
import structlog

from config.media_settings import get_media_settings

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

_FILENAME_EXT_TO_CONTENT_TYPE = {
    "jpg": "image/jpeg",
    "jpeg": "image/jpeg",
    "png": "image/png",
    "webp": "image/webp",
}


def sniff_image_content_type(body: bytes) -> str | None:
    if len(body) >= 3 and body[:3] == b"\xff\xd8\xff":
        return "image/jpeg"
    if len(body) >= 8 and body[:8] == b"\x89PNG\r\n\x1a\n":
        return "image/png"
    if len(body) >= 12 and body[:4] == b"RIFF" and body[8:12] == b"WEBP":
        return "image/webp"
    return None


def normalize_image_content_type(
    content_type: str | None,
    body: bytes,
    *,
    filename: str | None = None,
) -> str:
    """
    Accept declared multipart types; sniff bytes / filename when clients send octet-stream.
    """
    ct = (content_type or "").split(";")[0].strip().lower()
    if ct == "image/jpg":
        ct = "image/jpeg"
    if ct in ALLOWED_IMAGE_CONTENT_TYPES:
        return ct
    if ct in ("application/octet-stream", "binary/octet-stream", ""):
        sniffed = sniff_image_content_type(body)
        if sniffed:
            return sniffed
        if filename and "." in filename:
            ext = filename.rsplit(".", 1)[-1].lower()
            mapped = _FILENAME_EXT_TO_CONTENT_TYPE.get(ext)
            if mapped:
                return mapped
    raise ValueError("unsupported_content_type")


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

    settings = get_media_settings()
    if not settings.upload_configured:
        missing = ", ".join(settings.missing_for_upload())
        raise RuntimeError(
            f"Media upload is not configured. Set on Railway api-server: {missing}. "
            "INGEST_SECRET must match the Cloudflare Worker secret."
        )

    worker_url = settings.worker_url
    ingest_secret = settings.ingest_secret

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
