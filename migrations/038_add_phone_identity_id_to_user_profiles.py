"""
Migration 038: Add user_profiles.phone_identity_id (FK to phone_identities.id, 1:1 optional).
"""

import asyncio

import structlog
from sqlalchemy import text

from config.database import get_db


logger = structlog.get_logger()


async def upgrade():
    async for db in get_db():
        try:
            logger.info("Starting migration: 038_add_phone_identity_id_to_user_profiles")

            row = await db.execute(
                text(
                    """
                    SELECT EXISTS (
                        SELECT 1 FROM information_schema.tables
                        WHERE table_schema = 'public' AND table_name = 'phone_identities'
                    ) AS has_pi
                    """
                )
            )
            has_pi = row.scalar()
            if not has_pi:
                logger.warning(
                    "Skipping 038: phone_identities table not present",
                )
                await db.commit()
                return

            await db.execute(
                text(
                    """
                    ALTER TABLE user_profiles
                    ADD COLUMN IF NOT EXISTS phone_identity_id UUID
                        REFERENCES phone_identities(id) ON DELETE SET NULL;
                    """
                )
            )

            await db.execute(
                text(
                    """
                    COMMENT ON COLUMN user_profiles.phone_identity_id IS
                    'FK to phone_identities.id (optional 1:1 verified phone binding)';
                    """
                )
            )

            await db.execute(
                text(
                    """
                    CREATE UNIQUE INDEX IF NOT EXISTS idx_user_profiles_phone_identity_id
                    ON user_profiles (phone_identity_id);
                    """
                )
            )

            await db.execute(
                text(
                    """
                    UPDATE user_profiles up
                    SET phone_identity_id = pi.id
                    FROM phone_identities pi
                    WHERE pi.user_id = up.user_id
                      AND up.phone_identity_id IS NULL
                      AND pi.revoked_at IS NULL;
                    """
                )
            )

            await db.commit()
            logger.info(
                "✅ Migration completed successfully: 038_add_phone_identity_id_to_user_profiles"
            )
        except Exception as e:
            await db.rollback()
            logger.error(
                "❌ Migration failed: 038_add_phone_identity_id_to_user_profiles",
                error=str(e),
            )
            raise
        finally:
            break


async def downgrade():
    async for db in get_db():
        try:
            logger.info("Starting rollback: 038_add_phone_identity_id_to_user_profiles")
            await db.execute(
                text("DROP INDEX IF EXISTS idx_user_profiles_phone_identity_id;")
            )
            await db.execute(
                text(
                    "ALTER TABLE user_profiles DROP COLUMN IF EXISTS phone_identity_id;"
                )
            )
            await db.commit()
            logger.info(
                "✅ Rollback completed successfully: 038_add_phone_identity_id_to_user_profiles"
            )
        except Exception as e:
            await db.rollback()
            logger.error(
                "❌ Rollback failed: 038_add_phone_identity_id_to_user_profiles",
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
