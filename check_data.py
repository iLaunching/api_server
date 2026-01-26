#!/usr/bin/env python3
"""
Verify Data Existence
"""
import psycopg2
import sys

# New DB URL
NEW_DB_URL = "postgres://postgres:5B46Gg4BGCC5fcA2geGaddd6Bf42CaDC@turntable.proxy.rlwy.net:23759/railway"

def check_data():
    print("Connecting to New DB...")
    try:
        conn = psycopg2.connect(NEW_DB_URL)
        cur = conn.cursor()
    except Exception as e:
        print(f"❌ Connection Failed: {e}")
        return

    # Get tables
    cur.execute("""
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_type = 'BASE TABLE'
        ORDER BY table_name;
    """)
    tables = cur.fetchall()
    
    print(f"\n📊 Found {len(tables)} Tables. Analyzing Row Counts:\n")
    print(f"{'TABLE NAME':<30} | {'ROWS':<10}")
    print("-" * 45)
    
    total_rows = 0
    for t in tables:
        name = t[0]
        cur.execute(f"SELECT COUNT(*) FROM \"{name}\"")
        count = cur.fetchone()[0]
        print(f"{name:<30} | {count:<10}")
        total_rows += count
        
    print("-" * 45)
    print(f"TOTAL ROWS: {total_rows}")
    
    if total_rows > 0:
        print("\n✅ CONCLUSION: Data is definitely present in the database.")
    else:
        print("\n❌ CONCLUSION: Database appears empty.")
        
    conn.close()

if __name__ == "__main__":
    check_data()
