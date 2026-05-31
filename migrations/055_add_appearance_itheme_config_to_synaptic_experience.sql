-- Migration 055: Effective appearance + iTheme JSON on synapticExpressiveExperience

DO $$
BEGIN
    IF to_regclass('public."synapticExpressiveExperience"') IS NULL THEN
        RETURN;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'synapticExpressiveExperience'
          AND column_name = 'appearance_config'
    ) THEN
        ALTER TABLE "synapticExpressiveExperience"
            ADD COLUMN appearance_config JSONB;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'synapticExpressiveExperience'
          AND column_name = 'itheme_config'
    ) THEN
        ALTER TABLE "synapticExpressiveExperience"
            ADD COLUMN itheme_config JSONB;
    END IF;

    COMMENT ON COLUMN "synapticExpressiveExperience".appearance_config IS
        'Effective appearance chrome JSON (colors, typography family_id, etc.) applied on this hub.';

    COMMENT ON COLUMN "synapticExpressiveExperience".itheme_config IS
        'Effective iTheme accent JSON (solid_color, gradients, button chrome, etc.) applied on this hub.';
END $$;

-- Backfill from activeChat appearance_option_id / itheme_option_id → theme_configs
UPDATE "synapticExpressiveExperience" exp
SET
    appearance_config = CASE
        WHEN tc_a.id IS NULL THEN exp.appearance_config
        ELSE jsonb_strip_nulls(
            jsonb_build_object(
                'name', tc_a.name,
                'text_color', tc_a.text_color,
                'background_color', tc_a.background_color,
                'menu_color', tc_a.menu_color,
                'border_line_color', tc_a.border_line_color,
                'header_overlay_color', tc_a.header_overlay_color,
                'user_button_color', tc_a.user_button_color,
                'user_button_hover', tc_a.user_button_hover,
                'user_button_icon', tc_a.user_button_icon,
                'title_menu_color_light', tc_a.title_menu_color_light,
                'border_line_color_light', tc_a.border_line_color_light,
                'global_button_hover', tc_a.global_button_hover,
                'chat_bk_1', tc_a.chat_bk_1,
                'prompt_bk', tc_a.prompt_bk,
                'prompt_text_color', tc_a.prompt_text_color,
                'ai_acknowledge_text_color', tc_a.ai_acknowledge_text_color,
                'danger_button_solid_color', tc_a.danger_button_solid_color,
                'danger_button_hover', tc_a.danger_button_hover,
                'danger_tone_bk', tc_a.danger_tone_bk,
                'danger_tone_border', tc_a.danger_tone_border,
                'danger_tone_text', tc_a.danger_tone_text,
                'danger_bk_light_color', tc_a.danger_bk_light_color,
                'danger_bk_solid_color', tc_a.danger_bk_solid_color,
                'danger_bk_solid_text_color', tc_a.danger_bk_solid_text_color,
                'line_grid_color', tc_a.line_grid_color,
                'dotted_grid_color', tc_a.dotted_grid_color,
                'source_option_value_id', ac.appearance_option_id
            )
        ) || COALESCE(tc_a.theme_metadata, '{}'::jsonb)
    END,
    itheme_config = CASE
        WHEN tc_i.id IS NULL THEN exp.itheme_config
        ELSE jsonb_strip_nulls(
            jsonb_build_object(
                'name', tc_i.name,
                'source_option_value_id', ac.itheme_option_id
            )
        ) || COALESCE(tc_i.theme_metadata, '{}'::jsonb)
    END,
    updated_at = NOW()
FROM "activeChat" ac
LEFT JOIN theme_configs tc_a ON tc_a.option_value_id = ac.appearance_option_id
LEFT JOIN theme_configs tc_i ON tc_i.option_value_id = ac.itheme_option_id
WHERE exp.active_chat_id = ac.id
  AND (exp.appearance_config IS NULL OR exp.itheme_config IS NULL);
