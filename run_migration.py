"""
Run migration SQL file directly on the database
"""
import asyncio
import asyncpg
import sys

DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def run_migration():
    # Get migration file from command line argument
    if len(sys.argv) < 2:
        print("Usage: python run_migration.py <migration_file.sql>")
        print("Example: python run_migration.py migrations/001_create_manifest.sql")
        sys.exit(1)
    
    migration_file = sys.argv[1]
    
    # Read the migration SQL file
    with open(migration_file, 'r') as f:
        migration_sql = f.read()
    
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print(f"🚀 Running migration: {migration_file}")
        print("-" * 60)
        
        # Execute the migration SQL
        await conn.execute(migration_sql)
        
        print("\n✅ Migration completed successfully!")
        print("📊 Verifying table creation...")
        
    except Exception as e:
        print(f"\n❌ Migration failed: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(run_migration())
