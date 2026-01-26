#!/usr/bin/env python3
"""
Verify Phase 2 Implementation on New DB (Corrected)
"""
import psycopg2
import uuid
import json

NEW_DB_URL = "postgres://postgres:5B46Gg4BGCC5fcA2geGaddd6Bf42CaDC@turntable.proxy.rlwy.net:23759/railway"

def verify():
    print("🚀 Verifying Phase 2 on New DB...")
    
    try:
        conn = psycopg2.connect(NEW_DB_URL)
        conn.autocommit = True
        cur = conn.cursor()
        print("✅ Connected to New DB")
    except Exception as e:
        print(f"❌ Connection Failed: {e}")
        return

    # 1. Check Table Existence
    try:
        cur.execute("SELECT to_regclass('public.tbl_contexts');")
        if cur.fetchone()[0]:
            print("✅ tbl_contexts exists")
        else:
            print("❌ tbl_contexts MISSING")
            return
    except Exception as e:
        print(f"❌ Table check failed: {e}")
        return

    # 2. Test Trigger & PostGIS
    try:
        # Create Dummy Data for FK Hierarchy
        cur.execute("SELECT id FROM users LIMIT 1")
        real_user_id = cur.fetchone()[0]
        
        hub_id = str(uuid.uuid4())
        # Corrected columns: owner_id, name
        cur.execute(f"INSERT INTO smart_hubs (id, owner_id, name) VALUES ('{hub_id}', '{real_user_id}', 'Test Hub')")
        
        matrix_id = str(uuid.uuid4())
        # Corrected columns: owner_id, smart_hub_id, name, order_number
        cur.execute(f"INSERT INTO smart_matrices (id, smart_hub_id, owner_id, name, order_number) VALUES ('{matrix_id}', '{hub_id}', '{real_user_id}', 'Test Matrix', 0)")
        
        manifest_id = str(uuid.uuid4())
        dna = json.dumps({"intent": "PHASE 2 SUCCESS"})
        cur.execute(f"""
            INSERT INTO tbl_manifest (manifest_id, smart_matrix_id, user_id, business_dna) 
            VALUES ('{manifest_id}', '{matrix_id}', '{real_user_id}', '{dna}')
        """)
        print("✅ Created Test Manifest with DNA")
        
        # Create Context
        context_id = str(uuid.uuid4())
        poly = "POLYGON((0 0, 10 0, 10 10, 0 10, 0 0))"
        
        cur.execute(f"""
            INSERT INTO tbl_contexts (context_id, manifest_id, context_name, context_type, boundary_polygon)
            VALUES ('{context_id}', '{manifest_id}', 'Test Context', 'TEST', ST_GeomFromText('{poly}', 0))
        """)
        print("✅ Created Test Context with PostGIS Polygon")
        
        # Verify Inheritance
        cur.execute(f"SELECT inherited_intent FROM tbl_contexts WHERE context_id = '{context_id}'")
        intent = cur.fetchone()[0]
        
        if intent == "PHASE 2 SUCCESS":
            print(f"✅ DNA Handshake Trigger WORKED: '{intent}'")
        else:
            print(f"❌ Trigger FAILED. Got: '{intent}'")
            
        # Verify Geometry
        cur.execute(f"SELECT ST_AsText(boundary_polygon) FROM tbl_contexts WHERE context_id = '{context_id}'")
        wkt = cur.fetchone()[0]
        print(f"✅ PostGIS WKT Verified: {wkt}")

        # Cleanup
        cur.execute(f"DELETE FROM tbl_manifest WHERE manifest_id = '{manifest_id}'")
        cur.execute(f"DELETE FROM smart_matrices WHERE id = '{matrix_id}'")
        cur.execute(f"DELETE FROM smart_hubs WHERE id = '{hub_id}'")
        print("✅ Cleanup Complete")

    except Exception as e:
        print(f"❌ Verification Logic Failed: {e}")

    conn.close()

if __name__ == "__main__":
    verify()
