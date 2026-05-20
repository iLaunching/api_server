-- Migration 041: smart_hubs."activeChat" -> "activeChat"(id) (nullable FK, same pattern as hub_color_id)

DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM information_schema.tables
        WHERE table_schema = 'public' AND table_name = 'activeChat'
    ) THEN
        IF NOT EXISTS (
            SELECT 1 FROM information_schema.columns
            WHERE table_schema = 'public'
              AND table_name = 'smart_hubs'
              AND column_name = 'activeChat'
        ) THEN
            ALTER TABLE smart_hubs
                ADD COLUMN "activeChat" INTEGER
                    REFERENCES "activeChat"(id) ON DELETE SET NULL;
            COMMENT ON COLUMN smart_hubs."activeChat" IS
                'FK to activeChat.id (per-user Active Chat theme/avatar config)';
        END IF;

        IF EXISTS (
            SELECT 1 FROM information_schema.columns
            WHERE table_schema = 'public'
              AND table_name = 'smart_hubs'
              AND column_name = 'activeChat'
        ) THEN
            CREATE INDEX IF NOT EXISTS idx_smart_hubs_active_chat
                ON smart_hubs ("activeChat");

            UPDATE smart_hubs sh
            SET "activeChat" = ac.id
            FROM "activeChat" ac
            WHERE sh.owner_id = ac.user_id
              AND sh."activeChat" IS NULL;
        END IF;
    END IF;
END $$;
