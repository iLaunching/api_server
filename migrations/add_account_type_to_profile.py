"""
Migration: Add account_type_id to user_profiles
Adds foreign key to option_values for account type selection
"""
import asyncio
import asyncpg
import os

DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway")

async def migrate():
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🔄 Adding account_type_id column to user_profiles...")
        
        # Get the 'personal' option value ID from account_type option set
        personal_id = await conn.fetchval("""
            SELECT ov.id 
            FROM option_values ov
            JOIN option_sets os ON ov.option_set_id = os.id
            WHERE os.name = 'account_type' AND ov.value_name = 'personal'
        """)
        
        if not personal_id:
            raise Exception("Could not find 'personal' option value in account_type option set. Run seed_account_type.py first.")
        
        print(f"✅ Found 'personal' account type with ID: {personal_id}")
        
        # Add the column with default value
        await conn.execute(f"""
            ALTER TABLE user_profiles 
            ADD COLUMN IF NOT EXISTS account_type_id INTEGER 
            REFERENCES option_values(id) ON DELETE SET NULL
            DEFAULT {personal_id}
        """)
        
        print("✅ Added account_type_id column with default 'personal'")
        
        # Update existing NULL values to personal
        updated = await conn.execute(f"""
            UPDATE user_profiles 
            SET account_type_id = {personal_id}
            WHERE account_type_id IS NULL
        """)
        
        print(f"✅ Updated existing profiles to 'personal' account type")
        
        # Create index for performance
        await conn.execute("""
            CREATE INDEX IF NOT EXISTS idx_user_profiles_account_type_id 
            ON user_profiles(account_type_id)
        """)
        
        print("✅ Created index on account_type_id")
        print("\n🎉 Migration completed successfully!")
        
    except Exception as e:
        print(f"\n❌ Migration failed: {e}")
        raise
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(migrate())
