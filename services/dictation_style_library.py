"""User dictation style library + catalog install / ratings."""

from __future__ import annotations

import os
import uuid
from datetime import datetime, timezone
from typing import Any
from uuid import UUID

import httpx
import structlog
from fastapi import HTTPException
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from models.dictation_style_library import (
    DictationStyleInstall,
    DictationStyleRating,
    DictationStyleStats,
    UserDictationCategory,
    UserDictationStyle,
)
from services.asset_patterns import asset_server_base_url

logger = structlog.get_logger()

_ASSET_TIMEOUT = float(os.getenv("DICTATION_STYLE_CATALOG_TIMEOUT_SEC", "12"))


def _now() -> datetime:
    return datetime.now(timezone.utc)


def _user_uuid(user_id: str | UUID) -> UUID:
    return user_id if isinstance(user_id, UUID) else UUID(str(user_id))


def _style_payload(row: UserDictationStyle) -> dict[str, Any]:
    return {
        "id": str(row.id),
        "category_id": str(row.category_id) if row.category_id else None,
        "name": row.name,
        "explanation": row.explanation or "",
        "rules": row.rules or "",
        "taxonomy_path": row.taxonomy_path,
        "compiled_contract": row.compiled_contract,
        "source_catalog_id": row.source_catalog_id,
        "catalog_version": row.catalog_version,
        "parent_style_id": str(row.parent_style_id) if row.parent_style_id else None,
        "bound_room_id": row.bound_room_id,
        "kind": row.kind,
        "created_at": row.created_at.isoformat() if row.created_at else None,
        "updated_at": row.updated_at.isoformat() if row.updated_at else None,
    }


def _category_payload(row: UserDictationCategory) -> dict[str, Any]:
    return {
        "id": str(row.id),
        "name": row.name,
        "type_kind": row.type_kind,
        "created_at": row.created_at.isoformat() if row.created_at else None,
        "updated_at": row.updated_at.isoformat() if row.updated_at else None,
    }


def _stats_payload(row: DictationStyleStats | None, catalog_style_id: str) -> dict[str, Any]:
    if not row:
        return {
            "catalog_style_id": catalog_style_id,
            "downloads": 0,
            "rating_avg": 0.0,
            "rating_count": 0,
        }
    count = int(row.rating_count or 0)
    total = int(row.rating_sum or 0)
    return {
        "catalog_style_id": catalog_style_id,
        "downloads": int(row.download_count or 0),
        "rating_avg": round(total / count, 2) if count else 0.0,
        "rating_count": count,
    }


async def fetch_catalog_style(style_id: str) -> dict[str, Any]:
    base = asset_server_base_url().rstrip("/")
    url = f"{base}/catalog/dictation-styles/styles/{style_id}"
    try:
        async with httpx.AsyncClient(timeout=_ASSET_TIMEOUT) as client:
            resp = await client.get(url)
    except httpx.HTTPError as exc:
        logger.warning("dictation_catalog_fetch_failed", style_id=style_id, error=str(exc))
        raise HTTPException(status_code=502, detail="Style catalog unavailable.") from exc
    if resp.status_code == 404:
        raise HTTPException(status_code=404, detail="Unknown catalog style.")
    if resp.status_code >= 400:
        raise HTTPException(status_code=502, detail="Style catalog error.")
    data = resp.json()
    if not isinstance(data, dict) or not data.get("compiled_contract"):
        raise HTTPException(status_code=502, detail="Catalog style missing compiled contract.")
    pricing = data.get("pricing") or {"model": "free"}
    if isinstance(pricing, dict) and pricing.get("model") == "paid":
        # v1 stub: paid styles are not installable until entitlements exist.
        raise HTTPException(status_code=402, detail="This style requires a purchase.")
    return data


async def list_library(db: AsyncSession, user_id: str | UUID) -> dict[str, Any]:
    uid = _user_uuid(user_id)
    cats = (
        await db.execute(
            select(UserDictationCategory).where(UserDictationCategory.user_id == uid)
        )
    ).scalars().all()
    styles = (
        await db.execute(
            select(UserDictationStyle).where(UserDictationStyle.user_id == uid)
        )
    ).scalars().all()
    return {
        "categories": [_category_payload(c) for c in cats],
        "styles": [_style_payload(s) for s in styles],
    }


async def get_stats_map(
    db: AsyncSession, style_ids: list[str] | None = None
) -> dict[str, Any]:
    stmt = select(DictationStyleStats)
    if style_ids:
        stmt = stmt.where(DictationStyleStats.catalog_style_id.in_(style_ids))
    rows = (await db.execute(stmt)).scalars().all()
    return {row.catalog_style_id: _stats_payload(row, row.catalog_style_id) for row in rows}


async def _ensure_category_for_kind(
    db: AsyncSession,
    user_id: UUID,
    type_kind: str,
    name: str,
) -> UserDictationCategory:
    existing = (
        await db.execute(
            select(UserDictationCategory).where(
                UserDictationCategory.user_id == user_id,
                UserDictationCategory.type_kind == type_kind,
            )
        )
    ).scalars().first()
    if existing:
        return existing
    row = UserDictationCategory(
        id=uuid.uuid4(),
        user_id=user_id,
        name=name or type_kind,
        type_kind=type_kind,
        created_at=_now(),
        updated_at=_now(),
    )
    db.add(row)
    await db.flush()
    return row


async def install_catalog_style(
    db: AsyncSession,
    user_id: str | UUID,
    catalog_style_id: str,
    *,
    catalog_version: int | None = None,
) -> dict[str, Any]:
    uid = _user_uuid(user_id)
    catalog_style_id = (catalog_style_id or "").strip()
    if not catalog_style_id:
        raise HTTPException(status_code=400, detail="catalog_style_id required.")

    existing_install = (
        await db.execute(
            select(DictationStyleInstall).where(
                DictationStyleInstall.user_id == uid,
                DictationStyleInstall.catalog_style_id == catalog_style_id,
            )
        )
    ).scalars().first()
    if existing_install and existing_install.style_id:
        existing_style = await db.get(UserDictationStyle, existing_install.style_id)
        if existing_style and existing_style.user_id == uid:
            return {"style": _style_payload(existing_style), "already_installed": True}

    catalog = await fetch_catalog_style(catalog_style_id)
    category_id = str(catalog.get("category_id") or "personal_casual")
    # Map catalog category folder id → user category type_kind (same ids).
    type_kind = category_id
    cat_title = str(catalog.get("field") or type_kind).replace("_", " ").title()
    # Prefer taxonomy category title from path prefix when possible.
    path = str(catalog.get("taxonomy_path") or "")
    if path:
        type_kind = path.split(".", 1)[0] or type_kind

    category = await _ensure_category_for_kind(db, uid, type_kind, cat_title)
    contract = catalog.get("compiled_contract") or {}
    name = str(catalog.get("display_name") or catalog_style_id)
    explanation = str(catalog.get("use_case") or catalog.get("directive") or "")
    rules = ""
    if isinstance(contract, dict):
        obj = contract.get("objective")
        if obj:
            rules = str(obj)

    style = UserDictationStyle(
        id=uuid.uuid4(),
        user_id=uid,
        category_id=category.id,
        name=name,
        explanation=explanation,
        rules=rules,
        taxonomy_path=catalog.get("taxonomy_path"),
        compiled_contract=contract if isinstance(contract, dict) else None,
        source_catalog_id=catalog_style_id,
        catalog_version=catalog_version or int(catalog.get("taxonomy_version") or 1),
        parent_style_id=None,
        bound_room_id=None,
        kind="template",
        created_at=_now(),
        updated_at=_now(),
    )
    db.add(style)
    await db.flush()

    if not existing_install:
        db.add(
            DictationStyleInstall(
                user_id=uid,
                catalog_style_id=catalog_style_id,
                style_id=style.id,
                created_at=_now(),
            )
        )
        stats = await db.get(DictationStyleStats, catalog_style_id)
        if not stats:
            stats = DictationStyleStats(
                catalog_style_id=catalog_style_id,
                download_count=0,
                rating_sum=0,
                rating_count=0,
                updated_at=_now(),
            )
            db.add(stats)
        stats.download_count = int(stats.download_count or 0) + 1
        stats.updated_at = _now()
    else:
        existing_install.style_id = style.id

    await db.commit()
    await db.refresh(style)
    return {"style": _style_payload(style), "already_installed": False}


async def assign_to_room(
    db: AsyncSession,
    user_id: str | UUID,
    template_style_id: str,
    room_id: str,
) -> dict[str, Any]:
    uid = _user_uuid(user_id)
    room_id = (room_id or "").strip()
    if not room_id:
        raise HTTPException(status_code=400, detail="room_id required.")
    template = await db.get(UserDictationStyle, UUID(str(template_style_id)))
    if not template or template.user_id != uid:
        raise HTTPException(status_code=404, detail="Style not found.")
    if template.kind == "room_copy":
        # Allow re-copying from a room copy's content, but prefer templates.
        pass

    copy = UserDictationStyle(
        id=uuid.uuid4(),
        user_id=uid,
        category_id=template.category_id,
        name=template.name,
        explanation=template.explanation,
        rules=template.rules,
        taxonomy_path=template.taxonomy_path,
        compiled_contract=template.compiled_contract,
        source_catalog_id=template.source_catalog_id,
        catalog_version=template.catalog_version,
        parent_style_id=template.id,
        bound_room_id=room_id,
        kind="room_copy",
        created_at=_now(),
        updated_at=_now(),
    )
    db.add(copy)
    await db.commit()
    await db.refresh(copy)
    return {"style": _style_payload(copy)}


async def fork_style(
    db: AsyncSession,
    user_id: str | UUID,
    style_id: str,
    *,
    name: str | None = None,
    compiled_contract: dict[str, Any] | None = None,
    explanation: str | None = None,
    rules: str | None = None,
    bound_room_id: str | None = None,
) -> dict[str, Any]:
    uid = _user_uuid(user_id)
    parent = await db.get(UserDictationStyle, UUID(str(style_id)))
    if not parent or parent.user_id != uid:
        raise HTTPException(status_code=404, detail="Style not found.")

    fork = UserDictationStyle(
        id=uuid.uuid4(),
        user_id=uid,
        category_id=parent.category_id,
        name=(name or parent.name).strip() or parent.name,
        explanation=explanation if explanation is not None else parent.explanation,
        rules=rules if rules is not None else parent.rules,
        taxonomy_path=parent.taxonomy_path,
        compiled_contract=compiled_contract if compiled_contract is not None else parent.compiled_contract,
        source_catalog_id=parent.source_catalog_id,
        catalog_version=parent.catalog_version,
        parent_style_id=parent.id,
        bound_room_id=bound_room_id if bound_room_id is not None else parent.bound_room_id,
        kind="custom_fork",
        created_at=_now(),
        updated_at=_now(),
    )
    db.add(fork)
    await db.commit()
    await db.refresh(fork)
    return {"style": _style_payload(fork)}


async def delete_style(db: AsyncSession, user_id: str | UUID, style_id: str) -> dict[str, Any]:
    uid = _user_uuid(user_id)
    row = await db.get(UserDictationStyle, UUID(str(style_id)))
    if not row or row.user_id != uid:
        raise HTTPException(status_code=404, detail="Style not found.")
    await db.delete(row)
    await db.commit()
    return {"deleted": True, "id": style_id}


async def rate_catalog_style(
    db: AsyncSession,
    user_id: str | UUID,
    catalog_style_id: str,
    stars: int,
) -> dict[str, Any]:
    uid = _user_uuid(user_id)
    catalog_style_id = (catalog_style_id or "").strip()
    if not catalog_style_id:
        raise HTTPException(status_code=400, detail="catalog_style_id required.")
    if stars < 1 or stars > 5:
        raise HTTPException(status_code=400, detail="stars must be 1–5.")

    existing = (
        await db.execute(
            select(DictationStyleRating).where(
                DictationStyleRating.user_id == uid,
                DictationStyleRating.catalog_style_id == catalog_style_id,
            )
        )
    ).scalars().first()
    stats = await db.get(DictationStyleStats, catalog_style_id)
    if not stats:
        stats = DictationStyleStats(
            catalog_style_id=catalog_style_id,
            download_count=0,
            rating_sum=0,
            rating_count=0,
            updated_at=_now(),
        )
        db.add(stats)

    if existing:
        stats.rating_sum = int(stats.rating_sum or 0) - int(existing.stars) + stars
        existing.stars = stars
        existing.updated_at = _now()
    else:
        db.add(
            DictationStyleRating(
                user_id=uid,
                catalog_style_id=catalog_style_id,
                stars=stars,
                updated_at=_now(),
            )
        )
        stats.rating_sum = int(stats.rating_sum or 0) + stars
        stats.rating_count = int(stats.rating_count or 0) + 1

    stats.updated_at = _now()
    await db.commit()
    await db.refresh(stats)
    return _stats_payload(stats, catalog_style_id)
