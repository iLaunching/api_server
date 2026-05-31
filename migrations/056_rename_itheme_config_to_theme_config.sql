-- Migration 056: Rename itheme_config -> theme_config on synapticExpressiveExperience

DO $$
BEGIN
    IF to_regclass('public."synapticExpressiveExperience"') IS NULL THEN
        RETURN;
    END IF;

    IF EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'synapticExpressiveExperience'
          AND column_name = 'itheme_config'
    ) AND NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'synapticExpressiveExperience'
          AND column_name = 'theme_config'
    ) THEN
        ALTER TABLE "synapticExpressiveExperience"
            RENAME COLUMN itheme_config TO theme_config;
    END IF;

    COMMENT ON COLUMN "synapticExpressiveExperience".theme_config IS
        'Effective theme accent JSON (solid_color, gradients, button chrome, etc.) applied on this hub.';

    COMMENT ON TABLE "synapticExpressiveExperience" IS
        'Synaptic expressive experience for an Active Chat — wallpaper, appearance_config, and theme_config (fast single-row load).';
END $$;
