"""
Media server integration (Cloudflare Worker + R2).

Production (Railway api-server) requires:
  MEDIA_WORKER_URL  — Worker base URL (no trailing path)
  MEDIA_INGEST_SECRET — same value as INGEST_SECRET on the Worker

Optional delivery URL bases (defaults to MEDIA_WORKER_URL):
  MEDIA_USER_BASE_URL, MEDIA_CATALOG_BASE_URL, MEDIA_CDN_BASE_URL
"""

from __future__ import annotations

import os
from dataclasses import dataclass


def _first_env(*keys: str) -> str | None:
    for key in keys:
        value = os.getenv(key)
        if value and value.strip():
            return value.strip()
    return None


@dataclass(frozen=True)
class MediaSettings:
    worker_url: str
    ingest_secret: str
    catalog_base_url: str
    user_base_url: str

    @property
    def upload_configured(self) -> bool:
        return bool(self.worker_url and self.ingest_secret)

    def missing_for_upload(self) -> list[str]:
        missing: list[str] = []
        if not self.worker_url:
            missing.append(
                "MEDIA_WORKER_URL (or MEDIA_BASE_URL / MEDIA_CDN_BASE_URL)"
            )
        if not self.ingest_secret:
            missing.append("MEDIA_INGEST_SECRET (or INGEST_SECRET)")
        return missing


def get_media_settings() -> MediaSettings:
    worker_url = (
        _first_env(
            "MEDIA_WORKER_URL",
            "MEDIA_BASE_URL",
            "MEDIA_CDN_BASE_URL",
        )
        or ""
    ).rstrip("/")

    ingest_secret = _first_env("MEDIA_INGEST_SECRET", "INGEST_SECRET") or ""

    catalog_base = (
        _first_env("MEDIA_CATALOG_BASE_URL", "MEDIA_CDN_BASE_URL", "MEDIA_WORKER_URL")
        or worker_url
    ).rstrip("/")

    user_base = (
        _first_env("MEDIA_USER_BASE_URL", "MEDIA_CDN_BASE_URL", "MEDIA_WORKER_URL")
        or worker_url
    ).rstrip("/")

    return MediaSettings(
        worker_url=worker_url,
        ingest_secret=ingest_secret,
        catalog_base_url=catalog_base,
        user_base_url=user_base,
    )


def media_upload_status() -> dict:
    settings = get_media_settings()
    missing = settings.missing_for_upload()
    return {
        "configured": settings.upload_configured,
        "worker_url_set": bool(settings.worker_url),
        "ingest_secret_set": bool(settings.ingest_secret),
        "missing_env": missing,
    }
