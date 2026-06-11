#!/usr/bin/env python3
"""Apply migration 060_user_media_catalog_object_path.sql"""

import asyncio
import os
from pathlib import Path

from sqlalchemy import text
from sqlalchemy.ext.asyncio import create_async_engine


async def main() -> None:
    database_url = os.environ.get("DATABASE_URL")
    if not database_url:
        raise SystemExit("DATABASE_URL is required")

    if database_url.startswith("postgresql://"):
        database_url = database_url.replace("postgresql://", "postgresql+asyncpg://", 1)

    sql_path = Path(__file__).parent / "migrations" / "060_user_media_catalog_object_path.sql"
    sql = sql_path.read_text(encoding="utf-8").strip()
    statements = [s.strip() for s in sql.split(";") if s.strip() and not s.strip().startswith("--")]

    engine = create_async_engine(database_url, echo=True)
    async with engine.begin() as conn:
        for statement in statements:
            await conn.execute(text(statement))
    await engine.dispose()
    print("Migration 060 applied successfully.")


if __name__ == "__main__":
    asyncio.run(main())
