"""
Migration: Add prompt_bk and prompt_text_color columns to theme_configs
Adds background and text color properties for prompt elements in appearance themes
"""

import asyncio
import asyncpg
import os
from dotenv import load_dotenv

load_dotenv()

async def add_prompt_color_columns():
    database_url = os.getenv("DATABASE_URL") or os.getenv("RAILWAY_DATABASE_URL")
    if not database_url:
        # Use Railway default if no env var
        database_url = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"
        print("⚠️  Using default Railway DATABASE_URL")
    
    conn = await asyncpg.connect(database_url)
    
    try:
        print("🔄 Adding prompt color columns to theme_configs table...")
        
        # Step 1: Add the prompt_bk and prompt_text_color columns
        await conn.execute("""
            ALTER TABLE theme_configs 
            ADD COLUMN IF NOT EXISTS prompt_bk VARCHAR(9),
            ADD COLUMN IF NOT EXISTS prompt_text_color VARCHAR(7);
        """)
        print("  ✓ Added prompt_bk and prompt_text_color columns")
        
        # Step 2: Get the appearance option set ID
        appearance_set_id = await conn.fetchval(
            "SELECT id FROM option_sets WHERE name = 'appearance'"
        )
        
        if not appearance_set_id:
            print("  ⚠️  Appearance option set not found")
            return
        
        print(f"  ✓ Found appearance set ID: {appearance_set_id}")
        
        # Step 3: Update Sun theme
        sun_id = await conn.fetchval("""
            SELECT id FROM option_values 
            WHERE option_set_id = $1 AND value_name = 'sun'
        """, appearance_set_id)
        
        if sun_id:
            await conn.execute("""
                UPDATE theme_configs 
                SET prompt_bk = $1, prompt_text_color = $2
                WHERE option_value_id = $3
            """, '#ffffff', '#000000', sun_id)
            print("  ✓ Updated Sun theme: prompt_bk=#ffffff, prompt_text_color=#000000")
        
        # Step 4: Update Moon theme
        moon_id = await conn.fetchval("""
            SELECT id FROM option_values 
            WHERE option_set_id = $1 AND value_name = 'moon'
        """, appearance_set_id)
        
        if moon_id:
            await conn.execute("""
                UPDATE theme_configs 
                SET prompt_bk = $1, prompt_text_color = $2
                WHERE option_value_id = $3
            """, '#ffffff00', '#ffffff', moon_id)
            print("  ✓ Updated Moon theme: prompt_bk=#ffffff00, prompt_text_color=#ffffff")
        
        # Step 5: Update Space theme
        space_id = await conn.fetchval("""
            SELECT id FROM option_values 
            WHERE option_set_id = $1 AND value_name = 'space'
        """, appearance_set_id)
        
        if space_id:
            await conn.execute("""
                UPDATE theme_configs 
                SET prompt_bk = $1, prompt_text_color = $2
                WHERE option_value_id = $3
            """, '#ffffff00', '#ffffff', space_id)
            print("  ✓ Updated Space theme: prompt_bk=#ffffff00, prompt_text_color=#ffffff")
        
        # Step 6: Update Star theme
        star_id = await conn.fetchval("""
            SELECT id FROM option_values 
            WHERE option_set_id = $1 AND value_name = 'star'
        """, appearance_set_id)
        
        if star_id:
            await conn.execute("""
                UPDATE theme_configs 
                SET prompt_bk = $1, prompt_text_color = $2
                WHERE option_value_id = $3
            """, '#ffffff00', '#ffffff', star_id)
            print("  ✓ Updated Star theme: prompt_bk=#ffffff00, prompt_text_color=#ffffff")
        
        print("\n✅ Migration completed successfully!")
        print("📋 Summary:")
        print("   - Sun: prompt_bk=#ffffff, prompt_text_color=#000000")
        print("   - Moon: prompt_bk=#ffffff00 (transparent), prompt_text_color=#ffffff")
        print("   - Space: prompt_bk=#ffffff00 (transparent), prompt_text_color=#ffffff")
        print("   - Star: prompt_bk=#ffffff00 (transparent), prompt_text_color=#ffffff")
        
    except Exception as e:
        print(f"\n❌ Migration failed: {e}")
        raise
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(add_prompt_color_columns())
