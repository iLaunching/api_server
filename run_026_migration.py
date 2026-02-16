import os
import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from dotenv import load_dotenv

# Add parent directory to path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

# Load .env
load_dotenv()

def get_database_url():
    """Get database URL from environment or fallback."""
    url = os.getenv("DATABASE_URL")
    if not url:
        # Fallback provided by user
        url = "postgres://postgres:5B46Gg4BGCC5fcA2geGaddd6Bf42CaDC@turntable.proxy.rlwy.net:23759/railway"
    return url

def run_migration():
    print("🚀 Running Migration 026: Optimize Chat History...")
    
    try:
        db_url = get_database_url()
        conn = psycopg2.connect(db_url)
        conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        cursor = conn.cursor()
        
        # Read SQL file
        migration_file = os.path.join(os.path.dirname(__file__), 'migrations/026_optimize_chat_history.sql')
        with open(migration_file, 'r') as f:
            sql = f.read()
            
        print("📄 Executing SQL...")
        cursor.execute(sql)
        
        print("✅ Migration 026 completed successfully!")
        
    except Exception as e:
        print(f"❌ Migration failed: {e}")
        sys.exit(1)
    finally:
        if 'conn' in locals() and conn:
            conn.close()

if __name__ == "__main__":
    run_migration()
