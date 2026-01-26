#!/usr/bin/env python3
"""
Migration runner for Phase 2 (Context Layer)
"""
import psycopg2
import sys
import os
from pathlib import Path

# Use the same connection string as the existing scripts or fallback to env
# Note: In a real scenario we should prefer ENV, but I'll use the one found in run_migrations.py for consistency 
# checking if it works.
# However, best practice is os.getenv
DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway")

def run_sql_file(cursor, filepath):
    """Execute SQL file"""
    print(f"\n{'='*60}")
    print(f"Executing: {filepath.name}")
    print(f"{'='*60}")
    
    if not filepath.exists():
        print(f"❌ File not found: {filepath}")
        return False
        
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
    print("Connecting to database...")
    try:
        conn = psycopg2.connect(DATABASE_URL)
        conn.autocommit = True
        cursor = conn.cursor()
        print("✅ Connected to database\n")
    except Exception as e:
        print(f"❌ Failed to connect: {e}")
        # Try to install psycopg2 if missing? 
        # But we assume the environment has it since other scripts use it.
        sys.exit(1)
    
    # Define migrations to run
    base_path = Path("/root/projects/Ilaunching-SERVERS/api-server/migrations")
    migrations = [
        base_path / "002_create_contexts.sql",
        base_path / "003_dna_handshake_trigger.sql"
    ]
    
    success_count = 0
    for migration in migrations:
        if run_sql_file(cursor, migration):
            success_count += 1
    
    print(f"\n{'='*60}")
    print(f"Migration Summary: {success_count}/{len(migrations)} successful")
    print(f"{'='*60}\n")
    
    cursor.close()
    conn.close()

if __name__ == "__main__":
    main()
