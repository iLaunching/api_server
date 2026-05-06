"""
Migration 037: Add user_profiles.e164 (VARCHAR(20), nullable).
"""

import asyncio

import structlog
from sqlalchemy import text

from config.database import get_db


logger = structlog.get_logger()


async def upgrade():
    async for db in get_db():
        try:
            logger.info("Starting migration: 037_add_e164_to_user_profiles")

            await db.execute(
                text(
                    """
                    ALTER TABLE user_profiles
                    ADD COLUMN IF NOT EXISTS e164 VARCHAR(20);
                    """
                )
            )

            await db.execute(
                text(
                    """
                    COMMENT ON COLUMN user_profiles.e164 IS 'Phone number in E.164 format';
                    """
                )
            )

            await db.commit()
            logger.info("✅ Migration completed successfully: 037_add_e164_to_user_profiles")
        except Exception as e:
            await db.rollback()
            logger.error("❌ Migration failed: 037_add_e164_to_user_profiles", error=str(e))
            raise
        finally:
            break


async def downgrade():
    async for db in get_db():
        try:
            logger.info("Starting rollback: 037_add_e164_to_user_profiles")
            await db.execute(text("ALTER TABLE user_profiles DROP COLUMN IF EXISTS e164;"))
            await db.commit()
            logger.info("✅ Rollback completed successfully: 037_add_e164_to_user_profiles")
        except Exception as e:
            await db.rollback()
            logger.error("❌ Rollback failed: 037_add_e164_to_user_profiles", error=str(e))
            raise
        finally:
            break


if __name__ == "__main__":
    import sys

    if len(sys.argv) > 1 and sys.argv[1] == "downgrade":
        asyncio.run(downgrade())
    else:
        asyncio.run(upgrade())

