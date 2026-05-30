-- Migration 052: Recently-used SVG patterns on user_media (R2 copy + overlay snapshot).

DO $$
BEGIN
    IF to_regclass('public.user_media') IS NOT NULL THEN
        ALTER TABLE user_media ADD COLUMN IF NOT EXISTS pattern_category_slug TEXT;
        ALTER TABLE user_media ADD COLUMN IF NOT EXISTS pattern_id TEXT;
        ALTER TABLE user_media ADD COLUMN IF NOT EXISTS pattern_delivery_url TEXT;
        ALTER TABLE user_media ADD COLUMN IF NOT EXISTS pattern_opacity DOUBLE PRECISION;
        ALTER TABLE user_media ADD COLUMN IF NOT EXISTS pattern_overlay_gradient JSONB;

        COMMENT ON COLUMN user_media.pattern_category_slug IS 'Asset_server category slug when kind=pattern.';
        COMMENT ON COLUMN user_media.pattern_id IS 'Asset_server pattern id when kind=pattern.';
        COMMENT ON COLUMN user_media.pattern_delivery_url IS 'Canonical Asset_server CDN URL for preview/reload.';
        COMMENT ON COLUMN user_media.pattern_opacity IS 'Effective pattern tile opacity (0–1) when kind=pattern.';
        COMMENT ON COLUMN user_media.pattern_overlay_gradient IS 'Effective overlay gradient JSON when kind=pattern.';

        CREATE UNIQUE INDEX IF NOT EXISTS uq_user_media_user_pattern_source
            ON user_media(user_id, pattern_category_slug, pattern_id)
            WHERE kind = 'pattern'
              AND pattern_category_slug IS NOT NULL
              AND pattern_id IS NOT NULL;
    END IF;
END $$;
