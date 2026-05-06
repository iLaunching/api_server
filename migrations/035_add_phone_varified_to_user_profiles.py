"""
Migration 035: Add user_profiles.phone_varified boolean default false.
"""

import asyncio

import structlog
from sqlalchemy import text

from config.database import get_db


logger = structlog.get_logger()


async def upgrade():
    async for db in get_db():
        try:
            logger.info("Starting migration: 035_add_phone_varified_to_user_profiles")

            await db.execute(
                text(
                    """
                    ALTER TABLE user_profiles
                    ADD COLUMN IF NOT EXISTS phone_varified BOOLEAN DEFAULT FALSE NOT NULL;
                    """
                )
            )

            await db.execute(
                text(
                    """
                    COMMENT ON COLUMN user_profiles.phone_varified IS
                    'Whether phone number has been verified';
                    """
                )
            )

            await db.commit()
            logger.info("✅ Migration completed successfully: 035_add_phone_varified_to_user_profiles")
        except Exception as e:
            await db.rollback()
            logger.error("❌ Migration failed: 035_add_phone_varified_to_user_profiles", error=str(e))
            raise
        finally:
            break


async def downgrade():
    async for db in get_db():
        try:
            logger.info("Starting rollback: 035_add_phone_varified_to_user_profiles")
            await db.execute(
                text(
                    """
                    ALTER TABLE user_profiles
                    DROP COLUMN IF EXISTS phone_varified;
                    """
                )
            )
            await db.commit()
            logger.info("✅ Rollback completed successfully: 035_add_phone_varified_to_user_profiles")
        except Exception as e:
            await db.rollback()
            logger.error("❌ Rollback failed: 035_add_phone_varified_to_user_profiles", error=str(e))
            raise
        finally:
            break


if __name__ == "__main__":
    import sys

    if len(sys.argv) > 1 and sys.argv[1] == "downgrade":
        asyncio.run(downgrade())
    else:
        asyncio.run(upgrade())

