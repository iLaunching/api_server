-- Migration 048: Backfill synapticExpressiveBackground rows and link activeChat FK
-- Ensures every activeChat row has a synapticExpressiveBackground and that
-- activeChat.synaptic_expressive_background_id points to it.

DO $$
BEGIN
    IF to_regclass('public."activeChat"') IS NOT NULL
       AND to_regclass('public."synapticExpressiveBackground"') IS NOT NULL
    THEN
        -- Create missing background rows for existing activeChat rows
        INSERT INTO "synapticExpressiveBackground" (user_id, active_chat_id)
        SELECT ac.user_id, ac.id
        FROM "activeChat" ac
        LEFT JOIN "synapticExpressiveBackground" bg
            ON bg.active_chat_id = ac.id
        WHERE bg.id IS NULL;

        -- Point activeChat FK at its background row
        UPDATE "activeChat" ac
        SET synaptic_expressive_background_id = bg.id
        FROM "synapticExpressiveBackground" bg
        WHERE bg.active_chat_id = ac.id
          AND (ac.synaptic_expressive_background_id IS NULL OR ac.synaptic_expressive_background_id <> bg.id);
    END IF;
END $$;

