"""
Backfill script to create UserNavigation records for existing user_profiles
Run this after deploying the new code to create navigation records for existing users
"""

import asyncio
import sys
import os
from pathlib import Path

# Add parent directory to path for imports
sys.path.insert(0, str(Path(__file__).parent))

from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy import text
import uuid


async def backfill_user_navigation():
    """Create UserNavigation records for existing user_profiles that don't have one"""
    
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
    
    print("🚀 Starting UserNavigation backfill...")
    
    async with engine.begin() as conn:
        try:
            # Find user_profiles without user_navigation_id
            result = await conn.execute(text("""
                SELECT id FROM user_profiles 
                WHERE user_navigation_id IS NULL
            """))
            profiles = result.fetchall()
            
            print(f"Found {len(profiles)} user_profiles without navigation")
            
            if len(profiles) == 0:
                print("✅ No profiles need backfilling")
                await engine.dispose()
                return
            
            created_count = 0
            for profile in profiles:
                profile_id = profile[0]
                
                # Create UserNavigation record
                nav_id = uuid.uuid4()
                await conn.execute(text("""
                    INSERT INTO user_navigation (id, user_profile_id, current_smart_hub_id, created_at, updated_at)
                    VALUES (:id, :profile_id, NULL, NOW(), NOW())
                """), {"id": nav_id, "profile_id": profile_id})
                
                # Update user_profile with navigation_id
                await conn.execute(text("""
                    UPDATE user_profiles 
                    SET user_navigation_id = :nav_id 
                    WHERE id = :profile_id
                """), {"nav_id": nav_id, "profile_id": profile_id})
                
                created_count += 1
                print(f"  ✅ Created navigation for profile {profile_id}")
            
            print(f"\n🎉 Successfully created {created_count} UserNavigation records!")
            
        except Exception as e:
            print(f"❌ Error during backfill: {e}")
            raise
    
    await engine.dispose()
    print("\n✨ Backfill complete!")


if __name__ == "__main__":
    asyncio.run(backfill_user_navigation())
