-- Migration 045: Sun appearance theme background_color → #F8F9FA
-- option_sets.appearance → option_values.value_name = 'sun' → theme_configs.background_color

DO $$
DECLARE
    appearance_set_id INTEGER;
    sun_value_id INTEGER;
    updated_count INTEGER;
BEGIN
    SELECT id INTO appearance_set_id FROM option_sets WHERE name = 'appearance';

    IF appearance_set_id IS NULL THEN
        RAISE EXCEPTION 'Appearance option set not found';
    END IF;

    SELECT id INTO sun_value_id
    FROM option_values
    WHERE option_set_id = appearance_set_id
      AND value_name = 'sun';

    IF sun_value_id IS NULL THEN
        RAISE EXCEPTION 'Sun appearance option value not found';
    END IF;

    UPDATE theme_configs
    SET background_color = '#F8F9FA'
    WHERE option_value_id = sun_value_id;

    GET DIAGNOSTICS updated_count = ROW_COUNT;
    RAISE NOTICE 'Updated sun appearance background_color to #F8F9FA (% row(s))', updated_count;
END $$;
