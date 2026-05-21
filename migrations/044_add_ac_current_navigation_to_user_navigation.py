"""
Migration 044: Add user_navigation ac_current_smart_hub_id / ac_current_smart_matrix_id.
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
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'user_navigation'
          AND column_name = 'ac_current_smart_hub_id'
    ) THEN
        ALTER TABLE user_navigation
            ADD COLUMN ac_current_smart_hub_id UUID UNIQUE
                REFERENCES smart_hubs(id) ON DELETE SET NULL;
        COMMENT ON COLUMN user_navigation.ac_current_smart_hub_id IS
            'Active Chat: current smart hub context (mirrors current_smart_hub_id)';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'user_navigation'
          AND column_name = 'ac_current_smart_matrix_id'
    ) THEN
        ALTER TABLE user_navigation
            ADD COLUMN ac_current_smart_matrix_id UUID UNIQUE
                REFERENCES smart_matrices(id) ON DELETE SET NULL;
        COMMENT ON COLUMN user_navigation.ac_current_smart_matrix_id IS
            'Active Chat: current smart matrix context (mirrors current_smart_matrix_id)';
    END IF;

    CREATE INDEX IF NOT EXISTS idx_user_navigation_ac_current_smart_hub_id
        ON user_navigation(ac_current_smart_hub_id);
    CREATE INDEX IF NOT EXISTS idx_user_navigation_ac_current_smart_matrix_id
        ON user_navigation(ac_current_smart_matrix_id);

    UPDATE user_navigation
    SET ac_current_smart_hub_id = current_smart_hub_id
    WHERE ac_current_smart_hub_id IS NULL
      AND current_smart_hub_id IS NOT NULL;

    UPDATE user_navigation
    SET ac_current_smart_matrix_id = current_smart_matrix_id
    WHERE ac_current_smart_matrix_id IS NULL
      AND current_smart_matrix_id IS NOT NULL;
END $$;
"""


async def upgrade():
    async for db in get_db():
        try:
            logger.info("Starting migration: 044_add_ac_current_navigation_to_user_navigation")
            await db.execute(text(_UPGRADE_SQL))
            await db.commit()
            logger.info(
                "✅ Migration completed: 044_add_ac_current_navigation_to_user_navigation"
            )
        except Exception as e:
            await db.rollback()
            logger.error(
                "❌ Migration failed: 044_add_ac_current_navigation_to_user_navigation",
                error=str(e),
            )
            raise
        finally:
            break


async def downgrade():
    async for db in get_db():
        try:
            logger.info("Starting rollback: 044_add_ac_current_navigation_to_user_navigation")
            await db.execute(
                text("DROP INDEX IF EXISTS idx_user_navigation_ac_current_smart_matrix_id;")
            )
            await db.execute(
                text("DROP INDEX IF EXISTS idx_user_navigation_ac_current_smart_hub_id;")
            )
            await db.execute(
                text(
                    "ALTER TABLE user_navigation DROP COLUMN IF EXISTS ac_current_smart_matrix_id;"
                )
            )
            await db.execute(
                text(
                    "ALTER TABLE user_navigation DROP COLUMN IF EXISTS ac_current_smart_hub_id;"
                )
            )
            await db.commit()
            logger.info(
                "✅ Rollback completed: 044_add_ac_current_navigation_to_user_navigation"
            )
        except Exception as e:
            await db.rollback()
            logger.error(
                "❌ Rollback failed: 044_add_ac_current_navigation_to_user_navigation",
                error=str(e),
            )
            raise
        finally:
            break


if __name__ == "__main__":
    import sys

    if len(sys.argv) > 1 and sys.argv[1] == "downgrade":
        asyncio.run(downgrade())
    else:
        asyncio.run(upgrade())
