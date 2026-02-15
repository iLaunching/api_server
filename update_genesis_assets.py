import os
import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from dotenv import load_dotenv
import json

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

def update_genesis_assets():
    """Update GENESIS protocol ui_assets."""
    print("🚀 Updating GENESIS protocol assets...")
    
    try:
        db_url = get_database_url()
        conn = psycopg2.connect(db_url)
        conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        cursor = conn.cursor()
        
        # JSON data to set
        assets_data = json.dumps({
            "slug": "genesis_assets",
            "card": "card_image"
        })
        
        sql = """
        UPDATE tbl_matrix_protocols
        SET ui_assets = %s
        WHERE protocol_key = 'GENESIS';
        """
        
        print(f"🔄 Executing update for GENESIS...")
        cursor.execute(sql, (assets_data,))
        
        print("✅ Update completed!")
        
        # Verify
        cursor.execute("SELECT protocol_key, ui_assets FROM tbl_matrix_protocols WHERE protocol_key = 'GENESIS'")
        row = cursor.fetchone()
        print(f"🔍 Verification: {row}")
        
    except Exception as e:
        print(f"❌ Update failed: {e}")
        sys.exit(1)
    finally:
        if 'conn' in locals() and conn:
            conn.close()

if __name__ == "__main__":
    update_genesis_assets()
