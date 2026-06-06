-- Wallpaper color catalog fields + default background_kind = none

ALTER TABLE "synapticExpressiveExperience"
  ADD COLUMN IF NOT EXISTS wallpaper_color_palette_id TEXT,
  ADD COLUMN IF NOT EXISTS background_config JSONB;

UPDATE "synapticExpressiveExperience"
SET background_kind = 'none'
WHERE background_kind = 'solid'
  AND solid_hex IS NULL
  AND wallpaper_color_palette_id IS NULL
  AND background_config IS NULL
  AND pattern_category_slug IS NULL
  AND pattern_id IS NULL
  AND media_photo_id IS NULL
  AND user_photo_id IS NULL;

ALTER TABLE "synapticExpressiveExperience"
  ALTER COLUMN background_kind SET DEFAULT 'none';
