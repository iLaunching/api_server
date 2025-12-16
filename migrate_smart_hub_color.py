"""
Migration: Convert SmartHub.hub_color from String to FK relationship
Changes hub_color column from String(50) to hub_color_id Integer FK to option_values
"""

import asyncio
import sys
import os

# Add parent directory to path to import config
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from sqlalchemy import text
from config.database import get_db, engine

async def migrate_smart_hub_color():
    """
    Step 1: Add new hub_color_id column as FK to option_values
    Step 2: Migrate existing hub_color string values to hub_color_id (if any data exists)
    Step 3: Drop old hub_color column
    """
    
    if not engine:
        print("❌ Database engine not configured")
        return
    
    async with engine.begin() as conn:
        try:
            print("🔄 Starting smart_hubs.hub_color migration...")
            
            # Step 1: Add new hub_color_id column
            print("\n📝 Step 1: Adding hub_color_id column...")
            await conn.execute(text("""
                ALTER TABLE smart_hubs 
                ADD COLUMN IF NOT EXISTS hub_color_id INTEGER REFERENCES option_values(id) ON DELETE SET NULL
            """))
            print("✅ Added hub_color_id column")
            
            # Step 2: Create index on hub_color_id
            print("\n📝 Step 2: Creating index on hub_color_id...")
            await conn.execute(text("""
                CREATE INDEX IF NOT EXISTS ix_smart_hubs_hub_color_id ON smart_hubs(hub_color_id)
            """))
            print("✅ Created index")
            
            # Step 3: Check if there are any existing smart_hubs with hub_color data
            print("\n📝 Step 3: Checking for existing data...")
            result = await conn.execute(text("""
                SELECT id, hub_color FROM smart_hubs WHERE hub_color IS NOT NULL
            """))
            existing_hubs = result.fetchall()
            
            if existing_hubs:
                print(f"⚠️  Found {len(existing_hubs)} smart hubs with hub_color values")
                print("   Manual migration may be needed to map these to option_values")
                for hub in existing_hubs:
                    print(f"   - Hub ID: {hub[0]}, hub_color: {hub[1]}")
            else:
                print("✅ No existing hub_color data to migrate")
            
            # Step 4: Drop old hub_color column (only if no data or after manual migration)
            if not existing_hubs:
                print("\n📝 Step 4: Dropping old hub_color column...")
                await conn.execute(text("""
                    ALTER TABLE smart_hubs DROP COLUMN IF EXISTS hub_color
                """))
                print("✅ Dropped old hub_color column")
            else:
                print("\n⚠️  Step 4: Skipping drop of hub_color column (contains data)")
                print("   After manually migrating the data to hub_color_id, run:")
                print("   ALTER TABLE smart_hubs DROP COLUMN hub_color;")
            
            print("\n✅ Migration completed successfully!")
            
        except Exception as e:
            print(f"❌ Migration failed: {e}")
            raise

if __name__ == "__main__":
    asyncio.run(migrate_smart_hub_color())
