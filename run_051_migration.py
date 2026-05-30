#!/usr/bin/env python3
"""Apply migration 051_user_media_recently_used.sql"""

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

    sql_path = Path(__file__).parent / "migrations" / "051_user_media_recently_used.sql"
    sql = sql_path.read_text(encoding="utf-8")

    engine = create_async_engine(database_url, echo=True)
    async with engine.begin() as conn:
        await conn.execute(text(sql))
    await engine.dispose()
    print("Migration 051 applied successfully.")


if __name__ == "__main__":
    asyncio.run(main())
