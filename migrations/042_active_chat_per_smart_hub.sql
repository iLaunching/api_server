-- Migration 042: activeChat is one row per smart hub (via smart_hubs."activeChat"), not one per user.

DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM information_schema.tables
        WHERE table_schema = 'public' AND table_name = 'activeChat'
    ) THEN
        ALTER TABLE "activeChat" DROP CONSTRAINT IF EXISTS "activeChat_user_id_key";

        COMMENT ON TABLE "activeChat" IS
            'Per smart hub Active Chat theme (appearance + itheme; linked from smart_hubs.activeChat)';
    END IF;

    IF EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'smart_hubs'
          AND column_name = 'activeChat'
    ) THEN
        COMMENT ON COLUMN smart_hubs."activeChat" IS
            'FK to activeChat.id (this hub''s Active Chat theme config)';
    END IF;
END $$;
