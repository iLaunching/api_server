"""
Run Migration 017: Add DNA to Contexts
"""

import asyncio
import asyncpg
import os
from dotenv import load_dotenv

load_dotenv()

async def run_migration():
    """Execute the migration to add DNA relationships to contexts"""
    
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
        with open('migrations/017_add_dna_to_contexts.sql', 'r') as f:
            migration_sql = f.read()
        
        print("📄 Executing migration 017...")
        
        # Execute migration
        await conn.execute(migration_sql)
        
        print("✅ Migration 017 completed successfully!")
        print("   - Added global_user_dna_id column to tbl_contexts")
        print("   - Added local_matrix_dna_id column to tbl_contexts")
        print("   - Created foreign key relationships to tbl_dna_profiles")
        print("   - Added indexes for fast DNA lookups")
        print("")
        print("   📖 DNA Architecture:")
        print("      • global_user_dna_id = 'Soul' (constant across account)")
        print("      • local_matrix_dna_id = 'Role' (specific to this matrix)")
        
        # Close connection
        await conn.close()
        return True
        
    except Exception as e:
        print(f"❌ Migration failed: {str(e)}")
        return False

if __name__ == "__main__":
    success = asyncio.run(run_migration())
    exit(0 if success else 1)
