"""
Migration Runner: 020_add_display_columns_to_protocols.sql
Purpose: Apply the display columns migration to the database
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
        migration_file = "migrations/020_add_display_columns_to_protocols.sql"
        
        with open(migration_file, 'r') as f:
            sql = f.read()
            
        print("🔄 Executing migration...")
        await conn.execute(sql)
        
        print("✅ Migration 020 applied successfully!")
        
        # Verify columns were added
        result = await conn.fetch("""
            SELECT column_name 
            FROM information_schema.columns 
            WHERE table_name = 'tbl_matrix_protocols' 
            AND column_name IN ('display_name', 'display_description')
        """)
        
        columns = [row['column_name'] for row in result]
        if 'display_name' in columns and 'display_description' in columns:
            print(f"✅ Verified columns exist: {columns}")
        else:
            print(f"⚠️ Warning: verification returned {columns}")
            
    except Exception as e:
        print(f"\n❌ Migration failed: {e}")
        raise
    finally:
        await conn.close()
        print("🔌 Database connection closed")

if __name__ == "__main__":
    asyncio.run(migrate())
