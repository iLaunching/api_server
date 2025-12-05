"""
Database Migration Script - Create user_navigation table

Run this script to create the user_navigation table in your Railway PostgreSQL database.

Usage:
    python run_migration.py
"""

import os
import asyncio
import asyncpg
from pathlib import Path

async def run_migration():
    """Run the user_navigation schema migration"""
    
    # Get database URL from environment
    database_url = os.getenv("DATABASE_URL")
    
    if not database_url:
        print("❌ Error: DATABASE_URL environment variable is not set")
        print("\nTo get your DATABASE_URL:")
        print("1. Go to Railway Dashboard → api-server service")
        print("2. Click on PostgreSQL database")
        print("3. Go to Variables tab")
        print("4. Copy the DATABASE_URL value")
        print("5. Run: export DATABASE_URL='your-database-url-here'")
        print("\nThen run this script again: python run_migration.py")
        return False
    
    # Read the schema file
    schema_file = Path(__file__).parent / "database" / "user_navigation_schema.sql"
    
    if not schema_file.exists():
        print(f"❌ Error: Schema file not found at {schema_file}")
        return False
    
    with open(schema_file, 'r') as f:
        schema_sql = f.read()
    
    print("========================================")
    print("User Navigation Table Migration")
    print("========================================")
    print()
    print(f"📊 Database: {database_url.split('@')[0]}@***")
    print()
    print("Running migration...")
    print()
    
    try:
        # Connect to database
        conn = await asyncpg.connect(database_url)
        
        try:
            # Execute the schema
            await conn.execute(schema_sql)
            
            print("✅ Migration completed successfully!")
            print()
            print("Verifying table exists...")
            
            # Verify table was created
            result = await conn.fetch("""
                SELECT column_name, data_type 
                FROM information_schema.columns 
                WHERE table_name = 'user_navigation'
                ORDER BY ordinal_position
            """)
            
            if result:
                print("\n✅ user_navigation table structure:")
                print("-" * 50)
                for row in result:
                    print(f"  {row['column_name']:<30} {row['data_type']}")
                print("-" * 50)
                print()
                print("✅ Table is ready!")
                return True
            else:
                print("⚠️  Warning: Table might not have been created")
                return False
                
        finally:
            await conn.close()
            
    except Exception as e:
        print(f"❌ Migration failed: {e}")
        print()
        print("Possible issues:")
        print("- Database connection failed")
        print("- Invalid DATABASE_URL")
        print("- Missing dependencies (smart_hubs or users tables)")
        return False

if __name__ == "__main__":
    success = asyncio.run(run_migration())
    exit(0 if success else 1)
