#!/usr/bin/env python3
"""
Run all migrations in order
This ensures all database schema changes are applied to production
"""
import asyncio
import asyncpg
import os
from pathlib import Path

DATABASE_URL = "postgresql://postgres:TVzCDcmIDhjbquUUbrUMQExHEfXIwiNm@tramway.proxy.rlwy.net:12050/railway"

# List of migrations in order (add new ones to the end)
MIGRATIONS = [
    "add_appearance_itheme_relations.sql",
    "add_avatar_color_to_user_profiles.sql",
    "add_border_line_color_light.sql",
    "add_button_colors_to_theme_configs.sql",
    "add_canvas_grid_settings.sql",
    "add_global_button_hover.sql",
    "add_header_overlay_color.sql",
    "add_profile_icon_columns.sql",
    "add_profile_icon_to_user_profiles.sql",
    "add_smarthub_icon_and_avatar_display.sql",
    "add_title_menu_color_light.sql",
    "create_icon_metadata_table.sql",
    "001_create_manifest.sql",  # Manifest table
    "002_add_manifest_id_to_smart_matrices.sql",  # Bidirectional relationship
]

async def run_all_migrations():
    conn = await asyncpg.connect(DATABASE_URL)
    migrations_dir = Path(__file__).parent / "migrations"
    
    print("=" * 70)
    print("🚀 Running All Database Migrations")
    print("=" * 70)
    
    successful = 0
    skipped = 0
    failed = 0
    
    try:
        for migration_file in MIGRATIONS:
            migration_path = migrations_dir / migration_file
            
            if not migration_path.exists():
                print(f"\n⚠️  SKIP: {migration_file} (file not found)")
                skipped += 1
                continue
            
            print(f"\n📄 Running: {migration_file}")
            print("-" * 70)
            
            try:
                # Read the migration SQL
                with open(migration_path, 'r') as f:
                    migration_sql = f.read()
                
                # Execute the migration
                await conn.execute(migration_sql)
                print(f"✅ SUCCESS: {migration_file}")
                successful += 1
                
            except asyncpg.exceptions.DuplicateTableError:
                print(f"⏭️  SKIP: {migration_file} (already applied)")
                skipped += 1
            except asyncpg.exceptions.DuplicateColumnError:
                print(f"⏭️  SKIP: {migration_file} (already applied)")
                skipped += 1
            except Exception as e:
                print(f"❌ FAILED: {migration_file}")
                print(f"   Error: {e}")
                failed += 1
                # Continue with other migrations
        
        print("\n" + "=" * 70)
        print("📊 Migration Summary")
        print("=" * 70)
        print(f"✅ Successful: {successful}")
        print(f"⏭️  Skipped:    {skipped}")
        print(f"❌ Failed:     {failed}")
        print(f"📝 Total:      {len(MIGRATIONS)}")
        
        if failed == 0:
            print("\n🎉 All migrations completed successfully!")
        else:
            print(f"\n⚠️  {failed} migration(s) failed. Check errors above.")
            
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(run_all_migrations())
