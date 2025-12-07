"""
Run migration SQL file directly on the database
"""
import asyncio
import asyncpg
import sys

DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def run_migration():
    # Read the migration SQL file
    with open('migrations/add_header_overlay_color.sql', 'r') as f:
        migration_sql = f.read()
    
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🚀 Running migration: add_header_overlay_color.sql")
        print("-" * 60)
        
        # Execute the migration SQL
        await conn.execute(migration_sql)
        
        print("\n✅ Migration completed successfully!")
        print("🔄 Reload cache via API: POST /api/v1/themes/reload")
        
    except Exception as e:
        print(f"\n❌ Migration failed: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(run_migration())
