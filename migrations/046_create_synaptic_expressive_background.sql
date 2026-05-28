-- Migration 046: Synaptic expressive background settings per active chat
-- Stores wallpaper/background configuration for fast load (single row) and future editing.

DO $$
BEGIN
    IF to_regclass('public."synapticExpressiveBackground"') IS NULL THEN
        CREATE TABLE "synapticExpressiveBackground" (
            id SERIAL PRIMARY KEY,
            user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
            active_chat_id INTEGER NOT NULL REFERENCES "activeChat"(id) ON DELETE CASCADE,

            -- Which wallpaper kind is active for this chat background
            background_kind TEXT NOT NULL DEFAULT 'solid', -- solid | pattern | media_photo | user_photo

            -- Solid background fallback (#RRGGBB or #RRGGBBAA)
            solid_hex TEXT,

            -- Asset_server pattern selection (prefer ids over urls)
            pattern_category_slug TEXT,
            pattern_id TEXT,
            pattern_opacity DOUBLE PRECISION NOT NULL DEFAULT 1,
            -- Effective overlay gradient used for rendering (from asset_server or edited later)
            pattern_overlay_gradient JSONB,

            -- Media server / user photo selections (store ids/urls; actual storage is elsewhere)
            media_photo_id TEXT,
            user_photo_id UUID,

            -- Shared layout controls
            pan_x DOUBLE PRECISION NOT NULL DEFAULT 0,
            pan_y DOUBLE PRECISION NOT NULL DEFAULT 0,
            dim_opacity DOUBLE PRECISION NOT NULL DEFAULT 0,

            created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
            updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

            CONSTRAINT uq_synaptic_expressive_background_active_chat UNIQUE (active_chat_id),
            CONSTRAINT chk_synaptic_expressive_background_pattern_opacity CHECK (pattern_opacity >= 0 AND pattern_opacity <= 1),
            CONSTRAINT chk_synaptic_expressive_background_dim_opacity CHECK (dim_opacity >= 0 AND dim_opacity <= 1),
            CONSTRAINT chk_synaptic_expressive_background_pan_x CHECK (pan_x >= -1 AND pan_x <= 1),
            CONSTRAINT chk_synaptic_expressive_background_pan_y CHECK (pan_y >= -1 AND pan_y <= 1)
        );

        CREATE INDEX idx_synexp_bg_user_id ON "synapticExpressiveBackground"(user_id);
        CREATE INDEX idx_synexp_bg_active_chat_id ON "synapticExpressiveBackground"(active_chat_id);
        CREATE INDEX idx_synexp_bg_kind ON "synapticExpressiveBackground"(background_kind);

        COMMENT ON TABLE "synapticExpressiveBackground" IS 'Synaptic expressive wallpaper/background settings for an Active Chat (fast single-row load).';
        COMMENT ON COLUMN "synapticExpressiveBackground".pattern_overlay_gradient IS 'Effective overlay gradient JSON used by the client renderer (asset_server overlay or edited).';
    END IF;
END $$;

