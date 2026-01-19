"""
Update appearance theme colors and user_button_icon in database
Sets final color configurations for Sun, Moon, Space, and Star themes
"""
import asyncio
import asyncpg

DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def update_appearance_colors():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🌱 Updating appearance theme colors...")
        
        # Define the final color configurations
        themes = [
            {
                'value_name': 'sun',
                'text_color': '#000000',
                'background_color': '#FFFFFF',
                'menu_color': '#FFFFFF',
                'border_line_color': '#d6d6d6',
                'header_overlay_color': '#00000080',
                'user_button_icon': '#000000',
                'user_button_color': '#ffffff59',
                'user_button_hover': '#ffffff66'
            },
            {
                'value_name': 'space',
                'text_color': '#ffffff',
                'background_color': '#2A2E35',
                'menu_color': '#3A3F47',
                'border_line_color': '#62676F',
                'header_overlay_color': '#00000000',
                'user_button_icon': '#ffffff',
                'user_button_color': '#505663',
                'user_button_hover': '#505663cc'
            },
            {
                'value_name': 'moon',
                'text_color': '#d6d6d6',
                'background_color': '#2F2F2F',
                'menu_color': '#464545',
                'border_line_color': '#62676F',
                'header_overlay_color': '#00000000',
                'user_button_icon': '#000000',
                'user_button_color': '#ffffff59',
                'user_button_hover': '#ffffff66'
            },
            {
                'value_name': 'star',
                'text_color': '#ffffff',
                'background_color': '#181B34',
                'menu_color': '#292F4C',
                'border_line_color': '#616daa',
                'header_overlay_color': '#00000000',
                'user_button_icon': '#ffffff',
                'user_button_color': '#181B34',
                'user_button_hover': '#181B34cc'
            }
        ]
        
        # Get the appearance option set ID
        appearance_set_id = await conn.fetchval("""
            SELECT id FROM option_sets WHERE name = 'appearance'
        """)
        
        if not appearance_set_id:
            print("❌ Appearance option set not found!")
            return
        
        print(f"✅ Found appearance option set ID: {appearance_set_id}")
        
        # Update each theme
        for theme in themes:
            # Get option_value_id
            option_value_id = await conn.fetchval("""
                SELECT id FROM option_values 
                WHERE option_set_id = $1 AND value_name = $2
            """, appearance_set_id, theme['value_name'])
            
            if not option_value_id:
                print(f"⚠️  Option value '{theme['value_name']}' not found, skipping...")
                continue
            
            # Update theme_config colors and metadata
            await conn.execute("""
                UPDATE theme_configs
                SET text_color = $1,
                    background_color = $2,
                    menu_color = $3,
                    border_line_color = $4,
                    header_overlay_color = $5,
                    theme_metadata = jsonb_build_object(
                        'user_button_icon', $6::text,
                        'user_button_color', $7::text,
                        'user_button_hover', $8::text
                    )
                WHERE option_value_id = $9
            """, 
                theme['text_color'],
                theme['background_color'],
                theme['menu_color'],
                theme['border_line_color'],
                theme['header_overlay_color'],
                theme['user_button_icon'],
                theme['user_button_color'],
                theme['user_button_hover'],
                option_value_id
            )
            
            print(f"  ✓ Updated {theme['value_name']}:")
            print(f"    - text_color: {theme['text_color']}")
            print(f"    - background_color: {theme['background_color']}")
            print(f"    - menu_color: {theme['menu_color']}")
            print(f"    - border_line_color: {theme['border_line_color']}")
            print(f"    - header_overlay_color: {theme['header_overlay_color']}")
            print(f"    - user_button_icon: {theme['user_button_icon']}")
            print(f"    - user_button_color: {theme['user_button_color']}")
            print(f"    - user_button_hover: {theme['user_button_hover']}")
        
        print(f"\n✅ Successfully updated {len(themes)} themes!")
        
        # Verify the updates
        print("\n🔍 Verifying updates...")
        results = await conn.fetch("""
            SELECT 
                ov.value_name,
                tc.text_color,
                tc.background_color,
                tc.menu_color,
                tc.border_line_color,
                tc.header_overlay_color,
                tc.theme_metadata->>'user_button_icon' as user_button_icon,
                tc.theme_metadata->>'user_button_color' as user_button_color,
                tc.theme_metadata->>'user_button_hover' as user_button_hover
            FROM theme_configs tc
            JOIN option_values ov ON tc.option_value_id = ov.id
            WHERE ov.option_set_id = $1
            ORDER BY ov.sort_order
        """, appearance_set_id)
        
        for row in results:
            print(f"\n{row['value_name'].upper()}:")
            print(f"  text_color: {row['text_color']}")
            print(f"  background_color: {row['background_color']}")
            print(f"  menu_color: {row['menu_color']}")
            print(f"  border_line_color: {row['border_line_color']}")
            print(f"  header_overlay_color: {row['header_overlay_color']}")
            print(f"  user_button_icon: {row['user_button_icon']}")
            print(f"  user_button_color: {row['user_button_color']}")
            print(f"  user_button_hover: {row['user_button_hover']}")
        
    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(update_appearance_colors())
