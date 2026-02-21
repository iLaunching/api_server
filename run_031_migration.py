"""
Run Migration 031: Add setup flag to tbl_contexts
"""
import asyncio
import asyncpg
from urllib.parse import urlparse
import os

DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgres://postgres:5B46Gg4BGCC5fcA2geGaddd6Bf42CaDC@turntable.proxy.rlwy.net:23759/railway"
)

MIGRATION_FILE = os.path.join(os.path.dirname(__file__), "migrations", "031_add_setup_flag_to_contexts.sql")


async def run_migration():
    print(f"Connecting to database...")
    parsed = urlparse(DATABASE_URL)
    conn = await asyncpg.connect(
        host=parsed.hostname,
        port=parsed.port,
        user=parsed.username,
        password=parsed.password,
        database=parsed.path.lstrip("/"),
    )
    try:
        with open(MIGRATION_FILE, "r") as f:
            sql = f.read()
        print(f"Running migration 031...")
        await conn.execute(sql)
        print("✅ Migration 031 completed successfully!")
        # Verify column exists
        row = await conn.fetchrow("""
            SELECT column_name, data_type, column_default
            FROM information_schema.columns
            WHERE table_name = 'tbl_contexts' AND column_name = 'setup';
        """)
        if row:
            print(f"✅ Column verified: {dict(row)}")
        else:
            print("❌ Column NOT found after migration!")
    finally:
        await conn.close()


if __name__ == "__main__":
    asyncio.run(run_migration())
