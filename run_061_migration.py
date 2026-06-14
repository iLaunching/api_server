#!/usr/bin/env python3
"""Apply migration 061_user_media_wallpaper_color_recently_used.sql"""

import asyncio
import os

from sqlalchemy import text
from sqlalchemy.ext.asyncio import create_async_engine

STATEMENTS = [
    "ALTER TABLE user_media ADD COLUMN IF NOT EXISTS wallpaper_color_palette_id TEXT",
    "ALTER TABLE user_media ADD COLUMN IF NOT EXISTS solid_hex TEXT",
    "ALTER TABLE user_media ADD COLUMN IF NOT EXISTS background_config JSONB",
    """CREATE UNIQUE INDEX IF NOT EXISTS uq_user_media_user_wallpaper_color
        ON user_media(user_id, wallpaper_color_palette_id, solid_hex)
        WHERE kind = 'wallpaper_color'
          AND wallpaper_color_palette_id IS NOT NULL
          AND solid_hex IS NOT NULL""",
]


async def main() -> None:
    database_url = os.environ.get("DATABASE_URL")
    if not database_url:
        raise SystemExit("DATABASE_URL is required")

    if database_url.startswith("postgresql://"):
        database_url = database_url.replace("postgresql://", "postgresql+asyncpg://", 1)

    engine = create_async_engine(database_url)
    async with engine.begin() as conn:
        for statement in STATEMENTS:
            await conn.execute(text(statement))
    await engine.dispose()
    print("Migration 061 applied successfully.")


if __name__ == "__main__":
    asyncio.run(main())
