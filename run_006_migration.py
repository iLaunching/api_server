"""
Run Migration 006: Rename metadata to node_metadata
Fixes SQLAlchemy reserved name conflict
"""

import asyncio
import asyncpg
import os
from dotenv import load_dotenv

load_dotenv()

async def run_migration():
    """Execute the migration to rename metadata column"""
    
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
        with open('migrations/006_rename_metadata_column.sql', 'r') as f:
            migration_sql = f.read()
        
        print("📄 Executing migration 006...")
        
        # Execute migration
        await conn.execute(migration_sql)
        
        print("✅ Migration 006 completed successfully!")
        print("   - Renamed 'metadata' to 'node_metadata' in tbl_canvas_nodes")
        
        # Close connection
        await conn.close()
        return True
        
    except Exception as e:
        print(f"❌ Migration failed: {str(e)}")
        return False

if __name__ == "__main__":
    success = asyncio.run(run_migration())
    exit(0 if success else 1)
