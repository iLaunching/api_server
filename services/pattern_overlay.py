"""Shared pattern overlay gradient helpers."""

from __future__ import annotations

from typing import Any


def normalize_pattern_overlay_gradient(raw: Any) -> dict | None:
    """Drop malformed JSONB so clients do not fail on partial gradient objects."""
    if not isinstance(raw, dict):
        return None
    stops = raw.get("stops")
    if not isinstance(stops, list) or len(stops) < 2:
        return None
    return raw
