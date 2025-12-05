"""
Migration script to create user_navigation table
Run this to add the user_navigation table to the database
"""

import asyncio
import sys
import os
from pathlib import Path

# Add parent directory to path for imports
sys.path.insert(0, str(Path(__file__).parent))

from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy import text


async def run_migration():
    """Run the user_navigation table migration"""
    
    # Get database URL from environment
    DATABASE_URL = os.getenv("DATABASE_URL")
    if not DATABASE_URL:
        print("❌ DATABASE_URL environment variable not set")
        return
    
    # Convert postgres:// to postgresql+asyncpg://
    if DATABASE_URL.startswith("postgres://"):
        DATABASE_URL = DATABASE_URL.replace("postgres://", "postgresql+asyncpg://", 1)
    elif DATABASE_URL.startswith("postgresql://") and "+asyncpg" not in DATABASE_URL:
        DATABASE_URL = DATABASE_URL.replace("postgresql://", "postgresql+asyncpg://", 1)
    
    # Create engine
    engine = create_async_engine(DATABASE_URL, echo=False)
    
    print("🚀 Starting user_navigation table migration...")
    
    async with engine.begin() as conn:
        try:
            # Create table
            await conn.execute(text("""
                CREATE TABLE IF NOT EXISTS user_navigation (
                    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                    user_profile_id UUID NOT NULL UNIQUE,
                    current_smart_hub_id UUID UNIQUE REFERENCES smart_hubs(id) ON DELETE SET NULL,
                    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
                    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
                )
            """))
            print("✅ Table created")
            
            # Create indexes
            await conn.execute(text("""
                CREATE INDEX IF NOT EXISTS idx_user_navigation_user_profile_id 
                ON user_navigation(user_profile_id)
            """))
            
            await conn.execute(text("""
                CREATE INDEX IF NOT EXISTS idx_user_navigation_current_smart_hub_id 
                ON user_navigation(current_smart_hub_id)
            """))
            print("✅ Indexes created")
            
            # Create trigger function
            await conn.execute(text("""
                CREATE OR REPLACE FUNCTION update_user_navigation_updated_at()
                RETURNS TRIGGER AS $$
                BEGIN
                    NEW.updated_at = NOW();
                    RETURN NEW;
                END;
                $$ LANGUAGE plpgsql
            """))
            print("✅ Trigger function created")
            
            # Drop trigger if exists
            await conn.execute(text("""
                DROP TRIGGER IF EXISTS user_navigation_updated_at ON user_navigation
            """))
            
            # Create trigger
            await conn.execute(text("""
                CREATE TRIGGER user_navigation_updated_at
                    BEFORE UPDATE ON user_navigation
                    FOR EACH ROW
                    EXECUTE FUNCTION update_user_navigation_updated_at()
            """))
            print("✅ Trigger created")
            
            print("\n🎉 user_navigation table created successfully!")
            print("   - One-to-one relationship with user_profile")
            print("   - One-to-one relationship with current_smart_hub")
            
        except Exception as e:
            print(f"❌ Error creating user_navigation table: {e}")
            raise
    
    await engine.dispose()
    print("\n✨ Migration completed!")


if __name__ == "__main__":
    asyncio.run(run_migration())
