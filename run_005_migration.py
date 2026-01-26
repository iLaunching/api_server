#!/usr/bin/env python3
"""
Run Phase 3 Migration: Canvas Nodes
Creates tbl_canvas_nodes, tbl_node_connections, and tbl_node_templates
"""

import os
import sys
import psycopg2
from pathlib import Path


def run_migration():
    """Execute the 005 migration"""
    
    # Get database URL
    database_url = os.getenv('DATABASE_URL') or os.getenv('DATABASE_PUBLIC_URL')
    
    if not database_url:
        print("❌ ERROR: DATABASE_URL not found in environment")
        sys.exit(1)
    
    print(f"🔗 Connecting to database...")
    
    try:
        # Connect to database
        conn = psycopg2.connect(database_url)
        conn.autocommit = False
        cursor = conn.cursor()
        
        print("✅ Connected successfully")
        
        # Read migration file
        migration_file = Path(__file__).parent / "migrations" / "005_create_canvas_nodes.sql"
        
        if not migration_file.exists():
            print(f"❌ ERROR: Migration file not found: {migration_file}")
            sys.exit(1)
        
        print(f"📄 Reading migration file: {migration_file.name}")
        
        with open(migration_file, 'r') as f:
            sql = f.read()
        
        print("🚀 Executing migration...")
        
        # Execute migration
        cursor.execute(sql)
        
        # Commit transaction
        conn.commit()
        
        print("✅ Migration 005 executed successfully!")
        
        # Verify tables were created
        cursor.execute("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public' 
            AND table_name IN ('tbl_canvas_nodes', 'tbl_node_connections', 'tbl_node_templates')
            ORDER BY table_name;
        """)
        
        tables = cursor.fetchall()
        
        print(f"\n📊 Tables created:")
        for table in tables:
            print(f"   ✓ {table[0]}")
        
        # Count node templates
        cursor.execute("SELECT COUNT(*) FROM tbl_node_templates;")
        template_count = cursor.fetchone()[0]
        print(f"\n🎨 Node templates seeded: {template_count}")
        
        # Show template details
        cursor.execute("""
            SELECT template_name, node_type, category, shape_type 
            FROM tbl_node_templates 
            ORDER BY category, template_name;
        """)
        templates = cursor.fetchall()
        
        print("\n📦 Available node templates:")
        for name, node_type, category, shape in templates:
            print(f"   • {name} ({node_type}) - {category} - {shape}")
        
        cursor.close()
        conn.close()
        
        print("\n🎉 Phase 3 migration complete!")
        print("\nNext steps:")
        print("  1. Create SQLAlchemy models (CanvasNode, NodeConnection, NodeTemplate)")
        print("  2. Implement API endpoints for nodes and connections")
        print("  3. Add validation logic (cycle detection, port constraints)")
        
    except psycopg2.Error as e:
        print(f"\n❌ Database error: {e}")
        if conn:
            conn.rollback()
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ Unexpected error: {e}")
        if conn:
            conn.rollback()
        sys.exit(1)

if __name__ == "__main__":
    run_migration()
