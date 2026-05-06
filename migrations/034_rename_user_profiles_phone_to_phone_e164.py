"""
Migration 034: Rename user_profiles.phone -> user_profiles.phone_e164 (E.164 format).

Uses conditional DDL to be resilient across environments.
"""

import asyncio

import structlog
from sqlalchemy import text

from config.database import get_db


logger = structlog.get_logger()


async def upgrade():
    async for db in get_db():
        try:
            logger.info("Starting migration: 034_rename_user_profiles_phone_to_phone_e164")

            await db.execute(
                text(
                    """
                    DO $$
                    BEGIN
                      IF EXISTS (
                        SELECT 1
                        FROM information_schema.columns
                        WHERE table_name = 'user_profiles'
                          AND column_name = 'phone'
                      ) AND NOT EXISTS (
                        SELECT 1
                        FROM information_schema.columns
                        WHERE table_name = 'user_profiles'
                          AND column_name = 'phone_e164'
                      ) THEN
                        EXECUTE 'ALTER TABLE user_profiles RENAME COLUMN phone TO phone_e164';
                      END IF;
                    END $$;
                    """
                )
            )

            await db.execute(
                text(
                    """
                    COMMENT ON COLUMN user_profiles.phone_e164 IS 'User phone number in E.164 format';
                    """
                )
            )

            await db.commit()
            logger.info("✅ Migration completed successfully: 034_rename_user_profiles_phone_to_phone_e164")
        except Exception as e:
            await db.rollback()
            logger.error("❌ Migration failed: 034_rename_user_profiles_phone_to_phone_e164", error=str(e))
            raise
        finally:
            break


async def downgrade():
    async for db in get_db():
        try:
            logger.info("Starting rollback: 034_rename_user_profiles_phone_to_phone_e164")

            await db.execute(
                text(
                    """
                    DO $$
                    BEGIN
                      IF EXISTS (
                        SELECT 1
                        FROM information_schema.columns
                        WHERE table_name = 'user_profiles'
                          AND column_name = 'phone_e164'
                      ) AND NOT EXISTS (
                        SELECT 1
                        FROM information_schema.columns
                        WHERE table_name = 'user_profiles'
                          AND column_name = 'phone'
                      ) THEN
                        EXECUTE 'ALTER TABLE user_profiles RENAME COLUMN phone_e164 TO phone';
                      END IF;
                    END $$;
                    """
                )
            )

            await db.commit()
            logger.info("✅ Rollback completed successfully: 034_rename_user_profiles_phone_to_phone_e164")
        except Exception as e:
            await db.rollback()
            logger.error("❌ Rollback failed: 034_rename_user_profiles_phone_to_phone_e164", error=str(e))
            raise
        finally:
            break


if __name__ == "__main__":
    import sys

    if len(sys.argv) > 1 and sys.argv[1] == "downgrade":
        asyncio.run(downgrade())
    else:
        asyncio.run(upgrade())

