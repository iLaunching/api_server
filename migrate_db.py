#!/usr/bin/env python3
"""
Database Migration Script: Old DB -> New PostGIS DB
"""
import psycopg2
import subprocess
import sys
import os
import time

# OLD DB (Source)
OLD_DB_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

# NEW DB (Destination)
NEW_DB_URL = "postgres://postgres:5B46Gg4BGCC5fcA2geGaddd6Bf42CaDC@turntable.proxy.rlwy.net:23759/railway"

def migrate():
    print(f"{'='*60}")
    print("🚀 STARTED: Database Migration to PostGIS Instance")
    print(f"{'='*60}")

    # 1. Verify Connections
    print("\n1️⃣  Verifying Connections...")
    try:
        conn_new = psycopg2.connect(NEW_DB_URL, connect_timeout=10)
        conn_new.autocommit = True
        cursor_new = conn_new.cursor()
        print("✅ Connected to NEW database")
    except Exception as e:
        print(f"❌ Failed to connect to NEW database: {e}")
        return

    # 2. Enable PostGIS on New DB
    print("\n2️⃣  Enabling PostGIS on New DB...")
    try:
        cursor_new.execute("CREATE EXTENSION IF NOT EXISTS postgis;")
        print("✅ PostGIS Extension ENABLED")
        
        cursor_new.execute("SELECT PostGIS_full_version();")
        ver = cursor_new.fetchone()[0]
        print(f"   Version: {ver}")
    except Exception as e:
        print(f"❌ Failed to enable PostGIS: {e}")
        return
    finally:
        cursor_new.close()
        conn_new.close()

    # 3. Dump Old Data
    print("\n3️⃣  Dumping Data from Old DB...")
    dump_file = "old_db_dump.sql"
    env_old = os.environ.copy()
    # pg_dump usually parses connection string properly
    
    # We use --data-only for certain tables or full dump? 
    # Valid approach: Full dump, but we might have conflicts with extensions or existing schemas.
    # RECOMMENDATION: Schema + Data. BUT New DB is empty, so we just dump everything.
    # EXCLUDE 'postgis' extension from dump to avoid errors if versions differ, 
    # but old DB didn't have it, so safe.
    
    cmd_dump = f"pg_dump '{OLD_DB_URL}' --no-owner --no-acl --clean --if-exists -f {dump_file}"
    
    try:
        subprocess.check_call(cmd_dump, shell=True)
        size = os.path.getsize(dump_file) / (1024 * 1024)
        print(f"✅ Dump Successful ({size:.2f} MB)")
    except subprocess.CalledProcessError as e:
        print(f"❌ Dump Failed: {e}")
        return

    # 4. Restore to New DB
    print("\n4️⃣  Restoring Data to New DB...")
    # usage of psql to restore
    cmd_restore = f"psql '{NEW_DB_URL}' -f {dump_file}"
    
    try:
        subprocess.check_call(cmd_restore, shell=True)
        print("✅ Restore Successful")
    except subprocess.CalledProcessError as e:
        print(f"❌ Restore Failed: {e}")
        return

    # 5. Verify Row Counts (Simple Check)
    print("\n5️⃣  Verifying Data Integrity...")
    try:
        conn_old = psycopg2.connect(OLD_DB_URL)
        cur_old = conn_old.cursor()
        cur_old.execute("SELECT COUNT(*) FROM users;") 
        # Assuming 'users' table exists, or try smart_matrices
        old_count = cur_old.fetchone()[0]
        conn_old.close()

        conn_new = psycopg2.connect(NEW_DB_URL)
        cur_new = conn_new.cursor()
        cur_new.execute("SELECT COUNT(*) FROM users;")
        new_count = cur_new.fetchone()[0]
        conn_new.close()

        if old_count == new_count:
            print(f"✅ Row Count Match (Users: {old_count})")
        else:
            print(f"⚠️  Row Count MISMATCH: Old={old_count}, New={new_count}")

    except Exception as e:
        print(f"⚠️  Verification warning (table might not exist yet?): {e}")

    # Cleanup
    if os.path.exists(dump_file):
        os.remove(dump_file)
        print("\n🗑️  Cleanup: Dump file removed")

    print(f"\n{'='*60}")
    print("🎉 MIGRATION COMPLETE")
    print(f"{'='*60}")

if __name__ == "__main__":
    migrate()
