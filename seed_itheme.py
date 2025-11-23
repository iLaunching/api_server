"""
Seed database with iTheme option set and option values
Following the OPTION SET DESIGN document architecture
These are gradient-based themes with opacity and hover effects
"""
import asyncio
import asyncpg
import json

DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def seed_itheme():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🌱 Seeding iTheme option set...")
        
        # 1. Create the 'itheme' option set
        option_set_id = await conn.fetchval("""
            INSERT INTO option_sets (name, description, created_at)
            VALUES ('itheme', 'iTheme gradient configuration options', NOW())
            ON CONFLICT (name) DO UPDATE SET name = 'itheme'
            RETURNING id
        """)
        print(f"✅ Created option_set 'itheme' with ID: {option_set_id}")
        
        # 2. Define iTheme option values with their gradient configurations
        ithemes = [
            {
                'value_name': 'ipurple',
                'display_name': 'iLaunching Purple',
                'sort_order': 1,
                'name': 'iLaunching purple',
                'bg_opacity': '#7F77F125',
                'bg_gradient': 'linear-gradient(to bottom right, rgba(127, 119, 241, 0.8), rgba(165, 161, 248, 0.6), rgba(197, 227, 252, 0.4), rgba(255, 255, 255, 0.2))',
                'hover_color': '#6B63DD',
                'menu_bg_opacity': '#7F77F114',
                'solid_color': '#7F77F1',
                'menu_opacity_color': '#7F77F106'
            },
            {
                'value_name': 'iblue',
                'display_name': 'Ocean Deep',
                'sort_order': 2,
                'name': 'Ocean Deep',
                'bg_opacity': '#0F90E025',
                'bg_gradient': 'linear-gradient(to bottom right, rgba(15, 144, 224, 0.8), rgba(71, 180, 237, 0.6), rgba(140, 214, 245, 0.4), rgba(255, 255, 255, 0.2))',
                'hover_color': '#0F90E0',
                'menu_bg_opacity': '#0F90E014',
                'solid_color': '#0F90E0',
                'menu_opacity_color': '#0F90E006'
            },
            {
                'value_name': 'ipink',
                'display_name': 'Rose Quartz',
                'sort_order': 3,
                'name': 'Rose Quartz',
                'bg_opacity': '#EE5E9925',
                'bg_gradient': 'linear-gradient(to bottom right, rgba(238, 94, 153, 0.8), rgba(245, 140, 180, 0.6), rgba(251, 191, 212, 0.4), rgba(255, 255, 255, 0.2))',
                'hover_color': '#BE3E79',
                'menu_bg_opacity': '#EE5E9914',
                'solid_color': '#EE5E99',
                'menu_opacity_color': '#EE5E9906'
            },
            {
                'value_name': 'iviolet',
                'display_name': 'Regal Plum',
                'sort_order': 4,
                'name': 'Regal Plum',
                'bg_opacity': '#B660E025',
                'bg_gradient': 'linear-gradient(to bottom right, rgba(182, 96, 224, 0.8), rgba(201, 137, 232, 0.6), rgba(228, 183, 241, 0.4), rgba(255, 255, 255, 0.2))',
                'hover_color': '#8E40B0',
                'menu_bg_opacity': '#B660E014',
                'solid_color': '#B660E0',
                'menu_opacity_color': '#B660E006'
            },
            {
                'value_name': 'iindigo',
                'display_name': 'Oceanic Indigo',
                'sort_order': 5,
                'name': 'Oceanic Indigo',
                'bg_opacity': '#6985FF25',
                'bg_gradient': 'linear-gradient(to bottom right, rgba(105, 133, 255, 0.8), rgba(142, 163, 255, 0.6), rgba(196, 211, 255, 0.4), rgba(255, 255, 255, 0.2))',
                'hover_color': '#4763CC',
                'menu_bg_opacity': '#6985FF14',
                'solid_color': '#6985FF',
                'menu_opacity_color': '#6985FF06'
            },
            {
                'value_name': 'iorange',
                'display_name': 'Citrus Burst',
                'sort_order': 6,
                'name': 'Citrus Burst',
                'bg_opacity': '#E16B1625',
                'bg_gradient': 'linear-gradient(to bottom right, rgba(225, 107, 22, 0.8), rgba(240, 140, 71, 0.6), rgba(248, 185, 140, 0.4), rgba(255, 255, 255, 0.2))',
                'hover_color': '#B15300',
                'menu_bg_opacity': '#E16B1614',
                'solid_color': '#E16B16',
                'menu_opacity_color': '#E16B1606'
            },
            {
                'value_name': 'iteal',
                'display_name': 'Aqua Dream',
                'sort_order': 7,
                'name': 'Aqua Dream',
                'bg_opacity': '#109D9F25',
                'bg_gradient': 'linear-gradient(to bottom right, rgba(16, 157, 159, 0.8), rgba(68, 181, 182, 0.6), rgba(136, 212, 213, 0.4), rgba(255, 255, 255, 0.2))',
                'hover_color': '#0C7D7F',
                'menu_bg_opacity': '#109D9F14',
                'solid_color': '#109D9F',
                'menu_opacity_color': '#109D9F06'
            },
            {
                'value_name': 'imint',
                'display_name': 'Fresh Mint',
                'sort_order': 8,
                'name': 'Fresh Mint',
                'bg_opacity': '#3EB88B25',
                'bg_gradient': 'linear-gradient(to bottom right, rgba(62, 184, 139, 0.8), rgba(99, 199, 163, 0.6), rgba(161, 226, 200, 0.4), rgba(255, 255, 255, 0.2))',
                'hover_color': '#2D8B6D',
                'menu_bg_opacity': '#3EB88B14',
                'solid_color': '#3EB88B',
                'menu_opacity_color': '#3EB88B06'
            },
            {
                'value_name': 'ibronze',
                'display_name': 'Copper Glow',
                'sort_order': 9,
                'name': 'Copper Glow',
                'bg_opacity': '#AA8D8025',
                'bg_gradient': 'linear-gradient(to bottom right, rgba(170, 141, 128, 0.8), rgba(192, 167, 155, 0.6), rgba(216, 200, 184, 0.4), rgba(255, 255, 255, 0.2))',
                'hover_color': '#886B5E',
                'menu_bg_opacity': '#AA8D8014',
                'solid_color': '#AA8D80',
                'menu_opacity_color': '#AA8D8006'
            },
            {
                'value_name': 'iolive',
                'display_name': 'Olive Grove',
                'sort_order': 10,
                'name': 'Olive Grove',
                'bg_opacity': '#9F9F8025',
                'bg_gradient': 'linear-gradient(to bottom right, rgba(159, 159, 128, 0.8), rgba(181, 181, 154, 0.6), rgba(211, 211, 190, 0.4), rgba(255, 255, 255, 0.2))',
                'hover_color': '#7F7F60',
                'menu_bg_opacity': '#9F9F8014',
                'solid_color': '#9F9F80',
                'menu_opacity_color': '#9F9F8006'
            },
            {
                'value_name': 'ilime_green',
                'display_name': 'Electric Lime',
                'sort_order': 11,
                'name': 'Electric Lime',
                'bg_opacity': '#32CD3225',
                'bg_gradient': 'linear-gradient(to bottom right, rgba(50, 205, 50, 0.8), rgba(102, 224, 102, 0.6), rgba(169, 247, 169, 0.4), rgba(255, 255, 255, 0.2))',
                'hover_color': '#28A745',
                'menu_bg_opacity': '#32CD3214',
                'solid_color': '#32CD32',
                'menu_opacity_color': '#32CD3206'
            },
            {
                'value_name': 'itomato',
                'display_name': 'Tomato Gleam',
                'sort_order': 12,
                'name': 'Tomato Gleam',
                'bg_opacity': '#FF634725',
                'bg_gradient': 'linear-gradient(to bottom right, rgba(255, 99, 71, 0.8), rgba(255, 130, 101, 0.6), rgba(255, 183, 156, 0.4), rgba(255, 255, 255, 0.2))',
                'hover_color': '#E03C31',
                'menu_bg_opacity': '#FF634714',
                'solid_color': '#FF6347',
                'menu_opacity_color': '#FF634706'
            },
            {
                'value_name': 'iblack',
                'display_name': 'Onyx Shadow',
                'sort_order': 13,
                'name': 'Onyx Shadow',
                'bg_opacity': '#595C6625',
                'bg_gradient': 'linear-gradient(to bottom right, rgba(89, 92, 102, 0.8), rgba(122, 127, 136, 0.6), rgba(161, 166, 177, 0.4), rgba(255, 255, 255, 0.2))',
                'hover_color': '#3F424C',
                'menu_bg_opacity': '#595C6614',
                'solid_color': '#595C66',
                'menu_opacity_color': '#595C6606'
            }
        ]
        
        # 3. Insert option values and their attribute configs
        for theme in ithemes:
            # Insert option_value
            option_value_id = await conn.fetchval("""
                INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, created_at)
                VALUES ($1, $2, $3, $4, true, NOW())
                RETURNING id
            """, option_set_id, theme['value_name'], theme['display_name'], theme['sort_order'])
            
            # Insert theme_config with gradient attributes
            metadata = {
                'bg_opacity': theme['bg_opacity'],
                'bg_gradient': theme['bg_gradient'],
                'hover_color': theme['hover_color'],
                'menu_bg_opacity': theme['menu_bg_opacity'],
                'solid_color': theme['solid_color'],
                'menu_opacity_color': theme['menu_opacity_color']
            }
            
            await conn.execute("""
                INSERT INTO theme_configs (
                    option_value_id, name, theme_metadata, created_at,
                    text_color, background_color, menu_color, border_line_color
                )
                VALUES ($1, $2, $3::jsonb, NOW(), '', '', '', '')
            """, option_value_id, theme['name'], json.dumps(metadata))
            
            print(f"  ✅ {theme['name']} ({theme['value_name']})")
        
        print(f"\n🎉 Successfully seeded {len(ithemes)} iTheme option values!")
        
        # 4. Verify
        count = await conn.fetchval("SELECT COUNT(*) FROM option_values WHERE option_set_id = $1", option_set_id)
        print(f"✅ Verification: {count} option values in itheme option set")
        
    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(seed_itheme())
