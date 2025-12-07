"""
Verify header_overlay_color was added successfully
"""
import asyncio
import asyncpg

DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def verify_changes():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🔍 Verifying header_overlay_color changes...")
        print("-" * 60)
        
        # Query appearance themes with the new column
        rows = await conn.fetch("""
            SELECT 
                ov.value_name,
                ov.display_name,
                tc.name as theme_name,
                tc.text_color,
                tc.background_color,
                tc.menu_color,
                tc.border_line_color,
                tc.header_overlay_color
            FROM option_values ov
            JOIN option_sets os ON ov.option_set_id = os.id
            JOIN theme_configs tc ON ov.id = tc.option_value_id
            WHERE os.name = 'appearance'
            ORDER BY ov.sort_order
        """)
        
        print(f"\n✅ Found {len(rows)} appearance themes:\n")
        
        for row in rows:
            print(f"Theme: {row['value_name']}")
            print(f"  Display Name: {row['display_name']}")
            print(f"  Header Overlay Color: {row['header_overlay_color']}")
            print()
        
        print("✅ Verification complete!")
        
    except Exception as e:
        print(f"\n❌ Verification failed: {e}")
        import traceback
        traceback.print_exc()
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(verify_changes())
