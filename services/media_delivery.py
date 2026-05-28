"""Build ilaunching_media_server delivery URLs (mirrors src/url-builder.js)."""

from __future__ import annotations

import math
from typing import Literal

from config.media_settings import get_media_settings

DIMENSION_STEP = 50
MAX_DIMENSION = 4096
DEFAULT_QUALITY = 82


def snap_dimension(display_px: int) -> int:
    clamped = min(max(display_px, DIMENSION_STEP), MAX_DIMENSION)
    return int(math.ceil(clamped / DIMENSION_STEP) * DIMENSION_STEP)


def pick_width_bucket(needed_px: int) -> int:
    buckets = [300, 650, 1000, 1300, 1950]
    target = (
        needed_px
        if needed_px > 0 and needed_px % DIMENSION_STEP == 0
        else snap_dimension(needed_px)
    )
    for w in buckets:
        bucket = snap_dimension(w)
        if bucket >= target:
            return bucket
    return snap_dimension(buckets[-1])


def media_base_url(lane: Literal["catalog", "user"] | str = "catalog") -> str:
    settings = get_media_settings()
    if lane == "user":
        base = settings.user_base_url or settings.worker_url
    else:
        base = settings.catalog_base_url or settings.worker_url
    if not base:
        base = "https://ilaunching-media-server.ilaunching-ltd.workers.dev"
    return base.rstrip("/")


def build_delivery_url(
    *,
    object_path: str,
    lane: Literal["catalog", "user"] = "catalog",
    width: int | None = None,
    height: int | None = None,
    quality: int = DEFAULT_QUALITY,
    crop: str = "fit",
    raw: bool = False,
) -> str:
    path = object_path.lstrip("/")
    lane_seg = "catalog" if lane == "catalog" else "raw"
    base = media_base_url(lane)

    if raw:
        transform = "raw"
    else:
        parts: list[str] = []
        if width:
            parts.append(f"w_{width}")
        if height:
            parts.append(f"h_{height}")
        parts.extend([f"q_{quality}", f"c_{crop}"])
        transform = ",".join(parts)

    return f"{base}/{transform}/{lane_seg}/{path}"
