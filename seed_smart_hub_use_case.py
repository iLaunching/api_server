"""
Smart Hub Use Case Option Set Seeder
Populates the smart_hub_use_case option set with use case categories
"""

import asyncio
import asyncpg

# Railway PostgreSQL connection string
DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

# Smart Hub Use Case options
USE_CASE_OPTIONS = [
    {
        "value_name": "start_business",
        "display_name": "Start a business",
        "sort_order": 1,
        "metadata": {}
    },
    {
        "value_name": "work",
        "display_name": "Work",
        "sort_order": 2,
        "metadata": {}
    },
    {
        "value_name": "personal",
        "display_name": "Personal",
        "sort_order": 3,
        "metadata": {}
    },
    {
        "value_name": "school",
        "display_name": "School",
        "sort_order": 4,
        "metadata": {}
    },
    {
        "value_name": "rapid_validation",
        "display_name": "Rapid product validation",
        "sort_order": 5,
        "metadata": {}
    },
    {
        "value_name": "launch_idea",
        "display_name": "Launch a idea",
        "sort_order": 6,
        "metadata": {}
    },
    {
        "value_name": "validate_idea",
        "display_name": "Validate my idea",
        "sort_order": 7,
        "metadata": {}
    }
]

async def seed_smart_hub_use_case():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🌱 Seeding Smart Hub Use Case option set...")
        
        # Step 1: Insert the option set
        await conn.execute("""
            INSERT INTO option_sets (name, description)
            VALUES ('smart_hub_use_case', 'Smart Hub use case categorization options')
            ON CONFLICT (name) DO NOTHING
        """)
        print("  ✓ Option set 'smart_hub_use_case' created/verified")
        
        # Step 2: Get the option set ID
        use_case_set_id = await conn.fetchval(
            "SELECT id FROM option_sets WHERE name = 'smart_hub_use_case'"
        )
        print(f"  ✓ Option set ID: {use_case_set_id}")
        
        # Step 3: Insert option values and theme configs
        for option in USE_CASE_OPTIONS:
            # Insert option value
            option_value_id = await conn.fetchval("""
                INSERT INTO option_values (option_set_id, value_name, display_name, sort_order)
                VALUES ($1, $2, $3, $4)
                ON CONFLICT DO NOTHING
                RETURNING id
            """, use_case_set_id, option['value_name'], option['display_name'], option['sort_order'])
            
            # If conflict (already exists), get existing ID
            if option_value_id is None:
                option_value_id = await conn.fetchval("""
                    SELECT id FROM option_values 
                    WHERE option_set_id = $1 AND value_name = $2
                """, use_case_set_id, option['value_name'])
            
            # Insert theme config (minimal since use cases don't need visual themes)
            await conn.execute("""
                INSERT INTO theme_configs (
                    option_value_id, name, text_color, background_color, 
                    menu_color, border_line_color, theme_metadata
                )
                VALUES ($1, $2, '', '', '', '', $3::jsonb)
                ON CONFLICT (option_value_id) DO NOTHING
            """, option_value_id, option['display_name'], '{}')
            
            print(f"  ✓ Added {option['display_name']}")
        
        print(f"\n✅ Successfully seeded {len(USE_CASE_OPTIONS)} use case options!")
        print("🔄 Reload cache via API: POST /api/v1/themes/reload")
        print("   Or restart the API server to pick up the new options")
        
    except Exception as e:
        print(f"\n❌ Error seeding: {e}")
        raise
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(seed_smart_hub_use_case())
