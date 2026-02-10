"""
Run Migration 014: Create Matrix Protocols Table
"""

import asyncio
import asyncpg
import os
from dotenv import load_dotenv

load_dotenv()

async def run_migration():
    """Execute the migration to create matrix protocols table"""
    
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
        with open('migrations/014_create_matrix_protocols.sql', 'r') as f:
            migration_sql = f.read()
        
        print("📄 Executing migration 014...")
        
        # Execute migration
        await conn.execute(migration_sql)
        
        print("✅ Migration 014 completed successfully!")
        print("   - Created tbl_matrix_protocols table")
        print("   - Added indexes for protocol_key and active status")
        print("   - Seeded 3 matrix protocols:")
        print("     • GENESIS: Foundation building and data collection")
        print("     • CAMPAIGN: Execution and optimization")
        print("     • VALIDATION: Quality assurance and analytics")
        
        # Verify the data
        count = await conn.fetchval("SELECT COUNT(*) FROM tbl_matrix_protocols WHERE is_active = TRUE")
        print(f"   - Total active protocols: {count}")
        
        # Close connection
        await conn.close()
        return True
        
    except Exception as e:
        print(f"❌ Migration failed: {str(e)}")
        return False

if __name__ == "__main__":
    success = asyncio.run(run_migration())
    exit(0 if success else 1)
