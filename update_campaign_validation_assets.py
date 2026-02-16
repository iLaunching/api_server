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

def update_assets():
    """Update CAMPAIGN and VALIDATION protocol ui_assets."""
    print("🚀 Updating protocol assets...")
    
    try:
        db_url = get_database_url()
        conn = psycopg2.connect(db_url)
        conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        cursor = conn.cursor()
        
        # Campaign Assets
        campaign_assets = json.dumps({
            "slug": "campaign_assets",
            "card": "card_image"
        })
        
        # Validation Assets
        validation_assets = json.dumps({
            "slug": "validation_assets",
            "card": "card_image"
        })
        
        print(f"🔄 Updating CAMPAIGN...")
        cursor.execute("""
            UPDATE tbl_matrix_protocols
            SET ui_assets = %s
            WHERE protocol_key = 'CAMPAIGN';
        """, (campaign_assets,))
        
        print(f"🔄 Updating VALIDATION...")
        cursor.execute("""
            UPDATE tbl_matrix_protocols
            SET ui_assets = %s
            WHERE protocol_key = 'VALIDATION';
        """, (validation_assets,))
        
        print("✅ Updates completed!")
        
        # Verify
        print("\n🔍 Verification:")
        cursor.execute("SELECT protocol_key, ui_assets FROM tbl_matrix_protocols WHERE protocol_key IN ('CAMPAIGN', 'VALIDATION') ORDER BY protocol_key")
        rows = cursor.fetchall()
        for row in rows:
            print(f"  {row[0]}: {row[1]}")
        
    except Exception as e:
        print(f"❌ Update failed: {e}")
        sys.exit(1)
    finally:
        if 'conn' in locals() and conn:
            conn.close()

if __name__ == "__main__":
    update_assets()
