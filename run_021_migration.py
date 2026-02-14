"""
Migration Runner: 021_update_protocol_display_text.sql
Purpose: Apply the updated display text migration to the database
"""

import asyncio
import asyncpg
import os

# Use the provided database URL
DATABASE_URL = "postgres://postgres:5B46Gg4BGCC5fcA2geGaddd6Bf42CaDC@turntable.proxy.rlwy.net:23759/railway"

async def migrate():
    print(f"🔄 Connecting to database...")
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🔄 Reading migration file...")
        migration_file = "migrations/021_update_protocol_display_text.sql"
        
        with open(migration_file, 'r') as f:
            sql = f.read()
            
        print("🔄 Executing migration...")
        await conn.execute(sql)
        
        print("✅ Migration 021 applied successfully!")
        
        # Verify updates
        result = await conn.fetch("""
            SELECT protocol_key, display_name, display_description 
            FROM tbl_matrix_protocols
            ORDER BY protocol_key
        """)
        
        for row in result:
            print(f"📌 {row['protocol_key']}: {row['display_name']}")
            
    except Exception as e:
        print(f"\n❌ Migration failed: {e}")
        raise
    finally:
        await conn.close()
        print("🔌 Database connection closed")

if __name__ == "__main__":
    asyncio.run(migrate())
