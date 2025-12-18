"""
Migration: Add chat_bk_1 column to theme_configs table
Adds gradient background support for chat interfaces in appearance themes
"""
import asyncio
import asyncpg
import os

DATABASE_URL = os.getenv("DATABASE_URL")

async def migrate():
    if not DATABASE_URL:
        print("❌ DATABASE_URL environment variable not set")
        return
    
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🔄 Adding chat_bk_1 column to theme_configs...")
        
        # Step 1: Add the column if it doesn't exist
        await conn.execute("""
            ALTER TABLE theme_configs 
            ADD COLUMN IF NOT EXISTS chat_bk_1 TEXT;
        """)
        print("✅ Column chat_bk_1 added")
        
        # Step 2: Update existing appearance theme records with gradient values
        print("🔄 Updating appearance themes with chat background gradients...")
        
        # Get appearance option set ID
        appearance_set_id = await conn.fetchval("""
            SELECT id FROM option_sets WHERE name = 'appearance'
        """)
        
        if not appearance_set_id:
            print("⚠️ Appearance option set not found, skipping gradient updates")
            return
        
        # Update Sun theme
        sun_updated = await conn.execute("""
            UPDATE theme_configs tc
            SET 
                chat_bk_1 = 'linear-gradient(90deg, rgba(255, 255, 255, 0.64) 0%, rgba(255, 255, 255, 0.93) 38%, rgba(255, 255, 255, 0.84) 82%)',
                theme_metadata = COALESCE(theme_metadata, '{}'::jsonb) || '{"chat_bk_1": "linear-gradient(90deg, rgba(255, 255, 255, 0.64) 0%, rgba(255, 255, 255, 0.93) 38%, rgba(255, 255, 255, 0.84) 82%)"}'::jsonb
            FROM option_values ov
            WHERE tc.option_value_id = ov.id
            AND ov.option_set_id = $1
            AND ov.value_name = 'sun'
        """, appearance_set_id)
        print(f"  ✓ Sun theme updated")
        
        # Update Moon theme
        moon_updated = await conn.execute("""
            UPDATE theme_configs tc
            SET 
                chat_bk_1 = 'linear-gradient(90deg, rgba(70, 69, 69, 0.35) 0%, rgba(70, 69, 69, 1) 45%, rgba(70, 69, 69, 0.41) 82%)',
                theme_metadata = COALESCE(theme_metadata, '{}'::jsonb) || '{"chat_bk_1": "linear-gradient(90deg, rgba(70, 69, 69, 0.35) 0%, rgba(70, 69, 69, 1) 45%, rgba(70, 69, 69, 0.41) 82%)"}'::jsonb
            FROM option_values ov
            WHERE tc.option_value_id = ov.id
            AND ov.option_set_id = $1
            AND ov.value_name = 'moon'
        """, appearance_set_id)
        print(f"  ✓ Moon theme updated")
        
        # Update Space theme
        space_updated = await conn.execute("""
            UPDATE theme_configs tc
            SET 
                chat_bk_1 = 'linear-gradient(90deg, rgba(58, 63, 71, 0.35) 0%, rgba(58, 63, 71, 1) 45%, rgba(58, 63, 71, 0.41) 82%)',
                theme_metadata = COALESCE(theme_metadata, '{}'::jsonb) || '{"chat_bk_1": "linear-gradient(90deg, rgba(58, 63, 71, 0.35) 0%, rgba(58, 63, 71, 1) 45%, rgba(58, 63, 71, 0.41) 82%)"}'::jsonb
            FROM option_values ov
            WHERE tc.option_value_id = ov.id
            AND ov.option_set_id = $1
            AND ov.value_name = 'space'
        """, appearance_set_id)
        print(f"  ✓ Space theme updated")
        
        # Update Star theme
        star_updated = await conn.execute("""
            UPDATE theme_configs tc
            SET 
                chat_bk_1 = 'linear-gradient(90deg, rgba(41, 47, 76, 0.35) 0%, rgba(41, 47, 76, 1) 45%, rgba(41, 47, 76, 0.41) 82%)',
                theme_metadata = COALESCE(theme_metadata, '{}'::jsonb) || '{"chat_bk_1": "linear-gradient(90deg, rgba(41, 47, 76, 0.35) 0%, rgba(41, 47, 76, 1) 45%, rgba(41, 47, 76, 0.41) 82%)"}'::jsonb
            FROM option_values ov
            WHERE tc.option_value_id = ov.id
            AND ov.option_set_id = $1
            AND ov.value_name = 'star'
        """, appearance_set_id)
        print(f"  ✓ Star theme updated")
        
        print("\n✅ Migration completed successfully!")
        print("🔄 Remember to reload the cache: POST /api/v1/themes/reload")
        
    except Exception as e:
        print(f"\n❌ Migration failed: {e}")
        raise
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(migrate())
