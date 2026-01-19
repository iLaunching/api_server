import asyncio
import asyncpg

async def check():
    conn = await asyncpg.connect("postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway")
    
    query = """
    SELECT column_name, data_type, is_nullable
    FROM information_schema.columns
    WHERE table_name = 'users'
    ORDER BY ordinal_position;
    """
    cols = await conn.fetch(query)
    print("📋 users table columns:")
    for row in cols:
        print(f"  - {row['column_name']}: {row['data_type']} (nullable: {row['is_nullable']})")
    
    await conn.close()

asyncio.run(check())
