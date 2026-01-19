"""
Seed database with Smart Hub color scheme option set
Following the OPTION SET DESIGN document architecture
"""
import asyncio
import asyncpg
import os

# Get DATABASE_URL from environment or use Railway URL
DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway")

async def seed_smarthub_colors():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🌱 Seeding Smart Hub color scheme option set...")
        
        # 1. Create the 'smarthub_color_scheme' option set
        option_set_id = await conn.fetchval("""
            INSERT INTO option_sets (name, description, created_at)
            VALUES ('smarthub_color_scheme', 'Smart Hub color scheme configuration options', NOW())
            ON CONFLICT (name) DO UPDATE SET name = 'smarthub_color_scheme'
            RETURNING id
        """)
        print(f"✅ Created option_set 'smarthub_color_scheme' with ID: {option_set_id}")
        
        # 2. Define Smart Hub colors with hex codes
        colors = [
            {'value_name': 'highlight_green', 'display_name': 'Highlight Green', 'sort_order': 1, 'color': '#80b918'},
            {'value_name': 'mid_green', 'display_name': 'Mid Green', 'sort_order': 2, 'color': '#245501'},
            {'value_name': 'persian_green', 'display_name': 'Persian Green', 'sort_order': 3, 'color': '#2a9d8f'},
            {'value_name': 'charcoal', 'display_name': 'Charcoal', 'sort_order': 4, 'color': '#264653'},
            {'value_name': 'highlight_pink', 'display_name': 'Highlight Pink', 'sort_order': 5, 'color': '#FF4D6D'},
            {'value_name': 'dark_red', 'display_name': 'Dark Red', 'sort_order': 6, 'color': '#A4133C'},
            {'value_name': 'blush', 'display_name': 'Blush', 'sort_order': 7, 'color': '#DA627D'},
            {'value_name': 'cinnabar', 'display_name': 'Cinnabar', 'sort_order': 8, 'color': '#D8572A'},
            {'value_name': 'atomic_tangerine', 'display_name': 'Atomic Tangerine', 'sort_order': 9, 'color': '#E39774'},
            {'value_name': 'saffron', 'display_name': 'Saffron', 'sort_order': 10, 'color': '#F7B538'},
            {'value_name': 'royal_blue', 'display_name': 'Royal Blue', 'sort_order': 11, 'color': '#4361EE'},
            {'value_name': 'yinmn_blue', 'display_name': 'YInMn Blue', 'sort_order': 12, 'color': '#274c77'},
            {'value_name': 'uranian_blue', 'display_name': 'Uranian Blue', 'sort_order': 13, 'color': '#A3CEF1'},
            {'value_name': 'mauve', 'display_name': 'Mauve', 'sort_order': 14, 'color': '#CAA8F5'},
            {'value_name': 'dark_purple', 'display_name': 'Dark Purple', 'sort_order': 15, 'color': '#230C33'},
            {'value_name': 'tea_rose', 'display_name': 'Tea Rose', 'sort_order': 16, 'color': '#DBA8AC'},
            {'value_name': 'pastal_green', 'display_name': 'Pastal Green', 'sort_order': 17, 'color': '#797D62'},
            {'value_name': 'forest_green', 'display_name': 'Forest Green', 'sort_order': 18, 'color': '#548c2f'},
            {'value_name': 'olive', 'display_name': 'Olive', 'sort_order': 19, 'color': '#6f732f'},
            {'value_name': 'taupe', 'display_name': 'Taupe', 'sort_order': 20, 'color': '#997B66'},
            {'value_name': 'chestnut', 'display_name': 'Chestnut', 'sort_order': 21, 'color': '#5E3023'},
            {'value_name': 'beaver', 'display_name': 'Beaver', 'sort_order': 22, 'color': '#a9927d'},
            {'value_name': 'goldenrod', 'display_name': 'Goldenrod', 'sort_order': 23, 'color': '#C9A227'},
            {'value_name': 'old_gold', 'display_name': 'Old Gold', 'sort_order': 24, 'color': '#C9A227'},
            {'value_name': 'charcoal_dark', 'display_name': 'Charcoal Dark', 'sort_order': 25, 'color': '#2A2828'},
            {'value_name': 'french_grey', 'display_name': 'French Grey', 'sort_order': 26, 'color': '#CED4DA'},
            {'value_name': 'lapis_lazuli', 'display_name': 'Lapis Lazuli', 'sort_order': 27, 'color': '#3152BB'},
        ]
        
        # 3. Insert option values and theme configs
        for color in colors:
            # Check if option value already exists
            existing_id = await conn.fetchval("""
                SELECT id FROM option_values 
                WHERE option_set_id = $1 AND value_name = $2
            """, option_set_id, color['value_name'])
            
            if existing_id:
                option_value_id = existing_id
                # Update existing
                await conn.execute("""
                    UPDATE option_values 
                    SET display_name = $1, sort_order = $2
                    WHERE id = $3
                """, color['display_name'], color['sort_order'], option_value_id)
            else:
                # Insert new option value
                option_value_id = await conn.fetchval("""
                    INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active)
                    VALUES ($1, $2, $3, $4, true)
                    RETURNING id
                """, option_set_id, color['value_name'], color['display_name'], color['sort_order'])
            
            # Check if theme config exists
            existing_config = await conn.fetchval("""
                SELECT option_value_id FROM theme_configs WHERE option_value_id = $1
            """, option_value_id)
            
            if existing_config:
                # Update existing theme config
                await conn.execute("""
                    UPDATE theme_configs 
                    SET name = $1, theme_metadata = $2::jsonb
                    WHERE option_value_id = $3
                """, color['display_name'], f'{{"color": "{color["color"]}"}}', option_value_id)
            else:
                # Insert new theme config with color in metadata
                await conn.execute("""
                    INSERT INTO theme_configs (option_value_id, name, text_color, background_color, menu_color, border_line_color, theme_metadata)
                    VALUES ($1, $2, '', '', '', '', $3::jsonb)
                """, option_value_id, color['display_name'], f'{{"color": "{color["color"]}"}}')
            
            print(f"  ✓ Added {color['display_name']} ({color['color']})")
        
        print(f"\n✅ Successfully seeded {len(colors)} Smart Hub colors!")
        print("🔄 Restart your API server to load the colors into the cache.")
        
    except Exception as e:
        print(f"\n❌ Error seeding Smart Hub colors: {e}")
        raise
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(seed_smarthub_colors())
