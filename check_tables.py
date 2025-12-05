"""Check what tables exist in the database"""
import os
import asyncio
import asyncpg

async def check_tables():
    database_url = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"
    conn = await asyncpg.connect(database_url)
    
    try:
        result = await conn.fetch("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public'
            ORDER BY table_name
        """)
        
        print("Tables in api-server database:")
        for row in result:
            print(f"  - {row['table_name']}")
            
    finally:
        await conn.close()

asyncio.run(check_tables())
