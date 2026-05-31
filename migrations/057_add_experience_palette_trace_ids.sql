-- Migration 057: Palette trace IDs on synapticExpressiveExperience

DO $$
BEGIN
    IF to_regclass('public."synapticExpressiveExperience"') IS NULL THEN
        RETURN;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'synapticExpressiveExperience'
          AND column_name = 'appearance_palette_id'
    ) THEN
        ALTER TABLE "synapticExpressiveExperience"
            ADD COLUMN appearance_palette_id TEXT;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'synapticExpressiveExperience'
          AND column_name = 'theme_palette_id'
    ) THEN
        ALTER TABLE "synapticExpressiveExperience"
            ADD COLUMN theme_palette_id TEXT;
    END IF;

    COMMENT ON COLUMN "synapticExpressiveExperience".appearance_palette_id IS
        'Catalog reference (asset_server appearance palette id), e.g. sun — effective JSON is appearance_config.';

    COMMENT ON COLUMN "synapticExpressiveExperience".theme_palette_id IS
        'Catalog reference (asset_server theme palette id), e.g. ipurple — effective JSON is theme_config.';
END $$;

-- Backfill trace ids from legacy activeChat option_values (value_name slugs match asset catalog ids)
UPDATE "synapticExpressiveExperience" exp
SET
    appearance_palette_id = COALESCE(exp.appearance_palette_id, ov_a.value_name),
    theme_palette_id = COALESCE(exp.theme_palette_id, ov_t.value_name),
    updated_at = NOW()
FROM "activeChat" ac
LEFT JOIN option_values ov_a ON ov_a.id = ac.appearance_option_id
LEFT JOIN option_values ov_t ON ov_t.id = ac.itheme_option_id
WHERE exp.active_chat_id = ac.id
  AND (exp.appearance_palette_id IS NULL OR exp.theme_palette_id IS NULL);
