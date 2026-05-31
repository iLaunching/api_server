-- Migration 054: Fix spelling synaticExpressiveExperience -> synapticExpressiveExperience

DO $$
BEGIN
    IF to_regclass('public."synaticExpressiveExperience"') IS NOT NULL
       AND to_regclass('public."synapticExpressiveExperience"') IS NULL THEN
        ALTER TABLE "synaticExpressiveExperience" RENAME TO "synapticExpressiveExperience";
    END IF;

    IF to_regclass('public."synapticExpressiveExperience"') IS NULL THEN
        RETURN;
    END IF;

    IF EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'uq_synatic_expressive_experience_active_chat'
    ) THEN
        ALTER TABLE "synapticExpressiveExperience"
            RENAME CONSTRAINT uq_synatic_expressive_experience_active_chat
            TO uq_synaptic_expressive_experience_active_chat;
    END IF;

    IF EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'chk_synatic_expressive_experience_pattern_opacity'
    ) THEN
        ALTER TABLE "synapticExpressiveExperience"
            RENAME CONSTRAINT chk_synatic_expressive_experience_pattern_opacity
            TO chk_synaptic_expressive_experience_pattern_opacity;
    END IF;

    IF EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'chk_synatic_expressive_experience_dim_opacity'
    ) THEN
        ALTER TABLE "synapticExpressiveExperience"
            RENAME CONSTRAINT chk_synatic_expressive_experience_dim_opacity
            TO chk_synaptic_expressive_experience_dim_opacity;
    END IF;

    IF EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'chk_synatic_expressive_experience_pan_x'
    ) THEN
        ALTER TABLE "synapticExpressiveExperience"
            RENAME CONSTRAINT chk_synatic_expressive_experience_pan_x
            TO chk_synaptic_expressive_experience_pan_x;
    END IF;

    IF EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'chk_synatic_expressive_experience_pan_y'
    ) THEN
        ALTER TABLE "synapticExpressiveExperience"
            RENAME CONSTRAINT chk_synatic_expressive_experience_pan_y
            TO chk_synaptic_expressive_experience_pan_y;
    END IF;

    IF to_regclass('public.idx_synexp_experience_user_id') IS NOT NULL
       AND to_regclass('public.idx_synaptic_experience_user_id') IS NULL THEN
        ALTER INDEX idx_synexp_experience_user_id RENAME TO idx_synaptic_experience_user_id;
    END IF;

    IF to_regclass('public.idx_synexp_experience_active_chat_id') IS NOT NULL
       AND to_regclass('public.idx_synaptic_experience_active_chat_id') IS NULL THEN
        ALTER INDEX idx_synexp_experience_active_chat_id
            RENAME TO idx_synaptic_experience_active_chat_id;
    END IF;

    IF to_regclass('public.idx_synexp_experience_kind') IS NOT NULL
       AND to_regclass('public.idx_synaptic_experience_kind') IS NULL THEN
        ALTER INDEX idx_synexp_experience_kind RENAME TO idx_synaptic_experience_kind;
    END IF;

    IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_synexp_experience_user_photo_media') THEN
        ALTER TABLE "synapticExpressiveExperience"
            RENAME CONSTRAINT fk_synexp_experience_user_photo_media
            TO fk_synaptic_experience_user_photo_media;
    END IF;

    COMMENT ON TABLE "synapticExpressiveExperience" IS
        'Synaptic expressive experience for an Active Chat — wallpaper today; appearance/iTheme tokens later (fast single-row load).';

    IF EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'activeChat'
          AND column_name = 'synatic_expressive_experience_id'
    ) AND NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'activeChat'
          AND column_name = 'synaptic_expressive_experience_id'
    ) THEN
        ALTER TABLE "activeChat"
            RENAME COLUMN synatic_expressive_experience_id TO synaptic_expressive_experience_id;
    END IF;

    IF to_regclass('public.idx_active_chat_synexp_experience_id') IS NOT NULL
       AND to_regclass('public.idx_active_chat_synaptic_experience_id') IS NULL THEN
        ALTER INDEX idx_active_chat_synexp_experience_id
            RENAME TO idx_active_chat_synaptic_experience_id;
    END IF;

    IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_activechat_synexp_experience') THEN
        ALTER TABLE "activeChat" DROP CONSTRAINT fk_activechat_synexp_experience;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_activechat_synaptic_experience') THEN
        ALTER TABLE "activeChat"
            ADD CONSTRAINT fk_activechat_synaptic_experience
            FOREIGN KEY (synaptic_expressive_experience_id)
            REFERENCES "synapticExpressiveExperience"(id)
            ON DELETE SET NULL;
    END IF;
END $$;
