#!/usr/bin/env python3
"""
Inspect Column Types
"""
import psycopg2
import sys

OLD_DB_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

def inspect_table(table_name):
    conn = psycopg2.connect(OLD_DB_URL)
    cur = conn.cursor()
    
    cur.execute(f"""
        SELECT column_name, data_type, is_nullable, column_default
        FROM information_schema.columns 
        WHERE table_name = '{table_name}'
        ORDER BY ordinal_position;
    """)
    cols = cur.fetchall()
    
    print(f"Table: {table_name}")
    for c in cols:
        print(f" - {c[0]:<25} {c[1]:<20} Null:{c[2]:<5} Def:{str(c[3])[:20]}")
        
    conn.close()

if __name__ == "__main__":
    inspect_table("users")
    print("-" * 40)
    inspect_table("smart_matrices")
inspect_table('smart_hubs')
