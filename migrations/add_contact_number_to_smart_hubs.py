"""
Migration: Add contact_number column to smart_hubs table.

Matches sizing/semantics of user_profiles.phone (VARCHAR(20), nullable).
"""

import asyncio
import os

import asyncpg


async def add_contact_number_column():
  database_url = os.getenv("DATABASE_URL")
  if not database_url:
    raise RuntimeError(
      "DATABASE_URL environment variable must be set to run this migration "
      "(e.g. postgres://user:pass@host:port/dbname)."
    )

  conn = await asyncpg.connect(database_url)

  try:
    print("🔄 Adding contact_number column to smart_hubs table...")

    # Step 1: Add the contact_number column (nullable, VARCHAR(20))
    await conn.execute(
      """
      ALTER TABLE smart_hubs
      ADD COLUMN IF NOT EXISTS contact_number VARCHAR(20);
      """
    )
    print("  ✓ Added contact_number column (VARCHAR(20), nullable)")

    # Optional: document column meaning
    await conn.execute(
      """
      COMMENT ON COLUMN smart_hubs.contact_number IS
      'Optional hub-level contact phone number (same sizing as user_profiles.phone)';
      """
    )
    print("  ✓ Added comment for contact_number")

    print("\n✅ Migration completed successfully!")
  except Exception as e:
    print(f"\n❌ Error during migration: {e}")
    raise
  finally:
    await conn.close()


if __name__ == "__main__":
  asyncio.run(add_contact_number_column())

