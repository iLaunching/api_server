-- Recently-used solid color wallpapers on user_media.
ALTER TABLE user_media ADD COLUMN IF NOT EXISTS wallpaper_color_palette_id TEXT;
ALTER TABLE user_media ADD COLUMN IF NOT EXISTS solid_hex TEXT;
ALTER TABLE user_media ADD COLUMN IF NOT EXISTS background_config JSONB;

CREATE UNIQUE INDEX IF NOT EXISTS uq_user_media_user_wallpaper_color
    ON user_media(user_id, wallpaper_color_palette_id, solid_hex)
    WHERE kind = 'wallpaper_color'
      AND wallpaper_color_palette_id IS NOT NULL
      AND solid_hex IS NOT NULL;
