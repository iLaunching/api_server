"""
Seed database with avatar_display option set and option values
Following the OPTION SET DESIGN document architecture
Simple option set with no additional attributes
"""
import asyncio
import asyncpg

DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def seed_avatar_display():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🌱 Seeding avatar_display option set...")
        
        # 1. Create the 'avatar_display' option set
        option_set_id = await conn.fetchval("""
            INSERT INTO option_sets (name, description, created_at)
            VALUES ('avatar_display', 'Avatar display mode options', NOW())
            ON CONFLICT (name) DO UPDATE SET name = 'avatar_display'
            RETURNING id
        """)
        print(f"✅ Created option_set 'avatar_display' with ID: {option_set_id}")
        
        # 2. Define avatar_display option values (no additional attributes)
        avatar_options = [
            {
                'value_name': 'default',
                'display_name': 'Default',
                'sort_order': 1
            },
            {
                'value_name': 'image',
                'display_name': 'Image',
                'sort_order': 2
            },
            {
                'value_name': 'icon',
                'display_name': 'Icon',
                'sort_order': 3
            }
        ]
        
        # 3. Insert option values (no theme_config needed - no attributes)
        for option in avatar_options:
            option_value_id = await conn.fetchval("""
                INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active, created_at)
                VALUES ($1, $2, $3, $4, true, NOW())
                RETURNING id
            """, option_set_id, option['value_name'], option['display_name'], option['sort_order'])
            
            print(f"  ✅ {option['display_name']} ({option['value_name']}) - ID: {option_value_id}")
        
        print(f"\n🎉 Successfully seeded {len(avatar_options)} avatar_display option values!")
        
        # 4. Verify
        count = await conn.fetchval("SELECT COUNT(*) FROM option_values WHERE option_set_id = $1", option_set_id)
        print(f"✅ Verification: {count} option values in avatar_display option set")
        
    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(seed_avatar_display())
