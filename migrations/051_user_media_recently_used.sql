-- Migration 051: Recently-used wallpaper metadata on user_media.

DO $$
BEGIN
    IF to_regclass('public.user_media') IS NOT NULL THEN
        ALTER TABLE user_media ADD COLUMN IF NOT EXISTS title TEXT;
        ALTER TABLE user_media ADD COLUMN IF NOT EXISTS source_kind TEXT NOT NULL DEFAULT 'upload';
        ALTER TABLE user_media ADD COLUMN IF NOT EXISTS source_catalog_photo_id TEXT;
        ALTER TABLE user_media ADD COLUMN IF NOT EXISTS source_collection_slug TEXT;
        ALTER TABLE user_media ADD COLUMN IF NOT EXISTS last_used_at TIMESTAMP WITH TIME ZONE;

        COMMENT ON COLUMN user_media.source_kind IS 'upload | catalog | library';
        COMMENT ON COLUMN user_media.last_used_at IS 'Set when wallpaper is applied; drives Recently used ordering.';

        CREATE INDEX IF NOT EXISTS idx_user_media_user_last_used
            ON user_media(user_id, last_used_at DESC NULLS LAST);

        CREATE UNIQUE INDEX IF NOT EXISTS uq_user_media_user_catalog_source
            ON user_media(user_id, source_catalog_photo_id)
            WHERE source_catalog_photo_id IS NOT NULL;
    END IF;
END $$;
