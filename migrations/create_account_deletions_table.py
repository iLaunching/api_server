"""
Migration: Create account_deletions table
Adds table to track account deletion requests with 30-day grace period
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
        print("🔄 Creating account_deletions table...")
        
        # Create the account_deletions table
        await conn.execute("""
            CREATE TABLE IF NOT EXISTS account_deletions (
                id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                request_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
                execution_date TIMESTAMPTZ NOT NULL,
                status VARCHAR(50) NOT NULL DEFAULT 'pending',
                CONSTRAINT account_deletions_status_check CHECK (status IN ('pending', 'completed', 'cancelled'))
            );
        """)
        print("✅ Table account_deletions created")
        
        # Create index on user_id for faster lookups
        await conn.execute("""
            CREATE INDEX IF NOT EXISTS idx_account_deletions_user_id 
            ON account_deletions(user_id);
        """)
        print("✅ Index on user_id created")
        
        # Create index on status for filtering pending deletions
        await conn.execute("""
            CREATE INDEX IF NOT EXISTS idx_account_deletions_status 
            ON account_deletions(status);
        """)
        print("✅ Index on status created")
        
        # Create index on execution_date for scheduled processing
        await conn.execute("""
            CREATE INDEX IF NOT EXISTS idx_account_deletions_execution_date 
            ON account_deletions(execution_date);
        """)
        print("✅ Index on execution_date created")
        
        print("✅ Migration completed successfully!")
        
    except Exception as e:
        print(f"❌ Migration failed: {str(e)}")
        raise
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(migrate())
