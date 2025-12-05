"""
Seed database with account_type option set
Following the OPTION SET DESIGN document architecture
"""
import asyncio
import asyncpg
import os

# Get DATABASE_URL from environment
DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway")

async def seed_account_type():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🌱 Seeding account_type option set...")
        
        # 1. Create the option set
        option_set_id = await conn.fetchval("""
            INSERT INTO option_sets (name, description, created_at)
            VALUES ('account_type', 'Account type categories for user accounts', NOW())
            ON CONFLICT (name) DO UPDATE SET name = 'account_type'
            RETURNING id
        """)
        print(f"✅ Created option_set 'account_type' with ID: {option_set_id}")
        
        # 2. Define account type options
        options = [
            {'value_name': 'personal', 'display_name': 'Personal', 'sort_order': 1},
            {'value_name': 'business', 'display_name': 'Business', 'sort_order': 2},
            {'value_name': 'education', 'display_name': 'Education', 'sort_order': 3},
        ]
        
        # 3. Insert option values and theme configs
        for option in options:
            # Check if option value already exists
            existing_id = await conn.fetchval("""
                SELECT id FROM option_values 
                WHERE option_set_id = $1 AND value_name = $2
            """, option_set_id, option['value_name'])
            
            if existing_id:
                option_value_id = existing_id
                # Update existing
                await conn.execute("""
                    UPDATE option_values 
                    SET display_name = $1, sort_order = $2
                    WHERE id = $3
                """, option['display_name'], option['sort_order'], option_value_id)
            else:
                # Insert new option value
                option_value_id = await conn.fetchval("""
                    INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active)
                    VALUES ($1, $2, $3, $4, true)
                    RETURNING id
                """, option_set_id, option['value_name'], option['display_name'], option['sort_order'])
            
            # Check if theme config exists
            existing_config = await conn.fetchval("""
                SELECT option_value_id FROM theme_configs WHERE option_value_id = $1
            """, option_value_id)
            
            # Prepare metadata JSON (empty for account_type)
            metadata = '{}'
            
            if existing_config:
                # Update existing theme config
                await conn.execute("""
                    UPDATE theme_configs 
                    SET name = $1, theme_metadata = $2::jsonb
                    WHERE option_value_id = $3
                """, option['display_name'], metadata, option_value_id)
            else:
                # Insert new theme config
                await conn.execute("""
                    INSERT INTO theme_configs (option_value_id, name, text_color, background_color, menu_color, border_line_color, theme_metadata)
                    VALUES ($1, $2, '', '', '', '', $3::jsonb)
                """, option_value_id, option['display_name'], metadata)
            
            print(f"  ✓ Added {option['display_name']}")
        
        print(f"\n✅ Successfully seeded {len(options)} account type options!")
        print("🔄 Reload cache via API: POST /api/v1/themes/reload")
        
    except Exception as e:
        print(f"\n❌ Error seeding: {e}")
        raise
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(seed_account_type())
