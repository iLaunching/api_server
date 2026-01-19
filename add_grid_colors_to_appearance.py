"""
Migration: Add line_grid_color and dotted_grid_color columns to theme_configs table
Updates existing appearance theme configurations with grid color values
"""
import asyncio
import asyncpg

DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def migrate_grid_colors():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🔄 Starting migration: Add grid colors to appearance themes...")
        
        # 1. Add the new columns to theme_configs table
        print("📝 Adding line_grid_color column...")
        await conn.execute("""
            ALTER TABLE theme_configs 
            ADD COLUMN IF NOT EXISTS line_grid_color VARCHAR(7)
        """)
        
        print("📝 Adding dotted_grid_color column...")
        await conn.execute("""
            ALTER TABLE theme_configs 
            ADD COLUMN IF NOT EXISTS dotted_grid_color VARCHAR(7)
        """)
        
        print("✅ Columns added successfully")
        
        # 2. Update existing theme configurations with grid color values
        print("🎨 Updating Sun theme with grid colors...")
        await conn.execute("""
            UPDATE theme_configs 
            SET line_grid_color = '#d6d6d6', dotted_grid_color = '#a0a0a0'
            WHERE option_value_id = (
                SELECT ov.id FROM option_values ov
                JOIN option_sets os ON ov.option_set_id = os.id
                WHERE os.name = 'appearance' AND ov.value_name = 'sun'
            )
        """)
        
        print("🎨 Updating Space theme with grid colors...")
        await conn.execute("""
            UPDATE theme_configs 
            SET line_grid_color = '#62676F', dotted_grid_color = '#62676F'
            WHERE option_value_id = (
                SELECT ov.id FROM option_values ov
                JOIN option_sets os ON ov.option_set_id = os.id
                WHERE os.name = 'appearance' AND ov.value_name = 'space'
            )
        """)
        
        print("🎨 Updating Moon theme with grid colors...")
        await conn.execute("""
            UPDATE theme_configs 
            SET line_grid_color = '#62676F', dotted_grid_color = '#62676F'
            WHERE option_value_id = (
                SELECT ov.id FROM option_values ov
                JOIN option_sets os ON ov.option_set_id = os.id
                WHERE os.name = 'appearance' AND ov.value_name = 'moon'
            )
        """)
        
        print("🎨 Updating Star theme with grid colors...")
        await conn.execute("""
            UPDATE theme_configs 
            SET line_grid_color = '#616daa', dotted_grid_color = '#616daa'
            WHERE option_value_id = (
                SELECT ov.id FROM option_values ov
                JOIN option_sets os ON ov.option_set_id = os.id
                WHERE os.name = 'appearance' AND ov.value_name = 'star'
            )
        """)
        
        print("✅ All theme configurations updated successfully")
        
        # 3. Verify the updates
        print("\n📊 Verifying updates...")
        results = await conn.fetch("""
            SELECT 
                ov.value_name as theme,
                tc.line_grid_color,
                tc.dotted_grid_color
            FROM theme_configs tc
            JOIN option_values ov ON tc.option_value_id = ov.id
            JOIN option_sets os ON ov.option_set_id = os.id
            WHERE os.name = 'appearance'
            ORDER BY ov.sort_order
        """)
        
        print("\n📋 Current Grid Colors Configuration:")
        print("─" * 60)
        for row in results:
            print(f"  {row['theme']:10} | Line: {row['line_grid_color']} | Dotted: {row['dotted_grid_color']}")
        print("─" * 60)
        
        print("\n✅ Migration completed successfully!")
        
    except Exception as e:
        print(f"❌ Migration failed: {e}")
        raise
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(migrate_grid_colors())
