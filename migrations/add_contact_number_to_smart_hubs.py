"""
Migration: Add contact_number column to smart_hubs table.

Matches sizing/semantics of user_profiles.phone (VARCHAR(20), nullable).
Follows the same migration pattern as other api-server migrations (SQLAlchemy + get_db).
"""

import asyncio

import structlog
from sqlalchemy import text

from config.database import get_db


logger = structlog.get_logger()


async def upgrade():
    async for db in get_db():
        try:
            logger.info("Starting migration: add_contact_number_to_smart_hubs")

            await db.execute(
                text(
                    """
                    ALTER TABLE smart_hubs
                    ADD COLUMN IF NOT EXISTS contact_number VARCHAR(20);
                    """
                )
            )

            await db.execute(
                text(
                    """
                    COMMENT ON COLUMN smart_hubs.contact_number IS
                    'Optional hub-level contact phone number (same sizing as user_profiles.phone)';
                    """
                )
            )

            await db.commit()
            logger.info("✅ Migration completed successfully: add_contact_number_to_smart_hubs")
        except Exception as e:
            await db.rollback()
            logger.error("❌ Migration failed: add_contact_number_to_smart_hubs", error=str(e))
            raise
        finally:
            break


async def downgrade():
    async for db in get_db():
        try:
            logger.info("Starting rollback: add_contact_number_to_smart_hubs")
            await db.execute(
                text(
                    """
                    ALTER TABLE smart_hubs
                    DROP COLUMN IF EXISTS contact_number;
                    """
                )
            )
            await db.commit()
            logger.info("✅ Rollback completed successfully: add_contact_number_to_smart_hubs")
        except Exception as e:
            await db.rollback()
            logger.error("❌ Rollback failed: add_contact_number_to_smart_hubs", error=str(e))
            raise
        finally:
            break


if __name__ == "__main__":
    import sys

    if len(sys.argv) > 1 and sys.argv[1] == "downgrade":
        asyncio.run(downgrade())
    else:
        asyncio.run(upgrade())

