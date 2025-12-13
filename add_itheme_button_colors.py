"""
Add button color configuration to itheme option set
"""
import asyncio
import os
import sys
from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy import text

async def run_migration():
    # Get database URL from environment
    database_url = os.getenv('DATABASE_URL')
    
    if not database_url:
        print("❌ ERROR: DATABASE_URL environment variable not set")
        print("Please set DATABASE_URL to your PostgreSQL connection string")
        sys.exit(1)
    
    # Convert to async URL
    if database_url.startswith('postgresql://'):
        database_url = database_url.replace('postgresql://', 'postgresql+asyncpg://')
    
    print("🔗 Connecting to database...")
    engine = create_async_engine(database_url)
    
    try:
        async with engine.begin() as conn:
            print("\n📊 Current itheme metadata sample:")
            result = await conn.execute(text("""
                SELECT ov.value_name, tc.theme_metadata
                FROM theme_configs tc
                JOIN option_values ov ON tc.option_value_id = ov.id
                JOIN option_sets os ON ov.option_set_id = os.id
                WHERE os.name = 'itheme'
                ORDER BY ov.sort_order
                LIMIT 3;
            """))
            rows = result.fetchall()
            for row in rows:
                print(f"   {row[0]}: {row[1]}")
            
            print("\n🔧 Adding button color configuration to all itheme options...")
            
            # Get itheme set ID
            result = await conn.execute(text("SELECT id FROM option_sets WHERE name = 'itheme'"))
            itheme_set_id = result.scalar()
            
            if not itheme_set_id:
                print("❌ ERROR: itheme option set not found")
                return
            
            # Define button colors for each theme
            theme_configs = [
                ('ipurple', '#7F77F1', '#ffffff', '#6B63DD'),
                ('iblue', '#0F90E0', '#ffffff', '#0F90E0'),
                ('ipink', '#EE5E99', '#ffffff', '#BE3E79'),
                ('iviolet', '#B660E0', '#ffffff', '#8E40B0'),
                ('iindigo', '#6985FF', '#ffffff', '#4763CC'),
                ('iorange', '#E16B16', '#ffffff', '#B15300'),
                ('iteal', '#109D9F', '#ffffff', '#0C7D7F'),
                ('imint', '#3EB88B', '#ffffff', '#2D8B6D'),
                ('ibronze', '#AA8D80', '#ffffff', '#886B5E'),
                ('iolive', '#9F9F80', '#ffffff', '#7F7F60'),
                ('ilime_green', '#32CD32', '#ffffff', '#28A745'),
                ('itomato', '#FF6347', '#ffffff', '#E03C31'),
                ('iblack', '#595C66', '#ffffff', '#3F424C'),
            ]
            
            updated_count = 0
            for theme_name, button_bk, button_text, button_hover in theme_configs:
                result = await conn.execute(text(f"""
                    UPDATE theme_configs tc
                    SET theme_metadata = theme_metadata || 
                        '{{"button_bk_color": "{button_bk}", "button_text_color": "{button_text}", "button_hover_color": "{button_hover}"}}'::jsonb
                    WHERE option_value_id = (
                        SELECT id FROM option_values WHERE option_set_id = :itheme_set_id AND value_name = :theme_name LIMIT 1
                    )
                """), {"itheme_set_id": itheme_set_id, "theme_name": theme_name})
                updated_count += result.rowcount
                print(f"   ✅ Updated {theme_name}")
            
            print(f"\n✅ Successfully updated {updated_count} themes")
            
            print("\n✅ Migration completed successfully!")
            
            print("\n📊 Updated itheme metadata sample:")
            result = await conn.execute(text("""
                SELECT ov.value_name, tc.theme_metadata->>'button_bk_color' as button_bk, 
                       tc.theme_metadata->>'button_text_color' as button_text,
                       tc.theme_metadata->>'button_hover_color' as button_hover
                FROM theme_configs tc
                JOIN option_values ov ON tc.option_value_id = ov.id
                JOIN option_sets os ON ov.option_set_id = os.id
                WHERE os.name = 'itheme'
                ORDER BY ov.sort_order;
            """))
            rows = result.fetchall()
            print(f"\n{'Theme':<15} {'Button BG':<10} {'Button Text':<12} {'Button Hover':<12}")
            print("-" * 50)
            for row in rows:
                button_bk = row[1] or 'N/A'
                button_text = row[2] or 'N/A'
                button_hover = row[3] or 'N/A'
                print(f"{row[0]:<15} {button_bk:<10} {button_text:<12} {button_hover:<12}")
            
    except Exception as e:
        print(f"\n❌ ERROR: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
    finally:
        await engine.dispose()

if __name__ == "__main__":
    asyncio.run(run_migration())
