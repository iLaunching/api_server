"""
Migration Runner: 023_add_short_description_to_protocols.sql
Purpose: Apply short_description column and sample data
"""

import asyncio
import asyncpg
import os
from config.database import DATABASE_URL as ENV_DATABASE_URL

# Use env var or fallback to the one found in previous scripts
DATABASE_URL = ENV_DATABASE_URL or "postgres://postgres:5B46Gg4BGCC5fcA2geGaddd6Bf42CaDC@turntable.proxy.rlwy.net:23759/railway"

async def migrate():
    print(f"🔄 Connecting to database...")
    try:
        conn = await asyncpg.connect(DATABASE_URL)
    except Exception as e:
        print(f"❌ Connection failed: {e}")
        return
    
    try:
        print("🔄 Reading migration file...")
        migration_file = "migrations/023_add_short_description_to_protocols.sql"
        
        with open(migration_file, 'r') as f:
            sql = f.read()
            
        print("🔄 Executing migration...")
        await conn.execute(sql)
        
        print("✅ Migration 023 applied successfully!")
        
        # Verify updates
        print("\n🔍 Verifying updates:")
        result = await conn.fetch("""
            SELECT protocol_key, display_name, short_description 
            FROM tbl_matrix_protocols
            ORDER BY protocol_key
        """)
        
        for row in result:
            print(f"📌 {row['protocol_key']}: {row['display_name']}")
            print(f"   Short: {row['short_description']}")
            print(f"   -------------------")
            
    except Exception as e:
        print(f"\n❌ Migration failed: {e}")
        raise
    finally:
        await conn.close()
        print("🔌 Database connection closed")

if __name__ == "__main__":
    asyncio.run(migrate())
