"""
Migration: Rename subscription_tier to journey in smart_hubs table
"""
import asyncio
import asyncpg

DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def migrate():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🔄 Starting migration: Rename subscription_tier to journey...")
        
        # Rename the column
        print("📝 Renaming column subscription_tier to journey...")
        await conn.execute("""
            ALTER TABLE smart_hubs 
            RENAME COLUMN subscription_tier TO journey
        """)
        print("✅ Column renamed successfully")
        
        # Verify the migration
        print("🔍 Verifying migration...")
        count = await conn.fetchval("""
            SELECT COUNT(*) FROM smart_hubs 
            WHERE journey IS NOT NULL
        """)
        print(f"✅ Total smart hubs with journey: {count}")
        
        # Show sample data
        sample = await conn.fetch("""
            SELECT id, name, journey 
            FROM smart_hubs 
            LIMIT 5
        """)
        print("\n📊 Sample smart hubs:")
        for hub in sample:
            print(f"  - {hub['name']}: {hub['journey']}")
        
        print("\n✅ Migration completed successfully!")
        
    except Exception as e:
        print(f"❌ Migration failed: {e}")
        raise
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(migrate())
