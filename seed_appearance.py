"""
Seed database with appearance option set and option values
NO THEMES - this is an option set with option values and their attribute configs
Following the OPTION SET DESIGN document architecture
"""
import asyncio
import asyncpg

DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def seed_appearance():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🌱 Seeding appearance option set...")
        
        # 1. Create the 'appearance' option set
        option_set_id = await conn.fetchval("""
            INSERT INTO option_sets (name, description, created_at)
            VALUES ('appearance', 'Appearance configuration options', NOW())
            ON CONFLICT (name) DO UPDATE SET name = 'appearance'
            RETURNING id
        """)
        print(f"✅ Created option_set 'appearance' with ID: {option_set_id}")
        
        # 2. Define appearance option values with their attribute configurations
        # These are the 4 specific appearance options with exact colors
        appearances = [
            {
                'value_name': 'sun',
                'display_name': 'Sun',
                'sort_order': 1,
                'name': 'Sun',
                'text_color': '#000000',
                'background_color': '#FFFFFF',
                'menu_color': '#FFFFFF',
                'border_line_color': '#d6d6d6',
                'header_overlay_color': '#00000080',
                'user_button_icon': '#000000',
                'user_button_color': '#ffffff59',
                'user_button_hover': '#ffffff66',
                'title_menu_color_light': '#d6d6d6',
                'border_line_color_light': '#d6d6d659'
            },
            {
                'value_name': 'moon',
                'display_name': 'Moon',
                'sort_order': 2,
                'name': 'Moon',
                'text_color': '#d6d6d6',
                'background_color': '#2F2F2F',
                'menu_color': '#464545',
                'border_line_color': '#62676F',
                'header_overlay_color': '#00000000',
                'user_button_icon': '#000000',
                'user_button_color': '#ffffff59',
                'user_button_hover': '#ffffff66',
                'title_menu_color_light': '#62676F',
                'border_line_color_light': '#62676F59'
            },
            {
                'value_name': 'space',
                'display_name': 'Space',
                'sort_order': 3,
                'name': 'Space',
                'text_color': '#ffffff',
                'background_color': '#2A2E35',
                'menu_color': '#3A3F47',
                'border_line_color': '#62676F',
                'header_overlay_color': '#00000000',
                'user_button_icon': '#ffffff',
                'user_button_color': '#505663',
                'user_button_hover': '#505663cc',
                'title_menu_color_light': '#62676F',
                'border_line_color_light': '#62676F59'
            },
            {
                'value_name': 'star',
                'display_name': 'Star',
                'sort_order': 4,
                'name': 'Star',
                'text_color': '#ffffff',
                'background_color': '#181B34',
                'menu_color': '#292F4C',
                'border_line_color': '#616daa',
                'header_overlay_color': '#00000000',
                'user_button_icon': '#ffffff',
                'user_button_color': '#181B34',
                'user_button_hover': '#181B34cc',
                'title_menu_color_light': '#616daa',
                'border_line_color_light': '#616daa59'
            }
        ]
        
        # 3. Insert option values and their attribute configs
        for app in appearances:
            # Insert option_value
            option_value_id = await conn.fetchval("""
                INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, created_at)
                VALUES ($1, $2, $3, $4, true, NOW())
                RETURNING id
            """, option_set_id, app['value_name'], app['display_name'], app['sort_order'])
            
            # Insert theme_config (attribute config for this option value)
            await conn.execute("""
                INSERT INTO theme_configs (
                    option_value_id, name, text_color, background_color, 
                    menu_color, border_line_color, header_overlay_color,
                    user_button_color, user_button_hover, user_button_icon,
                    title_menu_color_light, border_line_color_light, created_at
                )
                VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, NOW())
            """, 
                option_value_id, 
                app['name'], 
                app['text_color'], 
                app['background_color'], 
                app['menu_color'], 
                app['border_line_color'],
                app['header_overlay_color'],
                app['user_button_color'],
                app['user_button_hover'],
                app['user_button_icon'],
                app['title_menu_color_light'],
                app['border_line_color_light']
            )
            
            print(f"  ✅ {app['name']} ({app['value_name']})")
        
        print(f"\n🎉 Successfully seeded {len(appearances)} appearance option values!")
        
        # 4. Verify
        count = await conn.fetchval("SELECT COUNT(*) FROM option_values WHERE option_set_id = $1", option_set_id)
        print(f"✅ Verification: {count} option values in appearance option set")
        
    except Exception as e:
        print(f"❌ Error: {e}")
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(seed_appearance())

