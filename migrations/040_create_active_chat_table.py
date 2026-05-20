"""
Migration 040: Create activeChat table.
"""

import asyncio

import structlog
from sqlalchemy import text

from config.database import get_db


logger = structlog.get_logger()

_UPGRADE_SQL = """
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.tables
        WHERE table_schema = 'public' AND table_name = 'activeChat'
    ) THEN
        CREATE TABLE "activeChat" (
            id SERIAL PRIMARY KEY,
            user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
            appearance_option_id INTEGER REFERENCES option_values(id) ON DELETE SET NULL DEFAULT 6,
            itheme_option_id INTEGER REFERENCES option_values(id) ON DELETE SET NULL DEFAULT 10,
            avatar_display_option_id INTEGER DEFAULT 24,
            profile_icon_id INTEGER REFERENCES option_values(id) ON DELETE SET NULL,
            avatar_color_id INTEGER REFERENCES option_values(id) ON DELETE SET NULL,
            avatar_icon TEXT,
            avatar_image TEXT,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
        );

        CREATE INDEX idx_active_chat_user_id ON "activeChat"(user_id);
        CREATE INDEX idx_active_chat_appearance_option_id ON "activeChat"(appearance_option_id);
        CREATE INDEX idx_active_chat_itheme_option_id ON "activeChat"(itheme_option_id);
        CREATE INDEX idx_active_chat_avatar_display_option_id ON "activeChat"(avatar_display_option_id);
        CREATE INDEX idx_active_chat_profile_icon_id ON "activeChat"(profile_icon_id);
        CREATE INDEX idx_active_chat_avatar_color_id ON "activeChat"(avatar_color_id);

        COMMENT ON TABLE "activeChat" IS 'Per-user Active Chat appearance and avatar settings';
        COMMENT ON COLUMN "activeChat".appearance_option_id IS 'FK to option_values (appearance: sun, moon, etc.)';
        COMMENT ON COLUMN "activeChat".itheme_option_id IS 'FK to option_values (itheme: ipurple, iblue, etc.)';
        COMMENT ON COLUMN "activeChat".avatar_display_option_id IS 'Avatar display mode (24=initials, 25=image, 26=icon)';
        COMMENT ON COLUMN "activeChat".profile_icon_id IS 'FK to option_values (icon_library)';
        COMMENT ON COLUMN "activeChat".avatar_color_id IS 'FK to option_values (smarthub_color_scheme)';
        COMMENT ON COLUMN "activeChat".avatar_icon IS 'Icon identifier for avatar display';
        COMMENT ON COLUMN "activeChat".avatar_image IS 'Image URL or data for avatar display';
    END IF;
END $$;
"""


async def upgrade():
    async for db in get_db():
        try:
            logger.info("Starting migration: 040_create_active_chat_table")
            await db.execute(text(_UPGRADE_SQL))
            await db.commit()
            logger.info("✅ Migration completed successfully: 040_create_active_chat_table")
        except Exception as e:
            await db.rollback()
            logger.error("❌ Migration failed: 040_create_active_chat_table", error=str(e))
            raise
        finally:
            break


async def downgrade():
    async for db in get_db():
        try:
            logger.info("Starting rollback: 040_create_active_chat_table")
            await db.execute(text('DROP TABLE IF EXISTS "activeChat" CASCADE;'))
            await db.commit()
            logger.info("✅ Rollback completed successfully: 040_create_active_chat_table")
        except Exception as e:
            await db.rollback()
            logger.error("❌ Rollback failed: 040_create_active_chat_table", error=str(e))
            raise
        finally:
            break


if __name__ == "__main__":
    import sys

    if len(sys.argv) > 1 and sys.argv[1] == "downgrade":
        asyncio.run(downgrade())
    else:
        asyncio.run(upgrade())
