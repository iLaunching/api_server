#!/usr/bin/env python3
"""
Migration: Add current_smart_matrix_id to user_navigation table
Similar relationship to smart_matrices as current_smart_hub_id has to smart_hubs
"""

import asyncio
import asyncpg
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Database configuration
DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def run_migration():
    """Add current_smart_matrix_id column to user_navigation table"""
    
    print("🔄 Connecting to database...")
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("\n📝 Starting migration: Add current_smart_matrix_id to user_navigation")
        
        # Add the current_smart_matrix_id column
        print("\n1️⃣ Adding current_smart_matrix_id column...")
        await conn.execute("""
            ALTER TABLE user_navigation 
            ADD COLUMN IF NOT EXISTS current_smart_matrix_id UUID UNIQUE 
            REFERENCES smart_matrices(id) ON DELETE SET NULL
        """)
        print("   ✅ Column added successfully")
        
        # Create index for performance
        print("\n2️⃣ Creating index for current_smart_matrix_id...")
        await conn.execute("""
            CREATE INDEX IF NOT EXISTS idx_user_navigation_current_smart_matrix_id 
            ON user_navigation(current_smart_matrix_id)
        """)
        print("   ✅ Index created successfully")
        
        # Verify the changes
        print("\n3️⃣ Verifying table structure...")
        columns = await conn.fetch("""
            SELECT column_name, data_type, is_nullable
            FROM information_schema.columns
            WHERE table_name = 'user_navigation'
            ORDER BY ordinal_position
        """)
        
        print("\n📋 Current user_navigation table structure:")
        for col in columns:
            nullable = "NULL" if col['is_nullable'] == 'YES' else "NOT NULL"
            print(f"   - {col['column_name']}: {col['data_type']} ({nullable})")
        
        # Check constraints
        print("\n4️⃣ Verifying foreign key constraint...")
        constraints = await conn.fetch("""
            SELECT
                tc.constraint_name,
                tc.constraint_type,
                kcu.column_name,
                ccu.table_name AS foreign_table_name,
                ccu.column_name AS foreign_column_name
            FROM information_schema.table_constraints AS tc
            JOIN information_schema.key_column_usage AS kcu
              ON tc.constraint_name = kcu.constraint_name
              AND tc.table_schema = kcu.table_schema
            LEFT JOIN information_schema.constraint_column_usage AS ccu
              ON ccu.constraint_name = tc.constraint_name
              AND ccu.table_schema = tc.table_schema
            WHERE tc.table_name = 'user_navigation'
              AND kcu.column_name = 'current_smart_matrix_id'
        """)
        
        if constraints:
            print("\n📋 Constraints on current_smart_matrix_id:")
            for constraint in constraints:
                print(f"   - {constraint['constraint_type']}: {constraint['constraint_name']}")
                if constraint['foreign_table_name']:
                    print(f"     References: {constraint['foreign_table_name']}({constraint['foreign_column_name']})")
        
        # Check indexes
        print("\n5️⃣ Verifying indexes...")
        indexes = await conn.fetch("""
            SELECT indexname, indexdef
            FROM pg_indexes
            WHERE tablename = 'user_navigation'
              AND indexname LIKE '%smart_matrix%'
        """)
        
        if indexes:
            print("\n📋 Indexes related to smart_matrix:")
            for idx in indexes:
                print(f"   - {idx['indexname']}")
        
        print("\n✅ Migration completed successfully!")
        
    except Exception as e:
        print(f"\n❌ Migration failed: {e}")
        raise
    finally:
        await conn.close()
        print("\n🔌 Database connection closed")

if __name__ == "__main__":
    asyncio.run(run_migration())
