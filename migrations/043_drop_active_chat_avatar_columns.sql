-- Migration 043: Remove avatar/display columns from activeChat (duplicated on user_profiles)

DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM information_schema.tables
        WHERE table_schema = 'public' AND table_name = 'activeChat'
    ) THEN
        DROP INDEX IF EXISTS idx_active_chat_avatar_display_option_id;
        DROP INDEX IF EXISTS idx_active_chat_profile_icon_id;
        DROP INDEX IF EXISTS idx_active_chat_avatar_color_id;

        ALTER TABLE "activeChat"
            DROP COLUMN IF EXISTS avatar_display_option_id,
            DROP COLUMN IF EXISTS profile_icon_id,
            DROP COLUMN IF EXISTS avatar_color_id,
            DROP COLUMN IF EXISTS avatar_icon,
            DROP COLUMN IF EXISTS avatar_image;

        COMMENT ON TABLE "activeChat" IS
            'Per smart hub Active Chat theme (appearance + itheme); avatar/display on user_profiles';
    END IF;
END $$;
