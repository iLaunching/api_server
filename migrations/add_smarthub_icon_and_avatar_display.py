"""
Add smart hub icon and avatar display columns
Adds smartHub_icon_id and avatar_display_option_value_id to smart_hubs table
"""

from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession
from config.database import get_db
import asyncio
import structlog

logger = structlog.get_logger()

async def upgrade():
    """Add smart hub icon and avatar display columns"""
    async for db in get_db():
        try:
            logger.info("Starting migration: add_smarthub_icon_and_avatar_display")
            
            # Add smartHub_icon_id column (FK to option_values for avatar_library)
            await db.execute(text("""
                ALTER TABLE smart_hubs 
                ADD COLUMN IF NOT EXISTS smartHub_icon_id INTEGER;
            """))
            
            # Add foreign key constraint for smartHub_icon_id
            await db.execute(text("""
                DO $$
                BEGIN
                    IF NOT EXISTS (
                        SELECT 1 FROM pg_constraint 
                        WHERE conname = 'fk_smart_hubs_smartHub_icon_id'
                    ) THEN
                        ALTER TABLE smart_hubs
                        ADD CONSTRAINT fk_smart_hubs_smartHub_icon_id
                        FOREIGN KEY (smartHub_icon_id) 
                        REFERENCES option_values(id) 
                        ON DELETE SET NULL;
                    END IF;
                END $$;
            """))
            
            # Add index for smartHub_icon_id
            await db.execute(text("""
                CREATE INDEX IF NOT EXISTS idx_smart_hubs_smartHub_icon_id 
                ON smart_hubs(smartHub_icon_id);
            """))
            
            # Add avatar_display_option_value_id column with default value 24
            await db.execute(text("""
                ALTER TABLE smart_hubs 
                ADD COLUMN IF NOT EXISTS avatar_display_option_value_id INTEGER DEFAULT 24;
            """))
            
            # Add index for avatar_display_option_value_id
            await db.execute(text("""
                CREATE INDEX IF NOT EXISTS idx_smart_hubs_avatar_display_option_value_id 
                ON smart_hubs(avatar_display_option_value_id);
            """))
            
            await db.commit()
            
            logger.info("✅ Migration completed successfully: add_smarthub_icon_and_avatar_display")
            logger.info("Added columns:")
            logger.info("  - smartHub_icon_id (FK to option_values for avatar_library)")
            logger.info("  - avatar_display_option_value_id (default 24 for initials)")
            
        except Exception as e:
            await db.rollback()
            logger.error("❌ Migration failed: add_smarthub_icon_and_avatar_display", error=str(e))
            raise
        finally:
            break

async def downgrade():
    """Remove smart hub icon and avatar display columns"""
    async for db in get_db():
        try:
            logger.info("Starting rollback: add_smarthub_icon_and_avatar_display")
            
            # Drop columns (CASCADE will drop constraints and indexes)
            await db.execute(text("""
                ALTER TABLE smart_hubs 
                DROP COLUMN IF EXISTS smartHub_icon_id CASCADE;
            """))
            
            await db.execute(text("""
                ALTER TABLE smart_hubs 
                DROP COLUMN IF EXISTS avatar_display_option_value_id CASCADE;
            """))
            
            await db.commit()
            
            logger.info("✅ Rollback completed successfully: add_smarthub_icon_and_avatar_display")
            
        except Exception as e:
            await db.rollback()
            logger.error("❌ Rollback failed: add_smarthub_icon_and_avatar_display", error=str(e))
            raise
        finally:
            break

if __name__ == "__main__":
    import sys
    
    if len(sys.argv) > 1 and sys.argv[1] == "downgrade":
        asyncio.run(downgrade())
    else:
        asyncio.run(upgrade())
