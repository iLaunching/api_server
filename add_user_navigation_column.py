"""
Migration script to add user_navigation_id column to user_profiles table in API-SERVER
NOTE: This should be run from api-server directory, not auth-api
Run this to add the one-to-one relationship with user_navigation table
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
    """Add user_navigation_id column to user_profiles table"""
    
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
    
    print("🚀 Starting user_profiles migration...")
    
    async with engine.begin() as conn:
        try:
            # Add user_navigation_id column
            await conn.execute(text("""
                ALTER TABLE user_profiles 
                ADD COLUMN IF NOT EXISTS user_navigation_id UUID UNIQUE
            """))
            print("✅ Column added: user_navigation_id")
            
            # Create index
            await conn.execute(text("""
                CREATE INDEX IF NOT EXISTS idx_user_profiles_user_navigation_id 
                ON user_profiles(user_navigation_id)
            """))
            print("✅ Index created on user_navigation_id")
            
            print("\n🎉 Migration completed successfully!")
            print("   - One-to-one relationship with user_navigation table established")
            
        except Exception as e:
            print(f"❌ Error adding column: {e}")
            raise
    
    await engine.dispose()
    print("\n✨ Done!")


if __name__ == "__main__":
    asyncio.run(run_migration())
