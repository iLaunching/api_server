"""
Migration 036: Move synapse_number from user_profiles -> smart_hubs.

Adds smart_hubs.synapse_number (unique), backfills from user_profiles, then drops the old column.
"""

import asyncio

import structlog
from sqlalchemy import text

from config.database import get_db


logger = structlog.get_logger()


async def upgrade():
    async for db in get_db():
        try:
            logger.info("Starting migration: 036_move_synapse_number_to_smart_hubs")

            await db.execute(
                text(
                    """
                    ALTER TABLE smart_hubs
                    ADD COLUMN IF NOT EXISTS synapse_number VARCHAR(20);

                    CREATE UNIQUE INDEX IF NOT EXISTS idx_smart_hubs_synapse_number
                    ON smart_hubs(synapse_number);

                    COMMENT ON COLUMN smart_hubs.synapse_number IS
                    'Unique digits-only synapse identifier for routing (moved from user_profiles)';

                    WITH hub_choice AS (
                      SELECT DISTINCT ON (owner_id)
                        id AS hub_id,
                        owner_id
                      FROM smart_hubs
                      ORDER BY owner_id, is_default DESC, created_at ASC
                    )
                    UPDATE smart_hubs h
                    SET synapse_number = up.synapse_number
                    FROM hub_choice hc
                    JOIN user_profiles up ON up.user_id = hc.owner_id
                    WHERE h.id = hc.hub_id
                      AND (h.synapse_number IS NULL OR h.synapse_number = '')
                      AND up.synapse_number IS NOT NULL
                      AND up.synapse_number <> '';

                    DROP INDEX IF EXISTS idx_synapse_number;

                    ALTER TABLE user_profiles
                    DROP COLUMN IF EXISTS synapse_number;
                    """
                )
            )

            await db.commit()
            logger.info("✅ Migration completed successfully: 036_move_synapse_number_to_smart_hubs")
        except Exception as e:
            await db.rollback()
            logger.error("❌ Migration failed: 036_move_synapse_number_to_smart_hubs", error=str(e))
            raise
        finally:
            break


async def downgrade():
    async for db in get_db():
        try:
            logger.info("Starting rollback: 036_move_synapse_number_to_smart_hubs")

            await db.execute(
                text(
                    """
                    ALTER TABLE user_profiles
                    ADD COLUMN IF NOT EXISTS synapse_number VARCHAR(20);

                    CREATE UNIQUE INDEX IF NOT EXISTS idx_synapse_number
                    ON user_profiles(synapse_number);

                    COMMENT ON COLUMN user_profiles.synapse_number IS
                    'Unique public identifier for Ear Server and related routing';

                    WITH hub_choice AS (
                      SELECT DISTINCT ON (owner_id)
                        id AS hub_id,
                        owner_id
                      FROM smart_hubs
                      ORDER BY owner_id, is_default DESC, created_at ASC
                    )
                    UPDATE user_profiles up
                    SET synapse_number = h.synapse_number
                    FROM hub_choice hc
                    JOIN smart_hubs h ON h.id = hc.hub_id
                    WHERE up.user_id = hc.owner_id
                      AND (up.synapse_number IS NULL OR up.synapse_number = '')
                      AND h.synapse_number IS NOT NULL
                      AND h.synapse_number <> '';

                    DROP INDEX IF EXISTS idx_smart_hubs_synapse_number;

                    ALTER TABLE smart_hubs
                    DROP COLUMN IF EXISTS synapse_number;
                    """
                )
            )

            await db.commit()
            logger.info("✅ Rollback completed successfully: 036_move_synapse_number_to_smart_hubs")
        except Exception as e:
            await db.rollback()
            logger.error("❌ Rollback failed: 036_move_synapse_number_to_smart_hubs", error=str(e))
            raise
        finally:
            break


if __name__ == "__main__":
    import sys

    if len(sys.argv) > 1 and sys.argv[1] == "downgrade":
        asyncio.run(downgrade())
    else:
        asyncio.run(upgrade())

