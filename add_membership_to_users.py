"""
Migration: Add membership column to users table
Options: Individual (default), Enterprise
"""
import asyncio
import asyncpg

DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def migrate():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🔄 Starting migration: Add membership to users...")
        
        # Add membership column to users table
        print("📝 Adding membership column to users...")
        await conn.execute("""
            ALTER TABLE users 
            ADD COLUMN IF NOT EXISTS membership VARCHAR(50) DEFAULT 'Individual'
        """)
        print("✅ Column added successfully")
        
        # Set default value for existing users
        print("📝 Setting default membership for existing users...")
        result = await conn.execute("""
            UPDATE users 
            SET membership = 'Individual' 
            WHERE membership IS NULL
        """)
        print(f"✅ Updated existing users: {result}")
        
        # Verify the migration
        print("🔍 Verifying migration...")
        count = await conn.fetchval("""
            SELECT COUNT(*) FROM users 
            WHERE membership IS NOT NULL
        """)
        print(f"✅ Total users with membership: {count}")
        
        # Show sample data
        sample = await conn.fetch("""
            SELECT id, email, membership 
            FROM users 
            LIMIT 5
        """)
        print("\n📊 Sample users:")
        for user in sample:
            print(f"  - {user['email']}: {user['membership']}")
        
        print("\n✅ Migration completed successfully!")
        print("📌 Membership options: Individual (default), Enterprise")
        
    except Exception as e:
        print(f"❌ Migration failed: {e}")
        raise
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(migrate())
