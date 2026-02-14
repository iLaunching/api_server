"""
Migration Runner: 019_add_color_columns_to_protocols.sql
Purpose: Apply the color columns migration to the database
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
        migration_file = "migrations/019_add_color_columns_to_protocols.sql"
        
        with open(migration_file, 'r') as f:
            sql = f.read()
            
        print("🔄 Executing migration...")
        await conn.execute(sql)
        
        print("✅ Migration 019 applied successfully!")
        
        # Verify columns were added
        result = await conn.fetch("""
            SELECT column_name 
            FROM information_schema.columns 
            WHERE table_name = 'tbl_matrix_protocols' 
            AND column_name IN ('background_color', 'border_color')
        """)
        
        columns = [row['column_name'] for row in result]
        if 'background_color' in columns and 'border_color' in columns:
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
