"""
Migration: Add subscription_tier to smart_hubs table
This changes the business model from per-user to per-hub pricing
"""
import asyncio
import asyncpg

DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def migrate():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🔄 Starting migration: Add subscription_tier to smart_hubs...")
        
        # 1. Add subscription_tier column to smart_hubs table
        print("📝 Adding subscription_tier column to smart_hubs...")
        await conn.execute("""
            ALTER TABLE smart_hubs 
            ADD COLUMN IF NOT EXISTS subscription_tier VARCHAR(50) DEFAULT 'Validate Journey'
        """)
        print("✅ Column added successfully")
        
        # 2. Set default value for existing hubs
        print("📝 Setting default tier for existing smart hubs...")
        result = await conn.execute("""
            UPDATE smart_hubs 
            SET subscription_tier = 'Validate Journey' 
            WHERE subscription_tier IS NULL
        """)
        print(f"✅ Updated existing smart hubs: {result}")
        
        # 3. Verify the migration
        print("🔍 Verifying migration...")
        count = await conn.fetchval("""
            SELECT COUNT(*) FROM smart_hubs 
            WHERE subscription_tier IS NOT NULL
        """)
        print(f"✅ Total smart hubs with subscription_tier: {count}")
        
        # 4. Show sample data
        sample = await conn.fetch("""
            SELECT id, name, subscription_tier 
            FROM smart_hubs 
            LIMIT 5
        """)
        print("\n📊 Sample smart hubs:")
        for hub in sample:
            print(f"  - {hub['name']}: {hub['subscription_tier']}")
        
        print("\n✅ Migration completed successfully!")
        print("📌 Note: subscription_tier column removed from users table in models (no DB change needed as column will be deprecated)")
        
    except Exception as e:
        print(f"❌ Migration failed: {e}")
        raise
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(migrate())
