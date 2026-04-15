"""
Run Migration 033: Add synapse_number and country_code to user_profiles
"""

import asyncio
import asyncpg
import os
from pathlib import Path

from dotenv import load_dotenv

# Resolve .env next to this script (works regardless of cwd)
_api_root = Path(__file__).resolve().parent
load_dotenv(_api_root / ".env")
load_dotenv()  # cwd fallback

MIGRATION_FILE = Path(__file__).parent / "migrations" / "033_add_synapse_number_to_user_profiles.sql"


async def run_migration():
    database_url = os.getenv("DATABASE_URL")

    if not database_url:
        print("❌ DATABASE_URL not found.")
        print(f"   Set it in {_api_root / '.env'} (recommended) or export DATABASE_URL, then re-run:")
        print("   python3 run_033_migration.py")
        return False

    try:
        conn = await asyncpg.connect(database_url)
        print("✅ Connected to database")

        migration_sql = MIGRATION_FILE.read_text(encoding="utf-8")
        print("📄 Executing migration 033...")

        await conn.execute(migration_sql)

        print("✅ Migration 033 completed successfully!")
        print("   - Added synapse_number (VARCHAR(20)) to user_profiles")
        print("   - Added country_code (VARCHAR(5)) to user_profiles")
        print("   - Created unique index idx_synapse_number on user_profiles(synapse_number)")

        await conn.close()
        return True

    except Exception as e:
        print(f"❌ Migration failed: {str(e)}")
        return False


if __name__ == "__main__":
    success = asyncio.run(run_migration())
    exit(0 if success else 1)
