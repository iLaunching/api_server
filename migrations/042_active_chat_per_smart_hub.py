"""
Migration 042: Drop activeChat.user_id UNIQUE — one activeChat row per smart hub.
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
        ALTER TABLE "activeChat" DROP CONSTRAINT IF EXISTS "activeChat_user_id_key";

        COMMENT ON TABLE "activeChat" IS
            'Per smart hub Active Chat appearance and avatar settings (linked from smart_hubs.activeChat)';
    END IF;

    IF EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'smart_hubs'
          AND column_name = 'activeChat'
    ) THEN
        COMMENT ON COLUMN smart_hubs."activeChat" IS
            'FK to activeChat.id (this hub''s Active Chat theme/avatar config)';
    END IF;
END $$;
"""


async def upgrade():
    async for db in get_db():
        try:
            logger.info("Starting migration: 042_active_chat_per_smart_hub")
            await db.execute(text(_UPGRADE_SQL))
            await db.commit()
            logger.info("✅ Migration completed: 042_active_chat_per_smart_hub")
        except Exception as e:
            await db.rollback()
            logger.error("❌ Migration failed: 042_active_chat_per_smart_hub", error=str(e))
            raise
        finally:
            break


if __name__ == "__main__":
    asyncio.run(upgrade())
