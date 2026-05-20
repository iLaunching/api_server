"""
Migration 043: Drop avatar/display columns from activeChat (live on user_profiles).
"""

import asyncio

import structlog
from sqlalchemy import text

from config.database import get_db

logger = structlog.get_logger()

_UPGRADE_SQL = """
DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM information_schema.tables
        WHERE table_schema = 'public' AND table_name = 'activeChat'
    ) THEN
        DROP INDEX IF EXISTS idx_active_chat_avatar_display_option_id;
        DROP INDEX IF EXISTS idx_active_chat_profile_icon_id;
        DROP INDEX IF EXISTS idx_active_chat_avatar_color_id;

        ALTER TABLE "activeChat"
            DROP COLUMN IF EXISTS avatar_display_option_id,
            DROP COLUMN IF EXISTS profile_icon_id,
            DROP COLUMN IF EXISTS avatar_color_id,
            DROP COLUMN IF EXISTS avatar_icon,
            DROP COLUMN IF EXISTS avatar_image;

        COMMENT ON TABLE "activeChat" IS
            'Per smart hub Active Chat theme (appearance + itheme); avatar/display on user_profiles';
    END IF;
END $$;
"""


async def upgrade():
    async for db in get_db():
        try:
            logger.info("Starting migration: 043_drop_active_chat_avatar_columns")
            await db.execute(text(_UPGRADE_SQL))
            await db.commit()
            logger.info("✅ Migration completed: 043_drop_active_chat_avatar_columns")
        except Exception as e:
            await db.rollback()
            logger.error("❌ Migration failed: 043_drop_active_chat_avatar_columns", error=str(e))
            raise
        finally:
            break


if __name__ == "__main__":
    asyncio.run(upgrade())
