"""
Run Migration 013: Create Node Definitions Table
"""

import asyncio
import asyncpg
import os
from dotenv import load_dotenv

load_dotenv()

async def run_migration():
    """Execute the migration to create node definitions table"""
    
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
        with open('migrations/013_create_node_definitions.sql', 'r') as f:
            migration_sql = f.read()
        
        print("📄 Executing migration 013...")
        
        # Execute migration
        await conn.execute(migration_sql)
        
        print("✅ Migration 013 completed successfully!")
        print("   - Created tbl_node_definitions table")
        print("   - Added indexes for category and active status")
        print("   - Seeded 12 node definitions:")
        print("     • 4 GENESIS nodes (Web Scraper, Email Actuator, Data Validator, API Connector)")
        print("     • 4 CAMPAIGN nodes (Lead Scorer, Content Generator, Engagement Tracker, A/B Test Manager)")
        print("     • 4 VALIDATION nodes (Quality Checker, Performance Analyzer, Compliance Validator, ROI Calculator)")
        
        # Verify the data
        count = await conn.fetchval("SELECT COUNT(*) FROM tbl_node_definitions WHERE is_active = TRUE")
        print(f"   - Total active definitions: {count}")
        
        # Close connection
        await conn.close()
        return True
        
    except Exception as e:
        print(f"❌ Migration failed: {str(e)}")
        return False

if __name__ == "__main__":
    success = asyncio.run(run_migration())
    exit(0 if success else 1)
