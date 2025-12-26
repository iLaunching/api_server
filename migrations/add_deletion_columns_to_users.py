"""
Migration: Add deletion tracking columns to users table
Adds is_deleted and deletion_scheduled_date for immediate access control
"""
import asyncio
import asyncpg
import os

DATABASE_URL = os.getenv("DATABASE_URL")

async def migrate():
    if not DATABASE_URL:
        print("❌ DATABASE_URL environment variable not set")
        return
    
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🔄 Adding deletion tracking columns to users table...")
        
        # Add is_deleted column
        await conn.execute("""
            ALTER TABLE users 
            ADD COLUMN IF NOT EXISTS is_deleted BOOLEAN NOT NULL DEFAULT false;
        """)
        print("✅ Column is_deleted added")
        
        # Add deletion_scheduled_date column
        await conn.execute("""
            ALTER TABLE users 
            ADD COLUMN IF NOT EXISTS deletion_scheduled_date TIMESTAMPTZ;
        """)
        print("✅ Column deletion_scheduled_date added")
        
        # Create index on is_deleted for access control checks
        await conn.execute("""
            CREATE INDEX IF NOT EXISTS idx_users_is_deleted 
            ON users(is_deleted);
        """)
        print("✅ Index on is_deleted created")
        
        print("✅ Migration completed successfully!")
        
    except Exception as e:
        print(f"❌ Migration failed: {str(e)}")
        raise
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(migrate())
