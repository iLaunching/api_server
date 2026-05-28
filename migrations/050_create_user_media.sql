-- Migration 050: Per-user raster uploads (wallpapers, etc.) stored in ilaunching-user-media R2.

DO $$
BEGIN
    IF to_regclass('public.user_media') IS NULL THEN
        CREATE TABLE user_media (
            id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
            user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
            kind TEXT NOT NULL DEFAULT 'wallpaper',
            object_path TEXT NOT NULL,
            content_type TEXT NOT NULL DEFAULT 'image/webp',
            byte_size INTEGER NOT NULL DEFAULT 0,
            width INTEGER,
            height INTEGER,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
        );

        CREATE INDEX idx_user_media_user_id ON user_media(user_id);
        CREATE INDEX idx_user_media_kind ON user_media(kind);
        CREATE UNIQUE INDEX uq_user_media_object_path ON user_media(object_path);

        COMMENT ON TABLE user_media IS 'User-owned masters in ilaunching-user-media (R2 raw/ prefix).';
        COMMENT ON COLUMN user_media.object_path IS 'Relative path after raw/, e.g. users/{userId}/wallpapers/{id}.webp';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint
        WHERE conname = 'fk_synexp_bg_user_photo_media'
    ) THEN
        ALTER TABLE "synapticExpressiveBackground"
            ADD CONSTRAINT fk_synexp_bg_user_photo_media
            FOREIGN KEY (user_photo_id) REFERENCES user_media(id) ON DELETE SET NULL;
    END IF;
END $$;
