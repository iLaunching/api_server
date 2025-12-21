import asyncio
import asyncpg
import os

async def add_danger_colors():
    DATABASE_URL = os.getenv("DATABASE_URL")
    
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        # Add new danger color columns to theme_configs table
        await conn.execute("""
            ALTER TABLE theme_configs 
            ADD COLUMN IF NOT EXISTS danger_button_solid_color VARCHAR(9),
            ADD COLUMN IF NOT EXISTS danger_button_hover VARCHAR(9),
            ADD COLUMN IF NOT EXISTS danger_tone_bk VARCHAR(9),
            ADD COLUMN IF NOT EXISTS danger_tone_border VARCHAR(9),
            ADD COLUMN IF NOT EXISTS danger_tone_text VARCHAR(9),
            ADD COLUMN IF NOT EXISTS danger_bk_light_color VARCHAR(9),
            ADD COLUMN IF NOT EXISTS danger_bk_solid_color VARCHAR(9),
            ADD COLUMN IF NOT EXISTS danger_bk_solid_text_color VARCHAR(7);
        """)
        print("✓ Added danger color columns to theme_configs table")
        
        # Update all themes with danger color values
        await conn.execute("""
            UPDATE theme_configs
            SET danger_button_solid_color = '#C62A2FFF',
                danger_button_hover = '#C62A2F26',
                danger_tone_bk = '#C62A2F26',
                danger_tone_border = '#C62A2F61',
                danger_tone_text = '#C62A2FFF',
                danger_bk_light_color = '#C62A2F26',
                danger_bk_solid_color = '#C62A2FFF',
                danger_bk_solid_text_color = '#ffffff'
            WHERE name IN ('Sun', 'Moon', 'Space', 'Star');
        """)
        print("✓ Updated all themes with danger color values")
        
        # Verify the update
        rows = await conn.fetch("""
            SELECT name, danger_button_solid_color, danger_button_hover, danger_tone_bk
            FROM theme_configs
            WHERE name IN ('Sun', 'Moon', 'Space', 'Star');
        """)
        print("\nVerification:")
        for row in rows:
            print(f"  {row['name']}: danger_button_solid_color={row['danger_button_solid_color']}, "
                  f"danger_button_hover={row['danger_button_hover']}, danger_tone_bk={row['danger_tone_bk']}")
        
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(add_danger_colors())
