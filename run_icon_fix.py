"""
Run the icon name fix script on the database
"""
import asyncio
import os
import sys
from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy import text

async def run_fix():
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
            print("\n📊 BEFORE FIX - Sample icon names:")
            result = await conn.execute(text("""
                SELECT icon_name, icon_prefix, COUNT(*) as count
                FROM icon_metadata
                WHERE icon_name LIKE 'fa%'
                GROUP BY icon_name, icon_prefix
                ORDER BY icon_name
                LIMIT 10;
            """))
            rows = result.fetchall()
            for row in rows:
                print(f"   {row[0]:30} ({row[1]}) - {row[2]} entries")
            
            print("\n🔧 Fixing icons with 'fa-' prefix...")
            result = await conn.execute(text("""
                UPDATE icon_metadata
                SET icon_name = SUBSTRING(icon_name FROM 4)
                WHERE icon_name LIKE 'fa-%';
            """))
            fa_dash_count = result.rowcount
            print(f"   ✅ Updated {fa_dash_count} icons")
            
            print("\n🔧 Fixing numeric icons (fa0, fa1, etc.)...")
            result = await conn.execute(text("""
                UPDATE icon_metadata 
                SET icon_name = SUBSTRING(icon_name FROM 3)
                WHERE icon_name ~ '^fa[0-9]+$';
            """))
            numeric_count = result.rowcount
            print(f"   ✅ Updated {numeric_count} icons")
            
            print("\n📊 AFTER FIX - Sample icon names:")
            result = await conn.execute(text("""
                SELECT icon_name, icon_prefix, COUNT(*) as count
                FROM icon_metadata
                GROUP BY icon_name, icon_prefix
                ORDER BY icon_name
                LIMIT 20;
            """))
            rows = result.fetchall()
            for row in rows:
                print(f"   {row[0]:30} ({row[1]}) - {row[2]} entries")
            
            print(f"\n✅ SUCCESS! Fixed {fa_dash_count + numeric_count} icon names total")
            print("Icons should now display correctly in the IconPicker")
            
    except Exception as e:
        print(f"\n❌ ERROR: {e}")
        sys.exit(1)
    finally:
        await engine.dispose()

if __name__ == "__main__":
    asyncio.run(run_fix())
