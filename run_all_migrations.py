#!/usr/bin/env python3
"""
Run all migrations in order
This ensures all database schema changes are applied to production
"""
import asyncio
import asyncpg
import os
from pathlib import Path

# Production shared DB (auth + api). Override with DATABASE_URL env. Legacy tramway host is not production.
DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgresql://postgres:5B46Gg4BGCC5fcA2geGaddd6Bf42CaDC@turntable.proxy.rlwy.net:23759/railway",
)

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
    "033_add_synapse_number_to_user_profiles.sql",
    "036_move_synapse_number_to_smart_hubs.sql",
    "038_add_phone_identity_id_to_user_profiles.sql",
    "039_add_active_chat_onboarding_complete_to_user_profiles.sql",
    "040_create_active_chat_table.sql",
    "041_add_active_chat_to_smart_hubs.sql",
    "042_active_chat_per_smart_hub.sql",
    "043_drop_active_chat_avatar_columns.sql",
    "044_add_ac_current_navigation_to_user_navigation.sql",
    "045_update_sun_appearance_background_color.sql",
    "046_create_synaptic_expressive_background.sql",
    "047_add_synexp_bg_fk_to_active_chat.sql",
    "048_backfill_synexp_bg_fk_on_active_chat.sql",
    "049_add_pattern_delivery_url.sql",
    "050_create_user_media.sql",
    "051_user_media_recently_used.sql",
    "052_user_media_patterns_recently_used.sql",
    "053_rename_synaptic_background_to_synatic_experience.sql",
    "054_fix_synatic_to_synaptic_expressive_experience.sql",
    "055_add_appearance_itheme_config_to_synaptic_experience.sql",
    "056_rename_itheme_config_to_theme_config.sql",
    "057_add_experience_palette_trace_ids.sql",
    "058_wallpaper_color_catalog_and_none_kind.sql",
    "059_wallpaper_color_hex_palette_ids.sql",
    "060_user_media_catalog_object_path.sql",
    "061_user_media_wallpaper_color_recently_used.sql",
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
