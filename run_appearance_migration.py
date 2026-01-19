"""
Run migration to add appearance_id and itheme_id to user_profiles
"""
import asyncio
import asyncpg
import sys

DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

async def run_migration():
    # Read the migration SQL file
    with open('migrations/add_appearance_itheme_relations.sql', 'r') as f:
        migration_sql = f.read()
    
    conn = await asyncpg.connect(DATABASE_URL)
    
    try:
        print("🚀 Running migration: add_appearance_itheme_relations.sql")
        print("-" * 60)
        
        # Execute the migration SQL
        await conn.execute(migration_sql)
        
        print("\n✅ Migration completed successfully!")
        print("\n📊 Verifying changes...")
        
        # Verify the changes
        sun_count = await conn.fetchval("""
            SELECT COUNT(*) FROM user_profiles WHERE appearance_id IS NOT NULL
        """)
        
        sun_theme = await conn.fetchrow("""
            SELECT ov.value_name, ov.display_name, COUNT(up.id) as user_count
            FROM option_values ov
            JOIN option_sets os ON ov.option_set_id = os.id
            LEFT JOIN user_profiles up ON up.appearance_id = ov.id
            WHERE os.name = 'appearance' AND ov.value_name = 'sun'
            GROUP BY ov.id, ov.value_name, ov.display_name
        """)
        
        if sun_theme:
            print(f"\n✅ Default appearance theme: {sun_theme['value_name']} ({sun_theme['display_name']})")
            print(f"   Users with this theme: {sun_theme['user_count']}")
        
        print(f"\n✅ Total users with appearance set: {sun_count}")
        
    except Exception as e:
        print(f"\n❌ Migration failed: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(run_migration())
