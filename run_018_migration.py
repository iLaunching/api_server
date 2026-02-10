"""
Run Migration 018: Add DNA to User Profiles
"""

import asyncio
import asyncpg
import os
from dotenv import load_dotenv

load_dotenv()

async def run_migration():
    """Execute the migration to add global DNA to user profiles"""
    
    # Get database URL from environment
    database_url = os.getenv('DATABASE_URL')
    
    if not database_url:
        print("❌ DATABASE_URL not found in environment variables")
        return False
    
    try:
        # Connect to database
        conn = await asyncpg.connect(database_url)
        print("✅ Connected to database")
        
        # Read migration file
        with open('migrations/018_add_dna_to_user_profiles.sql', 'r') as f:
            migration_sql = f.read()
        
        print("📄 Executing migration 018...")
        
        # Execute migration
        await conn.execute(migration_sql)
        
        print("✅ Migration 018 completed successfully!")
        print("   - Added global_user_dna_id column to user_profiles")
        print("   - Created foreign key relationship to tbl_dna_profiles")
        print("   - Added index for fast DNA lookups")
        print("")
        print("   📖 The 'Soul' DNA:")
        print("      • Global across entire user account")
        print("      • Constant personality and preferences")
        print("      • Shared by all matrices and contexts")
        
        # Close connection
        await conn.close()
        return True
        
    except Exception as e:
        print(f"❌ Migration failed: {str(e)}")
        return False

if __name__ == "__main__":
    success = asyncio.run(run_migration())
    exit(0 if success else 1)
