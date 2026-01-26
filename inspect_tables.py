#!/usr/bin/env python3
"""
Inspect Old DB Tables
"""
import psycopg2

OLD_DB_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

def list_tables():
    conn = psycopg2.connect(OLD_DB_URL)
    cur = conn.cursor()
    
    # List public tables
    cur.execute("""
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public' 
        ORDER BY table_name;
    """)
    tables = cur.fetchall()
    
    print(f"Found {len(tables)} tables:")
    for t in tables:
        t_name = t[0]
        cur.execute(f"SELECT COUNT(*) FROM \"{t_name}\"")
        count = cur.fetchone()[0]
        print(f" - {t_name:<30} : {count} rows")
        
    conn.close()

if __name__ == "__main__":
    list_tables()
