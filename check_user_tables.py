"""Check users vs user_profiles tables"""
import asyncio
import asyncpg

async def check_schemas():
    database_url = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"
    conn = await asyncpg.connect(database_url)
    
    try:
        print("=" * 60)
        print("USERS TABLE:")
        print("=" * 60)
        result = await conn.fetch("""
            SELECT column_name, data_type, is_nullable
            FROM information_schema.columns 
            WHERE table_name = 'users'
            ORDER BY ordinal_position
        """)
        for row in result:
            print(f"  {row['column_name']:<30} {row['data_type']:<20} nullable={row['is_nullable']}")
        
        print("\n" + "=" * 60)
        print("USER_PROFILES TABLE:")
        print("=" * 60)
        result = await conn.fetch("""
            SELECT column_name, data_type, is_nullable
            FROM information_schema.columns 
            WHERE table_name = 'user_profiles'
            ORDER BY ordinal_position
        """)
        for row in result:
            print(f"  {row['column_name']:<30} {row['data_type']:<20} nullable={row['is_nullable']}")
            
        print("\n" + "=" * 60)
        print("Checking relationship:")
        print("=" * 60)
        result = await conn.fetch("""
            SELECT COUNT(*) as user_count FROM users
        """)
        print(f"Users count: {result[0]['user_count']}")
        
        result = await conn.fetch("""
            SELECT COUNT(*) as profile_count FROM user_profiles
        """)
        print(f"User profiles count: {result[0]['profile_count']}")
        
    finally:
        await conn.close()

asyncio.run(check_schemas())
