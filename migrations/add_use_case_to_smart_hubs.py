"""
Migration: Add use_case column to smart_hubs table
Connects to smart_hub_use_case option set similar to hub_color_id
"""

import asyncio
import asyncpg

# Railway PostgreSQL connection string
DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def add_use_case_column():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🔄 Adding use_case column to smart_hubs table...")
        
        # Step 1: Add the use_case_id column as a foreign key to option_values
        await conn.execute("""
            ALTER TABLE smart_hubs 
            ADD COLUMN IF NOT EXISTS use_case_id INTEGER 
            REFERENCES option_values(id) ON DELETE SET NULL;
        """)
        print("  ✓ Added use_case_id column (FK to option_values)")
        
        # Step 2: Create an index on use_case_id for performance
        await conn.execute("""
            CREATE INDEX IF NOT EXISTS idx_smart_hubs_use_case_id 
            ON smart_hubs(use_case_id);
        """)
        print("  ✓ Created index on use_case_id")
        
        # Step 3: Get the default use case option value ID (start_business)
        default_use_case_id = await conn.fetchval("""
            SELECT ov.id 
            FROM option_values ov
            JOIN option_sets os ON ov.option_set_id = os.id
            WHERE os.name = 'smart_hub_use_case' 
            AND ov.value_name = 'start_business'
        """)
        
        if default_use_case_id:
            print(f"  ✓ Found default use case ID: {default_use_case_id} (start_business)")
            
            # Step 4: Set default value for existing rows
            rows_updated = await conn.execute("""
                UPDATE smart_hubs 
                SET use_case_id = $1 
                WHERE use_case_id IS NULL
            """, default_use_case_id)
            print(f"  ✓ Updated existing rows with default use case: {rows_updated}")
        else:
            print("  ⚠️  Warning: Could not find default use case option (start_business)")
            print("     Existing rows will have NULL use_case_id")
        
        print("\n✅ Migration completed successfully!")
        print("📝 Next steps:")
        print("   1. Update SmartHub model in database_models.py")
        print("   2. Add use_case relationship to SmartHub class")
        print("   3. Update API routes to include use_case data")
        
    except Exception as e:
        print(f"\n❌ Error during migration: {e}")
        raise
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(add_use_case_column())
