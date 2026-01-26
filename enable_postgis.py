#!/usr/bin/env python3
"""
Script to enable PostGIS extension
"""
import psycopg2
import sys

# Using the URL from PRODUCTION SERVERS.md which matches run_migrations.py
DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

def enable_postgis():
    print("Connecting to database...")
    try:
        conn = psycopg2.connect(DATABASE_URL)
        conn.autocommit = True
        cursor = conn.cursor()
        print("✅ Connected to database")
    except Exception as e:
        print(f"❌ Failed to connect: {e}")
        sys.exit(1)
        
    print("\nEnabling PostGIS extension...")
    try:
        cursor.execute("CREATE EXTENSION IF NOT EXISTS postgis;")
        print("✅ Command executed: CREATE EXTENSION IF NOT EXISTS postgis;")
    except Exception as e:
        print(f"❌ Failed to enable PostGIS: {e}")
        print("This usually means the PostGIS binary is not installed on the server.")
        sys.exit(1)
        
    print("\nVerifying installation...")
    try:
        cursor.execute("SELECT PostGIS_full_version();")
        version = cursor.fetchone()[0]
        print(f"✅ PostGIS Version: {version}")
    except Exception as e:
        print(f"❌ Failed to verify PostGIS: {e}")
        sys.exit(1)
        
    cursor.close()
    conn.close()

if __name__ == "__main__":
    enable_postgis()
