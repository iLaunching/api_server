"""Fetch SVG pattern bytes from Asset_server."""

from __future__ import annotations

import os

import httpx
import structlog

logger = structlog.get_logger()

_DEFAULT_ASSET_BASE = "https://assetserver-production.up.railway.app"


def asset_server_base_url() -> str:
    base = (os.environ.get("ASSET_SERVER_URL") or _DEFAULT_ASSET_BASE).strip()
    return base.rstrip("/")


def resolve_pattern_delivery_url(delivery_url: str | None) -> str | None:
    raw = (delivery_url or "").strip()
    if not raw:
        return None
    if raw.startswith("http://") or raw.startswith("https://"):
        return raw
    path = raw.lstrip("/")
    return f"{asset_server_base_url()}/{path}"


async def fetch_pattern_svg_bytes(delivery_url: str | None) -> tuple[bytes, str]:
    url = resolve_pattern_delivery_url(delivery_url)
    if not url:
        raise ValueError("missing_pattern_delivery_url")

    async with httpx.AsyncClient(timeout=60.0) as client:
        response = await client.get(url, headers={"Accept": "image/svg+xml,*/*"})
        if response.status_code >= 400:
            logger.error(
                "pattern_svg_fetch_failed",
                status=response.status_code,
                url=url,
            )
            response.raise_for_status()
        body = response.content
        if not body:
            raise ValueError("empty_pattern_svg")
        content_type = (response.headers.get("content-type") or "image/svg+xml").split(";")[0]
        return body, content_type.strip().lower() or "image/svg+xml"
