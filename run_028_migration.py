
import asyncio
import os
import asyncpg
from urllib.parse import urlparse

# Database configuration
DATABASE_URL = "postgres://postgres:5B46Gg4BGCC5fcA2geGaddd6Bf42CaDC@turntable.proxy.rlwy.net:23759/railway"

async def run_migration():
    print(f"Connecting to database...")
    try:
        # Parse URL to get connection params
        result = urlparse(DATABASE_URL)
        username = result.username
        password = result.password
        database = result.path[1:]
        hostname = result.hostname
        port = result.port
        
        # Connect to database
        conn = await asyncpg.connect(
            user=username,
            password=password,
            database=database,
            host=hostname,
            port=port
        )
        print("Connected successfully.")
        
        # Read migration file
        migration_file = "api-server/migrations/028_create_audit_logs.sql"
        print(f"Reading migration file: {migration_file}")
        
        with open(migration_file, 'r') as f:
            sql = f.read()
            
        # Execute migration
        print("Executing migration SQL...")
        await conn.execute(sql)
        print("Migration completed successfully.")
        
        await conn.close()
        
    except Exception as e:
        print(f"An error occurred: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    asyncio.run(run_migration())
