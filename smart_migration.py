#!/usr/bin/env python3
"""
Smart Database Migration V4 (SERIAL Fix)
Promotes columns with nextval() to SERIAL to ensure sequence creation.
"""
import psycopg2
import sys
import time
import re

OLD_DB_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"
NEW_DB_URL = "postgres://postgres:5B46Gg4BGCC5fcA2geGaddd6Bf42CaDC@turntable.proxy.rlwy.net:23759/railway"

def get_tables(cur):
    cur.execute("""
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_type = 'BASE TABLE'
        AND table_name != 'spatial_ref_sys'
        ORDER BY table_name;
    """)
    return [r[0] for r in cur.fetchall()]

def get_columns(cur, table):
    cur.execute(f"""
        SELECT column_name, data_type, is_nullable, column_default
        FROM information_schema.columns 
        WHERE table_name = '{table}'
        ORDER BY ordinal_position;
    """)
    return cur.fetchall()

def get_pk(cur, table):
    cur.execute(f"""
        SELECT kcu.column_name
        FROM information_schema.table_constraints tc
        JOIN information_schema.key_column_usage kcu 
          ON tc.constraint_name = kcu.constraint_name
          AND tc.table_schema = kcu.table_schema
        WHERE tc.constraint_type = 'PRIMARY KEY' 
          AND tc.table_name = '{table}';
    """)
    return [r[0] for r in cur.fetchall()]

def wipe_db(cur):
    print("\n🧹 Wiping New Database (Public Schema)...")
    cur.execute("DROP SCHEMA public CASCADE;")
    cur.execute("CREATE SCHEMA public;")
    cur.execute("GRANT ALL ON SCHEMA public TO postgres;")
    cur.execute("GRANT ALL ON SCHEMA public TO public;")
    print("   ✅ Wiped clean.")

def migrate():
    print("🚀 Starting Smart Migration V4...")
    
    conn_old = psycopg2.connect(OLD_DB_URL)
    conn_new = psycopg2.connect(NEW_DB_URL)
    conn_new.autocommit = True
    
    cur_old = conn_old.cursor()
    cur_new = conn_new.cursor()
    
    # 0. Wipe DB
    try:
        wipe_db(cur_new)
    except Exception as e:
        print(f"   ❌ Wipe failed: {e}")

    # 1. Enable Extensions
    print("\n📦 Enabling Extensions...")
    extensions = ["postgis", "uuid-ossp", "pgcrypto"]
    for ext in extensions:
        try:
            cur_new.execute(f"CREATE EXTENSION IF NOT EXISTS \"{ext}\"")
        except Exception as e:
            print(f"   ⚠️  Could not enable {ext}: {e}")

    # 2. Inspect Old Tables
    tables = get_tables(cur_old)
    print(f"\n📋 Found {len(tables)} tables to migrate.")
    
    # 3. Create Tables
    print("\n🔨 Creating Tables...")
    for table in tables:
        cols = get_columns(cur_old, table)
        pks = get_pk(cur_old, table)
        
        col_defs = []
        for c_name, c_type, c_null, c_def in cols:
            # Fallback for complex types
            if c_type == 'USER-DEFINED': c_type = 'TEXT'
            if c_type == 'ARRAY': c_type = 'TEXT[]'
            
            # SERIAL DETECTION LOGIC
            is_serial = False
            if c_def and 'nextval' in str(c_def):
                if c_type == 'integer':
                    c_type = 'SERIAL'
                    is_serial = True
                elif c_type == 'bigint':
                    c_type = 'BIGSERIAL'
                    is_serial = True
            
            definition = f"\"{c_name}\" {c_type}"
            
            if c_null == 'NO' and not is_serial: definition += " NOT NULL"
            
            # Default Values
            if c_def and not is_serial:
                if 'uuid_generate_v4()' in c_def: definition += " DEFAULT uuid_generate_v4()"
                elif 'gen_random_uuid()' in c_def: definition += " DEFAULT gen_random_uuid()"
                elif 'now()' in c_def: definition += " DEFAULT now()"
                elif 'false' in c_def: definition += " DEFAULT false"
                elif 'true' in c_def: definition += " DEFAULT true"
                elif '::' in c_def: 
                     val = c_def.split('::')[0]
                     definition += f" DEFAULT {val}"
                else:
                    definition += f" DEFAULT {c_def}"

            col_defs.append(definition)
            
        if pks:
            pk_str = ", ".join([f"\"{k}\"" for k in pks])
            col_defs.append(f"PRIMARY KEY ({pk_str})")
            
        create_sql = f"CREATE TABLE \"{table}\" (\n  " + ",\n  ".join(col_defs) + "\n);"
        
        try:
            cur_new.execute(create_sql)
            print(f"   ✅ Created {table}")
        except Exception as e:
            print(f"   ❌ Failed to create {table}: {e}")
            print(f"   🔍 Query: {create_sql}")

    # 4. Copy Data
    print("\n🚚 Copying Data...")
    cur_new.execute("SET session_replication_role = 'replica';")
    
    for table in tables:
        try:
            import io
            buff = io.BytesIO()
            
            cur_old.copy_expert(f"COPY \"{table}\" TO STDOUT", buff)
            buff.seek(0)
            cur_new.copy_expert(f"COPY \"{table}\" FROM STDIN", buff)
            
            print(f"   ✅ Copied {table}")
            
        except Exception as e:
            print(f"   ❌ Failed copy {table}: {e}")
            
    cur_new.execute("SET session_replication_role = 'origin';")
    
    # 5. Fix Sequences matches max id
    print("\n🔢 Fixing Sequences...")
    tables_to_fix = [
        ('option_values', 'option_values_id_seq'),
        ('option_sets', 'option_sets_id_seq'),
        ('icon_metadata', 'icon_metadata_id_seq'),
        ('theme_configs', 'theme_configs_id_seq')
    ]
    
    for tbl, seq in tables_to_fix:
        try:
            # Check if table has data first
            cur_new.execute(f"SELECT MAX(id) FROM \"{tbl}\"")
            max_id = cur_new.fetchone()[0]
            if max_id is not None:
                # Assuming standard sequence naming created by SERIAL 
                # Postgres default: tablename_colname_seq
                # But we might need to find exact name.
                # 'SERIAL' usually creates 'tablename_id_seq' if col is 'id'
                # Let's try to infer
                seq_name = f"{tbl}_id_seq" 
                cur_new.execute(f"SELECT setval('{seq_name}', {max_id});")
                print(f"   ✅ Fixed sequence for {tbl}")
        except Exception as e:
            print(f"   ⚠️ Sequence fix skipped for {tbl}: {e}")

    print("\n🎉 Migration Done.")
    conn_old.close()
    conn_new.close()

if __name__ == "__main__":
    migrate()
