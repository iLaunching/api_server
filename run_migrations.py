#!/usr/bin/env python3
"""
Migration script to execute SQL files on Railway database
"""
import psycopg2
import sys
from pathlib import Path

# Database connection string from .env.example
DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

def run_sql_file(cursor, filepath):
    """Execute SQL file"""
    print(f"\n{'='*60}")
    print(f"Executing: {filepath.name}")
    print(f"{'='*60}")
    
    with open(filepath, 'r') as f:
        sql = f.read()
    
    try:
        cursor.execute(sql)
        print(f"✅ Successfully executed {filepath.name}")
        return True
    except Exception as e:
        print(f"❌ Error executing {filepath.name}: {e}")
        return False

def main():
    # Connect to database
    print("Connecting to Railway database...")
    try:
        conn = psycopg2.connect(DATABASE_URL)
        conn.autocommit = True
        cursor = conn.cursor()
        print("✅ Connected to database\n")
    except Exception as e:
        print(f"❌ Failed to connect: {e}")
        sys.exit(1)
    
    # Execute migrations in order
    migrations = [
        Path("/workspaces/Ilaunching-SERVERS/api-server/migrations/add_profile_icon_to_user_profiles.sql"),
        Path("/workspaces/Ilaunching-SERVERS/api-server/database/seed_icons.sql")
    ]
    
    success_count = 0
    for migration in migrations:
        if migration.exists():
            if run_sql_file(cursor, migration):
                success_count += 1
        else:
            print(f"⚠️  Migration file not found: {migration}")
    
    # Summary
    print(f"\n{'='*60}")
    print(f"Migration Summary: {success_count}/{len(migrations)} successful")
    print(f"{'='*60}\n")
    
    # Verify icon count
    cursor.execute("""
        SELECT COUNT(*) FROM option_values ov
        JOIN option_sets os ON ov.option_set_id = os.id
        WHERE os.set_name = 'icon_library'
    """)
    count = cursor.fetchone()[0]
    print(f"✅ Icon library contains {count} icons")
    
    cursor.close()
    conn.close()

if __name__ == "__main__":
    main()
