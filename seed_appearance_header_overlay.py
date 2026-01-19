"""
Seed database with header_overlay_color for appearance option set
Updates existing appearance theme configs with header overlay colors
"""
import asyncio
import asyncpg
import os

# Get DATABASE_URL from environment
DATABASE_URL = os.getenv("DATABASE_URL")

async def seed_appearance_header_overlay():
    if not DATABASE_URL:
        print("❌ DATABASE_URL environment variable not set")
        return
    
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🌱 Seeding appearance header_overlay_color...")
        
        # Get the appearance option set ID
        option_set_id = await conn.fetchval("""
            SELECT id FROM option_sets WHERE name = 'appearance'
        """)
        
        if not option_set_id:
            print("❌ Appearance option set not found. Please run appearance_schema.sql first.")
            return
        
        print(f"✅ Found appearance option_set with ID: {option_set_id}")
        
        # Define header overlay colors for each theme
        header_overlays = [
            {'value_name': 'sun', 'header_overlay_color': '#00000080'},
            {'value_name': 'star', 'header_overlay_color': '#00000000'},
            {'value_name': 'moon', 'header_overlay_color': '#00000000'},
            {'value_name': 'space', 'header_overlay_color': '#00000000'},
        ]
        
        # Update each theme config with header_overlay_color
        for theme in header_overlays:
            # Get the option_value_id
            option_value_id = await conn.fetchval("""
                SELECT id FROM option_values 
                WHERE option_set_id = $1 AND value_name = $2
            """, option_set_id, theme['value_name'])
            
            if not option_value_id:
                print(f"  ⚠️  Theme '{theme['value_name']}' not found, skipping...")
                continue
            
            # Update the theme_config with header_overlay_color
            await conn.execute("""
                UPDATE theme_configs 
                SET header_overlay_color = $1
                WHERE option_value_id = $2
            """, theme['header_overlay_color'], option_value_id)
            
            print(f"  ✓ Updated {theme['value_name']}: header_overlay_color = {theme['header_overlay_color']}")
        
        print(f"\n✅ Successfully updated {len(header_overlays)} appearance themes with header_overlay_color!")
        print("🔄 Reload cache via API: POST /api/v1/themes/reload")
        
    except Exception as e:
        print(f"\n❌ Error seeding: {e}")
        import traceback
        traceback.print_exc()
        raise
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(seed_appearance_header_overlay())
