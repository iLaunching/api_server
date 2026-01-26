#!/usr/bin/env python3
"""
Test connectivity to the new database URL (Public Hostname)
"""
import psycopg2
import sys

# Constructed from User Input + Previous Credentials
# Host: postgis-production-341c.up.railway.app
# User: postgres
# Pass: 5B46Gg4BGCC5fcA2geGaddd6Bf42CaDC
# DB: railway
# Port: 5432 (Assumed)

NEW_DB_URL = "postgres://postgres:5B46Gg4BGCC5fcA2geGaddd6Bf42CaDC@postgis-production-341c.up.railway.app:5432/railway"

def test_connection():
    print(f"Testing connection to: {NEW_DB_URL.split('@')[1]}")
    try:
        conn = psycopg2.connect(NEW_DB_URL, connect_timeout=10, sslmode='require')
        conn.close()
        print("✅ Connection SUCCESS!")
        return True
    except Exception as e:
        print(f"❌ Connection FAILED: {e}")
        return False

if __name__ == "__main__":
    if not test_connection():
        sys.exit(1)
