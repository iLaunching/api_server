#!/usr/bin/env python3
"""
Migration script to rename theme_configs.metadata to theme_configs.theme_metadata
This fixes the SQLAlchemy conflict with reserved 'metadata' attribute.
"""

import os
import asyncio
import asyncpg


async def migrate():
    """Rename metadata column to theme_metadata"""
    database_url = os.getenv("DATABASE_URL")
    
    if not database_url:
        print("❌ ERROR: DATABASE_URL environment variable not set")
        return
    
    print(f"🔗 Connecting to database...")
    conn = await asyncpg.connect(database_url)
    
    try:
        # Check if the metadata column exists
        check_query = """
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'theme_configs' 
        AND column_name IN ('metadata', 'theme_metadata');
        """
        columns = await conn.fetch(check_query)
        column_names = [row['column_name'] for row in columns]
        
        print(f"📋 Current columns: {column_names}")
        
        if 'metadata' in column_names and 'theme_metadata' not in column_names:
            print("🔄 Renaming metadata to theme_metadata...")
            await conn.execute("""
                ALTER TABLE theme_configs 
                RENAME COLUMN metadata TO theme_metadata;
            """)
            print("✅ Column renamed successfully!")
        elif 'theme_metadata' in column_names and 'metadata' not in column_names:
            print("✅ Column already renamed - no action needed")
        elif 'metadata' in column_names and 'theme_metadata' in column_names:
            print("⚠️  Both columns exist - this is unexpected. Manual intervention needed.")
        else:
            print("⚠️  Neither column found - table might not exist yet")
        
        # Verify the change
        verify_query = """
        SELECT column_name, data_type 
        FROM information_schema.columns 
        WHERE table_name = 'theme_configs' 
        AND column_name = 'theme_metadata';
        """
        result = await conn.fetch(verify_query)
        if result:
            print(f"✅ Verified: theme_metadata column exists with type {result[0]['data_type']}")
        
    except Exception as e:
        print(f"❌ Migration failed: {e}")
        raise
    finally:
        await conn.close()
        print("🔌 Database connection closed")


if __name__ == "__main__":
    asyncio.run(migrate())
