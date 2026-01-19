"""
Set default itheme to ipurple for all users
"""
import asyncio
import asyncpg

DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def set_default_itheme():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🎨 Setting default itheme to ipurple...")
        print("-" * 60)
        
        # Get itheme option set ID
        itheme_set_id = await conn.fetchval("""
            SELECT id FROM option_sets WHERE name = 'itheme'
        """)
        
        if not itheme_set_id:
            print("❌ itheme option set not found")
            return
        
        # Get ipurple option value ID
        ipurple_id = await conn.fetchval("""
            SELECT id FROM option_values 
            WHERE option_set_id = $1 AND value_name = 'ipurple'
        """, itheme_set_id)
        
        if not ipurple_id:
            print("❌ ipurple theme not found in option_values")
            return
        
        print(f"✅ Found ipurple theme (ID: {ipurple_id})")
        
        # Update all users without itheme_id to use ipurple
        result = await conn.execute("""
            UPDATE user_profiles 
            SET itheme_id = $1 
            WHERE itheme_id IS NULL
        """, ipurple_id)
        
        # Extract the count from the result status
        updated_count = int(result.split()[-1]) if result else 0
        
        print(f"✅ Set default itheme to ipurple for {updated_count} users")
        
        # Verify
        total_with_itheme = await conn.fetchval("""
            SELECT COUNT(*) FROM user_profiles WHERE itheme_id = $1
        """, ipurple_id)
        
        print(f"✅ Total users with ipurple theme: {total_with_itheme}")
        
    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(set_default_itheme())
