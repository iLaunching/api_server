"""
Seed script for onboarding_marketing_options option set
Populates the database with marketing source options for onboarding flow
"""

import asyncio
import asyncpg
import os

# Get DATABASE_URL from environment or use Railway URL
DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway")

async def seed_onboarding_marketing():
    """Seed onboarding marketing options into the database"""
    
    # Connect to database
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("Starting onboarding marketing options seed...")
        
        # 1. Create or update the option_set
        option_set_id = await conn.fetchval("""
            INSERT INTO option_sets (name, description, created_at)
            VALUES ($1, $2, NOW())
            ON CONFLICT (name) 
            DO UPDATE SET description = EXCLUDED.description
            RETURNING id
        """, 
        'onboarding_marketing_options',
        'Marketing source options for onboarding flow - where users heard about iLaunching'
        )
        
        print(f"✓ Option set created/updated with ID: {option_set_id}")
        
        # 2. Define all marketing options with their display names and sort order
        marketing_options = [
            ('search_engine', 'Search engine (Google, Bing, etc)', 1),
            ('google_ads', 'Google Ads', 2),
            ('facebook_ads', 'Facebook Ads', 3),
            ('youtube_ads', 'YouTube Ads', 4),
            ('social_media', 'Social Media', 5),
            ('email', 'Email', 6),
            ('audio_podcasts', 'Audio/Podcasts', 7),
            ('tv', 'TV', 8),
            ('newspaper', 'Newspaper', 9),
            ('billboard', 'Billboard', 10),
            ('word_of_mouth', 'Word of mouth', 11),
            ('other', 'Other', 12),
        ]
        
        # 3. Insert option_values and theme_configs
        for value_name, display_name, sort_order in marketing_options:
            # Check if option value already exists
            existing_id = await conn.fetchval("""
                SELECT id FROM option_values 
                WHERE option_set_id = $1 AND value_name = $2
            """, option_set_id, value_name)
            
            if existing_id:
                option_value_id = existing_id
                # Update existing
                await conn.execute("""
                    UPDATE option_values 
                    SET display_name = $1, sort_order = $2
                    WHERE id = $3
                """, display_name, sort_order, option_value_id)
            else:
                # Insert new option value
                option_value_id = await conn.fetchval("""
                    INSERT INTO option_values (option_set_id, value_name, display_name, sort_order, is_active)
                    VALUES ($1, $2, $3, $4, true)
                    RETURNING id
                """, option_set_id, value_name, display_name, sort_order)
            
            # Check if theme config exists
            existing_config = await conn.fetchval("""
                SELECT option_value_id FROM theme_configs WHERE option_value_id = $1
            """, option_value_id)
            
            if existing_config:
                # Update existing theme config
                await conn.execute("""
                    UPDATE theme_configs 
                    SET name = $1
                    WHERE option_value_id = $2
                """, display_name, option_value_id)
            else:
                # Insert new theme config
                await conn.execute("""
                    INSERT INTO theme_configs (option_value_id, name, text_color, background_color, menu_color, border_line_color, theme_metadata)
                    VALUES ($1, $2, '', '', '', '', '{}'::jsonb)
                """, option_value_id, display_name)
            
            print(f"  ✓ Created/updated: {display_name} (sort_order: {sort_order})")
        
        print(f"\n✅ Successfully seeded {len(marketing_options)} marketing options!")
        print(f"   Option Set ID: {option_set_id}")
        print(f"   Option Set Name: onboarding_marketing_options")
        
    except Exception as e:
        print(f"❌ Error seeding marketing options: {e}")
        raise
    finally:
        await conn.close()
        print("\n🔌 Database connection closed")

if __name__ == "__main__":
    print("=" * 60)
    print("Onboarding Marketing Options Seed Script")
    print("=" * 60)
    asyncio.run(seed_onboarding_marketing())
