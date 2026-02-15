import os
import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# Add parent directory to path to import config
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# from config.database import get_database_url
from dotenv import load_dotenv

# Load .env file
load_dotenv()

def get_database_url():
    """Get database URL from environment or fallback."""
    url = os.getenv("DATABASE_URL")
    if not url:
        # Fallback to known dev/staging URL
        url = "postgres://postgres:5B46Gg4BGCC5fcA2geGaddd6Bf42CaDC@turntable.proxy.rlwy.net:23759/railway"
    return url

def run_migration():
    """Run the migration to add UI columns to matrix protocols table."""
    print("🚀 Starting migration: 024_add_ui_cols_to_protocols")
    
    try:
        # Get database URL
        db_url = get_database_url()
        print(f"🔌 Connecting to database...")
        
        # Connect to database
        conn = psycopg2.connect(db_url)
        conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        cursor = conn.cursor()
        
        # Read migration file
        migration_file = os.path.join(os.path.dirname(__file__), 'migrations', '024_add_ui_cols_to_protocols.sql')
        with open(migration_file, 'r') as f:
            migration_sql = f.read()
            
        print("📜 Executing SQL migration...")
        print(migration_sql)
        
        # Execute migration
        cursor.execute(migration_sql)
        
        print("✅ Migration completed successfully!")
        
    except Exception as e:
        print(f"❌ Migration failed: {e}")
        sys.exit(1)
    finally:
        if 'conn' in locals() and conn:
            conn.close()

if __name__ == "__main__":
    run_migration()
