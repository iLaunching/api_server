"""
Migration 039: Add user_profiles.activeChat_onBoarding_complete (boolean, default false).
"""

import asyncio

import structlog
from sqlalchemy import text

from config.database import get_db


logger = structlog.get_logger()


async def upgrade():
    async for db in get_db():
        try:
            logger.info(
                "Starting migration: 039_add_active_chat_onboarding_complete_to_user_profiles"
            )

            await db.execute(
                text(
                    """
                    ALTER TABLE user_profiles
                    ADD COLUMN IF NOT EXISTS "activeChat_onBoarding_complete"
                        BOOLEAN DEFAULT FALSE NOT NULL;
                    """
                )
            )

            await db.execute(
                text(
                    """
                    COMMENT ON COLUMN user_profiles."activeChat_onBoarding_complete" IS
                    'True when the user has finished Active Chat onboarding';
                    """
                )
            )

            await db.commit()
            logger.info(
                "✅ Migration completed successfully: "
                "039_add_active_chat_onboarding_complete_to_user_profiles"
            )
        except Exception as e:
            await db.rollback()
            logger.error(
                "❌ Migration failed: 039_add_active_chat_onboarding_complete_to_user_profiles",
                error=str(e),
            )
            raise
        finally:
            break


async def downgrade():
    async for db in get_db():
        try:
            logger.info(
                "Starting rollback: 039_add_active_chat_onboarding_complete_to_user_profiles"
            )
            await db.execute(
                text(
                    """
                    ALTER TABLE user_profiles
                    DROP COLUMN IF EXISTS "activeChat_onBoarding_complete";
                    """
                )
            )
            await db.commit()
            logger.info(
                "✅ Rollback completed successfully: "
                "039_add_active_chat_onboarding_complete_to_user_profiles"
            )
        except Exception as e:
            await db.rollback()
            logger.error(
                "❌ Rollback failed: 039_add_active_chat_onboarding_complete_to_user_profiles",
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
