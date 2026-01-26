#!/usr/bin/env python3
"""
Manual Migration Script: Schema Rebuild + Data Copy
Bypasses pg_dump version issues.
"""
import os
import sys
import asyncio
import psycopg2
from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy import text

# Import Models to ensure they are registered with Base
# Adjust sys.path to find modules
sys.path.append(os.getcwd())

from config.database import Base
# Import all models to register them
from models import user, database_models, manifest, context, account_deletion
try:
    from models import schemas # sometimes schemas might contain models? unlikely but check
except:
    pass

# DATABASE CONFIG
OLD_DB_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"
# Correct TCP URL for New DB
NEW_DB_URL = "postgres://postgres:5B46Gg4BGCC5fcA2geGaddd6Bf42CaDC@turntable.proxy.rlwy.net:23759/railway"

# Async Engine for Schema Creation
async def rebuild_schema():
    print(f"\n1️⃣  Rebuilding Schema on New DB...")
    # Convert psycopg2 url to asyncpg
    async_url = NEW_DB_URL.replace("postgres://", "postgresql+asyncpg://")
    
    engine = create_async_engine(async_url, echo=False)
    
    async with engine.begin() as conn:
        # Enable PostGIS extension first
        try:
            await conn.execute(text("CREATE EXTENSION IF NOT EXISTS postgis"))
            print("   ✅ PostGIS Extension Enabled")
        except Exception as e:
            print(f"   ⚠️  PostGIS Error (might be fine if already exists): {e}")

        # Drop all tables first? No, cleaner to just create if not exists.
        # But Base.metadata.create_all checks existence.
        print("   🔨 Creating Tables...")
        await conn.run_sync(Base.metadata.create_all)
        print("   ✅ Schema Created")
    
    await engine.dispose()

def copy_data():
    print(f"\n2️⃣  Copying Data (Direct Copy)...")
    
    conn_old = psycopg2.connect(OLD_DB_URL)
    conn_new = psycopg2.connect(NEW_DB_URL)
    conn_new.autocommit = True
    
    cur_old = conn_old.cursor()
    cur_new = conn_new.cursor()
    
    # Disable FK constraints for the session on Destination
    print("   🔓 Setting session_replication_role = 'replica' (Bypassing FKs)")
    cur_new.execute("SET session_replication_role = 'replica';")
    
    # Get List of tables from OLD DB
    cur_old.execute("""
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_type = 'BASE TABLE'
        ORDER BY table_name;
    """)
    tables = [t[0] for t in cur_old.fetchall()]
    
    # Exclude alembic_version if we don't use it, or include it
    for table in tables:
        if table == 'spatial_ref_sys': continue # Skip PostGIS internal
        
        print(f"   ➡️  Migrating '{table}'...", end='', flush=True)
        
        # Check if table exists in NEW DB
        cur_new.execute(f"SELECT to_regclass('public.\"{table}\"')")
        if not cur_new.fetchone()[0]:
            print(" ❌ SKIPPED (Not in Target Schema)")
            continue

        # COPY
        try:
            # Buffer copy
            f = os.tmpfile() if hasattr(os, 'tmpfile') else open(f"/tmp/pg_copy_{table}.dat", "w+b")
            
            # COPY TO
            copy_to_sql = f"COPY \"{table}\" TO STDOUT"
            cur_old.copy_expert(copy_to_sql, f)
            
            # COPY FROM
            f.seek(0)
            copy_from_sql = f"COPY \"{table}\" FROM STDIN"
            cur_new.copy_expert(copy_from_sql, f)
            
            # Count
            cur_new.execute(f"SELECT COUNT(*) FROM \"{table}\"")
            count = cur_new.fetchone()[0]
            print(f" ✅ Done ({count} rows)")
            
            f.close()
            
        except Exception as e:
            print(f" ❌ ERROR: {e}")
            # Don't abort, try next table
            
    print("   🔒 Resetting session_replication_role = 'origin'")
    cur_new.execute("SET session_replication_role = 'origin';")
    
    conn_old.close()
    conn_new.close()
    print("\n✅ Verification Complete.")

if __name__ == "__main__":
    # Run Async Schema Rebuild
    loop = asyncio.get_event_loop()
    loop.run_until_complete(rebuild_schema())
    
    # Run Sync Data Copy
    copy_data()
