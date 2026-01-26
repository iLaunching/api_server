#!/usr/bin/env python3
"""
Diagnostic Script: Check if PostGIS is available on the server
"""
import psycopg2
import sys

# User provided URL
DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

def check_extensions():
    print(f"Connecting to database: {DATABASE_URL.split('@')[1]}") # Log host only for sanity
    try:
        conn = psycopg2.connect(DATABASE_URL)
        conn.autocommit = True
        cursor = conn.cursor()
        print("✅ Connected successfully")
    except Exception as e:
        print(f"❌ Connection failed: {e}")
        sys.exit(1)

    print("\n--- Attempting to Enable PostGIS ---")
    try:
        cursor.execute("CREATE EXTENSION IF NOT EXISTS postgis;")
        print("✅ SUCCESS: PostGIS extension enabled!")
        
        cursor.execute("SELECT PostGIS_full_version();")
        version = cursor.fetchone()[0]
        print(f"📡 PostGIS Version: {version}")
        return
    except Exception as e:
        print(f"❌ FAILURE: Could not enable postgis.\nError: {e}")

    print("\n--- Diagnostic: Available Extensions ---")
    print("Checking what extensions ARE installed on the server filesystem...")
    try:
        cursor.execute("SELECT name, default_version, installed_version, comment FROM pg_available_extensions WHERE name LIKE '%gis%' OR name LIKE '%geo%';")
        rows = cursor.fetchall()
        
        if not rows:
            print("⚠️  NO extensions found matching 'gis' or 'geo'.")
            print("This confirms PostGIS binaries are NOT present on this PostgreSQL instance.")
        else:
            print(f"Found {len(rows)} related extensions:")
            for row in rows:
                print(f" - {row[0]} (v{row[1]}) - Installed: {row[2] or 'No'}")
    except Exception as e:
        print(f"❌ Error querying available extensions: {e}")

    cursor.close()
    conn.close()

if __name__ == "__main__":
    check_extensions()
