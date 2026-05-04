"""
Smart Hub Use Case Option Set Seeder
Populates the smart_hub_use_case option set with use case categories
"""

import asyncio
import asyncpg
import os

# Get DATABASE_URL from environment or use Railway URL
DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway",
)

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
    },
    {
        "value_name": "active_chat",
        "display_name": "Active Chat",
        "sort_order": 8,
        "metadata": {}
    }
]

async def seed_smart_hub_use_case():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🌱 Seeding Smart Hub Use Case option set...")
        
        # Step 1: Create or update option set (some DBs may not have UNIQUE on option_sets.name)
        option_set_name = "smart_hub_use_case"
        option_set_description = "Smart Hub use case categorization options"

        use_case_set_id = await conn.fetchval(
            "SELECT id FROM option_sets WHERE name = $1 LIMIT 1",
            option_set_name,
        )
        if use_case_set_id:
            await conn.execute(
                "UPDATE option_sets SET description = $1 WHERE id = $2",
                option_set_description,
                use_case_set_id,
            )
        else:
            use_case_set_id = await conn.fetchval(
                """
                INSERT INTO option_sets (name, description)
                VALUES ($1, $2)
                RETURNING id
                """,
                option_set_name,
                option_set_description,
            )
        print("  ✓ Option set 'smart_hub_use_case' created/verified")
        
        # Step 2: Option set ID
        print(f"  ✓ Option set ID: {use_case_set_id}")
        
        # Step 3: Insert option values and theme configs
        for option in USE_CASE_OPTIONS:
            # Insert option value
            existing_id = await conn.fetchval(
                """
                SELECT id FROM option_values
                WHERE option_set_id = $1 AND value_name = $2
                """,
                use_case_set_id,
                option["value_name"],
            )

            if existing_id:
                option_value_id = existing_id
                await conn.execute(
                    """
                    UPDATE option_values
                    SET display_name = $1, sort_order = $2, is_active = true
                    WHERE id = $3
                    """,
                    option["display_name"],
                    option["sort_order"],
                    option_value_id,
                )
            else:
                option_value_id = await conn.fetchval(
                    """
                    INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active)
                    VALUES ($1, $2, $3, $4, true)
                    RETURNING id
                    """,
                    use_case_set_id,
                    option["value_name"],
                    option["display_name"],
                    option["sort_order"],
                )
            
            # Insert/update theme config (some DBs may not have UNIQUE on theme_configs.option_value_id)
            existing_cfg = await conn.fetchval(
                "SELECT option_value_id FROM theme_configs WHERE option_value_id = $1 LIMIT 1",
                option_value_id,
            )
            if existing_cfg:
                await conn.execute(
                    "UPDATE theme_configs SET name = $1 WHERE option_value_id = $2",
                    option["display_name"],
                    option_value_id,
                )
            else:
                await conn.execute(
                    """
                    INSERT INTO theme_configs (
                        option_value_id, name, text_color, background_color,
                        menu_color, border_line_color, theme_metadata
                    )
                    VALUES ($1, $2, '', '', '', '', $3::jsonb)
                    """,
                    option_value_id,
                    option["display_name"],
                    "{}",
                )
            
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
