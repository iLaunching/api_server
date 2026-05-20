-- Migration 040: Create activeChat table (per smart hub theme: appearance + itheme only)

DO $$
BEGIN
    IF to_regclass('public."activeChat"') IS NULL THEN
        CREATE TABLE "activeChat" (
            id SERIAL PRIMARY KEY,
            user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
            appearance_option_id INTEGER REFERENCES option_values(id) ON DELETE SET NULL DEFAULT 6,
            itheme_option_id INTEGER REFERENCES option_values(id) ON DELETE SET NULL DEFAULT 10,
            created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
        );

        CREATE INDEX idx_active_chat_user_id ON "activeChat"(user_id);
        CREATE INDEX idx_active_chat_appearance_option_id ON "activeChat"(appearance_option_id);
        CREATE INDEX idx_active_chat_itheme_option_id ON "activeChat"(itheme_option_id);

        COMMENT ON TABLE "activeChat" IS 'Per smart hub Active Chat theme (appearance + itheme); avatar on user_profiles';
        COMMENT ON COLUMN "activeChat".appearance_option_id IS 'FK to option_values (appearance: sun, moon, etc.)';
        COMMENT ON COLUMN "activeChat".itheme_option_id IS 'FK to option_values (itheme: ipurple, iblue, etc.)';
    END IF;
END $$;
