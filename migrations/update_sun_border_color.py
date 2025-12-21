import asyncpg
import asyncio
import os

# Get DATABASE_URL from environment
DATABASE_URL = os.getenv("DATABASE_URL")

async def update_sun_border_color():
    if not DATABASE_URL:
        print("❌ DATABASE_URL environment variable not set")
        return
    
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🔄 Updating Sun appearance border_line_color to #d6d6d6...")
        
        # Update the border_line_color for Sun appearance
        result = await conn.execute("""
            UPDATE theme_configs 
            SET border_line_color = '#d6d6d6' 
            WHERE option_value_id = (
                SELECT id FROM option_values 
                WHERE value_name = 'sun' 
                AND option_set_id = (
                    SELECT id FROM option_sets 
                    WHERE name = 'appearance'
                )
            );
        """)
        
        print(f"✅ Updated Sun border color: {result}")
        
        # Verify the change
        row = await conn.fetchrow("""
            SELECT tc.border_line_color 
            FROM theme_configs tc
            JOIN option_values ov ON tc.option_value_id = ov.id
            WHERE ov.value_name = 'sun'
            AND ov.option_set_id = (
                SELECT id FROM option_sets WHERE name = 'appearance'
            );
        """)
        
        if row:
            print(f"✅ Verified: Sun border_line_color is now {row['border_line_color']}")
        
    except Exception as e:
        print(f"❌ Error updating border color: {e}")
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(update_sun_border_color())
