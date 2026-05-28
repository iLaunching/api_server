-- Migration 047: Add optional 1:1 FK from activeChat -> synapticExpressiveBackground
-- This creates a direct pointer for fast retrieval from ActiveChat, while keeping the
-- background table as the source of truth (still keyed by active_chat_id UNIQUE).

DO $$
BEGIN
    IF to_regclass('public."activeChat"') IS NOT NULL
       AND to_regclass('public."synapticExpressiveBackground"') IS NOT NULL
    THEN
        -- Add column if missing
        IF NOT EXISTS (
            SELECT 1
            FROM information_schema.columns
            WHERE table_schema = 'public'
              AND table_name = 'activeChat'
              AND column_name = 'synaptic_expressive_background_id'
        ) THEN
            ALTER TABLE "activeChat"
                ADD COLUMN synaptic_expressive_background_id INTEGER;
        END IF;

        -- Enforce 1:1 (nullable)
        CREATE UNIQUE INDEX IF NOT EXISTS idx_active_chat_synexp_bg_id
            ON "activeChat"(synaptic_expressive_background_id);

        -- Add FK constraint if missing
        IF NOT EXISTS (
            SELECT 1
            FROM pg_constraint
            WHERE conname = 'fk_activechat_synexp_bg'
        ) THEN
            ALTER TABLE "activeChat"
                ADD CONSTRAINT fk_activechat_synexp_bg
                FOREIGN KEY (synaptic_expressive_background_id)
                REFERENCES "synapticExpressiveBackground"(id)
                ON DELETE SET NULL;
        END IF;
    END IF;
END $$;

