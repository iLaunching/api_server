-- Migration 053: Rename synapticExpressiveBackground -> synaticExpressiveExperience
-- Aligns DB naming with per-hub expressive experience (wallpaper + future appearance/iTheme).

DO $$
BEGIN
    IF to_regclass('public."synapticExpressiveBackground"') IS NOT NULL
       AND to_regclass('public."synaticExpressiveExperience"') IS NULL THEN
        ALTER TABLE "synapticExpressiveBackground" RENAME TO "synaticExpressiveExperience";
    END IF;

    IF to_regclass('public."synaticExpressiveExperience"') IS NULL THEN
        RETURN;
    END IF;

    -- Table constraints (046)
    IF EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'uq_synaptic_expressive_background_active_chat'
    ) THEN
        ALTER TABLE "synaticExpressiveExperience"
            RENAME CONSTRAINT uq_synaptic_expressive_background_active_chat
            TO uq_synatic_expressive_experience_active_chat;
    END IF;

    IF EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'chk_synaptic_expressive_background_pattern_opacity'
    ) THEN
        ALTER TABLE "synaticExpressiveExperience"
            RENAME CONSTRAINT chk_synaptic_expressive_background_pattern_opacity
            TO chk_synatic_expressive_experience_pattern_opacity;
    END IF;

    IF EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'chk_synaptic_expressive_background_dim_opacity'
    ) THEN
        ALTER TABLE "synaticExpressiveExperience"
            RENAME CONSTRAINT chk_synaptic_expressive_background_dim_opacity
            TO chk_synatic_expressive_experience_dim_opacity;
    END IF;

    IF EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'chk_synaptic_expressive_background_pan_x'
    ) THEN
        ALTER TABLE "synaticExpressiveExperience"
            RENAME CONSTRAINT chk_synaptic_expressive_background_pan_x
            TO chk_synatic_expressive_experience_pan_x;
    END IF;

    IF EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'chk_synaptic_expressive_background_pan_y'
    ) THEN
        ALTER TABLE "synaticExpressiveExperience"
            RENAME CONSTRAINT chk_synaptic_expressive_background_pan_y
            TO chk_synatic_expressive_experience_pan_y;
    END IF;

    -- Table indexes
    IF to_regclass('public.idx_synexp_bg_user_id') IS NOT NULL
       AND to_regclass('public.idx_synexp_experience_user_id') IS NULL THEN
        ALTER INDEX idx_synexp_bg_user_id RENAME TO idx_synexp_experience_user_id;
    END IF;

    IF to_regclass('public.idx_synexp_bg_active_chat_id') IS NOT NULL
       AND to_regclass('public.idx_synexp_experience_active_chat_id') IS NULL THEN
        ALTER INDEX idx_synexp_bg_active_chat_id RENAME TO idx_synexp_experience_active_chat_id;
    END IF;

    IF to_regclass('public.idx_synexp_bg_kind') IS NOT NULL
       AND to_regclass('public.idx_synexp_experience_kind') IS NULL THEN
        ALTER INDEX idx_synexp_bg_kind RENAME TO idx_synexp_experience_kind;
    END IF;

    -- user_photo FK (050)
    IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_synexp_bg_user_photo_media') THEN
        ALTER TABLE "synaticExpressiveExperience"
            RENAME CONSTRAINT fk_synexp_bg_user_photo_media
            TO fk_synexp_experience_user_photo_media;
    END IF;

    COMMENT ON TABLE "synaticExpressiveExperience" IS
        'Synatic expressive experience for an Active Chat — wallpaper today; appearance/iTheme tokens later (fast single-row load).';

    -- activeChat FK column + constraint (047)
    IF EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'activeChat'
          AND column_name = 'synaptic_expressive_background_id'
    ) AND NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'activeChat'
          AND column_name = 'synatic_expressive_experience_id'
    ) THEN
        ALTER TABLE "activeChat"
            RENAME COLUMN synaptic_expressive_background_id TO synatic_expressive_experience_id;
    END IF;

    IF to_regclass('public.idx_active_chat_synexp_bg_id') IS NOT NULL
       AND to_regclass('public.idx_active_chat_synexp_experience_id') IS NULL THEN
        ALTER INDEX idx_active_chat_synexp_bg_id RENAME TO idx_active_chat_synexp_experience_id;
    END IF;

    IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_activechat_synexp_bg') THEN
        ALTER TABLE "activeChat" DROP CONSTRAINT fk_activechat_synexp_bg;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_activechat_synexp_experience') THEN
        ALTER TABLE "activeChat"
            ADD CONSTRAINT fk_activechat_synexp_experience
            FOREIGN KEY (synatic_expressive_experience_id)
            REFERENCES "synaticExpressiveExperience"(id)
            ON DELETE SET NULL;
    END IF;
END $$;
