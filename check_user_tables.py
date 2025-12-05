import asyncio
import asyncpg

async def check_tables():
    conn = await asyncpg.connect("postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway")
    
    # Check what user-related tables exist
    query = """
    SELECT table_name 
    FROM information_schema.tables 
    WHERE table_schema = 'public' 
    AND table_name LIKE '%user%'
    ORDER BY table_name;
    """
    tables = await conn.fetch(query)
    print("📋 User-related tables:")
    for row in tables:
        print(f"  - {row['table_name']}")
    
    # Check user_navigation table structure
    query2 = """
    SELECT column_name, data_type, is_nullable
    FROM information_schema.columns
    WHERE table_name = 'user_navigation'
    ORDER BY ordinal_position;
    """
    cols = await conn.fetch(query2)
    print("\n📋 user_navigation columns:")
    for row in cols:
        print(f"  - {row['column_name']}: {row['data_type']} (nullable: {row['is_nullable']})")
    
    await conn.close()

asyncio.run(check_tables())
