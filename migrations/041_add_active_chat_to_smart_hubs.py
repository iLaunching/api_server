"""
Migration 041: Add smart_hubs.activeChat FK to activeChat.id.
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
        IF NOT EXISTS (
            SELECT 1 FROM information_schema.columns
            WHERE table_schema = 'public'
              AND table_name = 'smart_hubs'
              AND column_name = 'activeChat'
        ) THEN
            ALTER TABLE smart_hubs
                ADD COLUMN "activeChat" INTEGER
                    REFERENCES "activeChat"(id) ON DELETE SET NULL;
            COMMENT ON COLUMN smart_hubs."activeChat" IS
                'FK to activeChat.id (per-user Active Chat theme/avatar config)';
        END IF;

        IF EXISTS (
            SELECT 1 FROM information_schema.columns
            WHERE table_schema = 'public'
              AND table_name = 'smart_hubs'
              AND column_name = 'activeChat'
        ) THEN
            CREATE INDEX IF NOT EXISTS idx_smart_hubs_active_chat
                ON smart_hubs ("activeChat");

            UPDATE smart_hubs sh
            SET "activeChat" = ac.id
            FROM "activeChat" ac
            WHERE sh.owner_id = ac.user_id
              AND sh."activeChat" IS NULL;
        END IF;
    END IF;
END $$;
"""


async def upgrade():
    async for db in get_db():
        try:
            logger.info("Starting migration: 041_add_active_chat_to_smart_hubs")
            await db.execute(text(_UPGRADE_SQL))
            await db.commit()
            logger.info("✅ Migration completed successfully: 041_add_active_chat_to_smart_hubs")
        except Exception as e:
            await db.rollback()
            logger.error("❌ Migration failed: 041_add_active_chat_to_smart_hubs", error=str(e))
            raise
        finally:
            break


async def downgrade():
    async for db in get_db():
        try:
            logger.info("Starting rollback: 041_add_active_chat_to_smart_hubs")
            await db.execute(text('DROP INDEX IF EXISTS idx_smart_hubs_active_chat;'))
            await db.execute(
                text('ALTER TABLE smart_hubs DROP COLUMN IF EXISTS "activeChat";')
            )
            await db.commit()
            logger.info("✅ Rollback completed successfully: 041_add_active_chat_to_smart_hubs")
        except Exception as e:
            await db.rollback()
            logger.error("❌ Rollback failed: 041_add_active_chat_to_smart_hubs", error=str(e))
            raise
        finally:
            break


if __name__ == "__main__":
    import sys

    if len(sys.argv) > 1 and sys.argv[1] == "downgrade":
        asyncio.run(downgrade())
    else:
        asyncio.run(upgrade())
