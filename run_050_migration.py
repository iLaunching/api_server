#!/usr/bin/env python3
"""Apply migration 050_create_user_media.sql"""

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

    sql_path = Path(__file__).parent / "migrations" / "050_create_user_media.sql"
    sql = sql_path.read_text(encoding="utf-8")

    engine = create_async_engine(database_url, echo=True)
    async with engine.begin() as conn:
        await conn.execute(text(sql))
    await engine.dispose()
    print("Migration 050 applied successfully.")


if __name__ == "__main__":
    asyncio.run(main())
