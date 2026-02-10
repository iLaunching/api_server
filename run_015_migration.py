"""
Run Migration 015: Add Protocol to Contexts
"""

import asyncio
import asyncpg
import os
from dotenv import load_dotenv

load_dotenv()

async def run_migration():
    """Execute the migration to add protocol relationship to contexts"""
    
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
        with open('migrations/015_add_protocol_to_contexts.sql', 'r') as f:
            migration_sql = f.read()
        
        print("📄 Executing migration 015...")
        
        # Execute migration
        await conn.execute(migration_sql)
        
        print("✅ Migration 015 completed successfully!")
        print("   - Added current_protocol_id column to tbl_contexts")
        print("   - Created foreign key relationship to tbl_matrix_protocols")
        print("   - Added index for fast protocol lookups")
        print("   - Set existing master contexts to GENESIS protocol")
        
        # Verify the changes
        count = await conn.fetchval("""
            SELECT COUNT(*) 
            FROM tbl_contexts 
            WHERE current_protocol_id IS NOT NULL
        """)
        print(f"   - Contexts with protocol assigned: {count}")
        
        # Close connection
        await conn.close()
        return True
        
    except Exception as e:
        print(f"❌ Migration failed: {str(e)}")
        return False

if __name__ == "__main__":
    success = asyncio.run(run_migration())
    exit(0 if success else 1)
