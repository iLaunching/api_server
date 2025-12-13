#!/usr/bin/env python3
"""
Run the feedback_indicator_bk migration
Adds feedback_indicator_bk column to theme_configs table
"""
import asyncio
import asyncpg

DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def run_migration():
    print("🔄 Connecting to database...")
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("📝 Running migration: add_feedback_indicator_bk...")
        
        # Read the migration file
        with open('/workspaces/Ilaunching-SERVERS/api-server/migrations/add_feedback_indicator_bk.sql', 'r') as f:
            migration_sql = f.read()
        
        # Execute the migration
        await conn.execute(migration_sql)
        
        print("✅ Migration completed successfully!")
        
        # Verify the changes
        print("\n🔍 Verifying changes...")
        rows = await conn.fetch("""
            SELECT 
                ov.value_name,
                ov.display_name,
                tc.feedback_indicator_bk
            FROM theme_configs tc
            JOIN option_values ov ON tc.option_value_id = ov.id
            JOIN option_sets os ON ov.option_set_id = os.id
            WHERE os.name = 'appearance'
            ORDER BY ov.sort_order;
        """)
        
        print("\n📊 Current feedback_indicator_bk values:")
        for row in rows:
            print(f"  {row['display_name']:15} ({row['value_name']:8}): {row['feedback_indicator_bk']}")
        
    except Exception as e:
        print(f"❌ Error running migration: {e}")
        raise
    finally:
        await conn.close()
        print("\n✅ Database connection closed")

if __name__ == "__main__":
    asyncio.run(run_migration())
