import os
import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from dotenv import load_dotenv

# Add parent directory to path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# Load .env
load_dotenv()

def get_database_url():
    """Get database URL from environment or fallback."""
    url = os.getenv("DATABASE_URL")
    if not url:
        # Fallback to known dev/staging URL
        url = "postgres://postgres:5B46Gg4BGCC5fcA2geGaddd6Bf42CaDC@turntable.proxy.rlwy.net:23759/railway"
    return url

def revert_migration():
    """Drop UI columns from matrix protocols table."""
    print("🚀 Reverting migration: Dropping UI columns")
    
    try:
        db_url = get_database_url()
        conn = psycopg2.connect(db_url)
        conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        cursor = conn.cursor()
        
        sql = """
        ALTER TABLE tbl_matrix_protocols 
        DROP COLUMN IF EXISTS ui_theme,
        DROP COLUMN IF EXISTS ui_assets;
        """
        
        print(f"🔄 Executing SQL revert...")
        cursor.execute(sql)
        
        print("✅ Columns dropped successfully!")
        
    except Exception as e:
        print(f"❌ Revert failed: {e}")
        sys.exit(1)
    finally:
        if 'conn' in locals() and conn:
            conn.close()

if __name__ == "__main__":
    revert_migration()
