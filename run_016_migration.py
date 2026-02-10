"""
Run Migration 016: Create DNA Profiles Table
"""

import asyncio
import asyncpg
import os
from dotenv import load_dotenv

load_dotenv()

async def run_migration():
    """Execute the migration to create DNA profiles table"""
    
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
        with open('migrations/016_create_dna_profiles.sql', 'r') as f:
            migration_sql = f.read()
        
        print("📄 Executing migration 016...")
        
        # Execute migration
        await conn.execute(migration_sql)
        
        print("✅ Migration 016 completed successfully!")
        print("   - Created tbl_dna_profiles table")
        print("   - Added JSONB dna_payload column for dynamic AI programming")
        print("   - Created indexes:")
        print("     • GIN index on dna_payload for efficient JSONB queries")
        print("     • Index on is_global_user_dna for global DNA lookups")
        print("     • Index on last_synthesis for temporal queries")
        
        # Verify the table
        exists = await conn.fetchval("""
            SELECT EXISTS (
                SELECT FROM information_schema.tables 
                WHERE table_name = 'tbl_dna_profiles'
            )
        """)
        print(f"   - Table exists: {exists}")
        
        # Close connection
        await conn.close()
        return True
        
    except Exception as e:
        print(f"❌ Migration failed: {str(e)}")
        return False

if __name__ == "__main__":
    success = asyncio.run(run_migration())
    exit(0 if success else 1)
