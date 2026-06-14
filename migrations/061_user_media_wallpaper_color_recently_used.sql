-- Migration 061: Recently-used solid color wallpapers on user_media.

DO $$
BEGIN
    IF to_regclass('public.user_media') IS NOT NULL THEN
        ALTER TABLE user_media ADD COLUMN IF NOT EXISTS wallpaper_color_palette_id TEXT;
        ALTER TABLE user_media ADD COLUMN IF NOT EXISTS solid_hex TEXT;
        ALTER TABLE user_media ADD COLUMN IF NOT EXISTS background_config JSONB;

        COMMENT ON COLUMN user_media.wallpaper_color_palette_id IS 'Designed palette id when kind=wallpaper_color.';
        COMMENT ON COLUMN user_media.solid_hex IS 'Applied fill hex when kind=wallpaper_color.';
        COMMENT ON COLUMN user_media.background_config IS 'Render snapshot from synapticExpressiveExperience when kind=wallpaper_color.';

        CREATE UNIQUE INDEX IF NOT EXISTS uq_user_media_user_wallpaper_color
            ON user_media(user_id, wallpaper_color_palette_id, solid_hex)
            WHERE kind = 'wallpaper_color'
              AND wallpaper_color_palette_id IS NOT NULL
              AND solid_hex IS NOT NULL;
    END IF;
END $$;
