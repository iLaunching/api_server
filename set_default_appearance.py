#!/usr/bin/env python3
"""
Set default appearance_id for all user profiles
Sets appearance to 'sun' (the default appearance theme)
"""
import asyncio
import asyncpg

DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def set_default_appearance():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🚀 Setting default appearance for user profiles\n")
        
        # Get the 'sun' appearance option_value ID
        sun_id = await conn.fetchval("""
            SELECT ov.id 
            FROM option_values ov
            JOIN option_sets os ON ov.option_set_id = os.id
            WHERE os.name = 'appearance' AND ov.value_name = 'sun'
        """)
        
        if not sun_id:
            print("❌ Error: 'sun' appearance not found. Run seed_appearance.py first.")
            return
        
        print(f"✅ Found 'sun' appearance with ID: {sun_id}")
        
        # Check how many users have NULL appearance_id
        null_count = await conn.fetchval("""
            SELECT COUNT(*) FROM user_profiles WHERE appearance_id IS NULL
        """)
        print(f"📊 Users with NULL appearance_id: {null_count}")
        
        # Update all NULL appearance_id to 'sun'
        if null_count > 0:
            result = await conn.execute("""
                UPDATE user_profiles 
                SET appearance_id = $1
                WHERE appearance_id IS NULL
            """, sun_id)
            print(f"✅ Updated {null_count} user profiles to 'sun' appearance")
        else:
            print("✅ All users already have appearance set")
        
        # Set default for future users
        print("\n📝 Setting database default...")
        await conn.execute("""
            ALTER TABLE user_profiles 
            ALTER COLUMN appearance_id SET DEFAULT $1
        """, sun_id)
        print(f"✅ Set default appearance_id to {sun_id} (sun)")
        
        # Verify
        total = await conn.fetchval("SELECT COUNT(*) FROM user_profiles")
        with_appearance = await conn.fetchval("""
            SELECT COUNT(*) FROM user_profiles WHERE appearance_id IS NOT NULL
        """)
        print(f"\n✅ Verification: {with_appearance}/{total} users have appearance set")
        
    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(set_default_appearance())
