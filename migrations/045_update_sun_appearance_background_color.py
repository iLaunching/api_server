"""
Migration 045: Sun appearance theme background_color → #F8F9FA.
"""

import asyncio
from pathlib import Path

import structlog
from sqlalchemy import text

from config.database import get_db

logger = structlog.get_logger()

_MIGRATION_SQL = (Path(__file__).parent / "045_update_sun_appearance_background_color.sql").read_text()


async def upgrade():
    async for db in get_db():
        try:
            logger.info("Starting migration: 045_update_sun_appearance_background_color")
            await db.execute(text(_MIGRATION_SQL))
            await db.commit()
            logger.info("✅ Migration completed: 045_update_sun_appearance_background_color")
        except Exception as e:
            await db.rollback()
            logger.error(
                "❌ Migration failed: 045_update_sun_appearance_background_color",
                error=str(e),
            )
            raise
        finally:
            break


async def downgrade():
    async for db in get_db():
        try:
            logger.info("Rolling back: 045_update_sun_appearance_background_color")
            await db.execute(
                text(
                    """
                    UPDATE theme_configs tc
                    SET background_color = '#FFFFFF'
                    FROM option_values ov
                    JOIN option_sets os ON os.id = ov.option_set_id
                    WHERE tc.option_value_id = ov.id
                      AND os.name = 'appearance'
                      AND ov.value_name = 'sun'
                    """
                )
            )
            await db.commit()
            logger.info("✅ Rollback completed: 045_update_sun_appearance_background_color")
        except Exception as e:
            await db.rollback()
            logger.error(
                "❌ Rollback failed: 045_update_sun_appearance_background_color",
                error=str(e),
            )
            raise
        finally:
            break


if __name__ == "__main__":
    asyncio.run(upgrade())
