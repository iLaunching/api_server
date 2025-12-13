-- Add button color configuration to itheme option set
-- Adds button_bk_color, button_text_color, and button_hover_color to theme_metadata

DO $$
DECLARE
    itheme_set_id INTEGER;
BEGIN
    -- Get the itheme set ID
    SELECT id INTO itheme_set_id FROM option_sets WHERE name = 'itheme';
    
    -- Update ipurple
    UPDATE theme_configs tc
    SET theme_metadata = theme_metadata || 
        '{"button_bk_color": "#7F77F1", "button_text_color": "#ffffff", "button_hover_color": "#6B63DD"}'::jsonb
    WHERE option_value_id = (
        SELECT id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'ipurple'
    );
    
    -- Update iblue
    UPDATE theme_configs tc
    SET theme_metadata = theme_metadata || 
        '{"button_bk_color": "#0F90E0", "button_text_color": "#ffffff", "button_hover_color": "#0F90E0"}'::jsonb
    WHERE option_value_id = (
        SELECT id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'iblue'
    );
    
    -- Update ipink
    UPDATE theme_configs tc
    SET theme_metadata = theme_metadata || 
        '{"button_bk_color": "#EE5E99", "button_text_color": "#ffffff", "button_hover_color": "#BE3E79"}'::jsonb
    WHERE option_value_id = (
        SELECT id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'ipink'
    );
    
    -- Update iviolet
    UPDATE theme_configs tc
    SET theme_metadata = theme_metadata || 
        '{"button_bk_color": "#B660E0", "button_text_color": "#ffffff", "button_hover_color": "#8E40B0"}'::jsonb
    WHERE option_value_id = (
        SELECT id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'iviolet'
    );
    
    -- Update iindigo
    UPDATE theme_configs tc
    SET theme_metadata = theme_metadata || 
        '{"button_bk_color": "#6985FF", "button_text_color": "#ffffff", "button_hover_color": "#4763CC"}'::jsonb
    WHERE option_value_id = (
        SELECT id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'iindigo'
    );
    
    -- Update iorange
    UPDATE theme_configs tc
    SET theme_metadata = theme_metadata || 
        '{"button_bk_color": "#E16B16", "button_text_color": "#ffffff", "button_hover_color": "#B15300"}'::jsonb
    WHERE option_value_id = (
        SELECT id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'iorange'
    );
    
    -- Update iteal
    UPDATE theme_configs tc
    SET theme_metadata = theme_metadata || 
        '{"button_bk_color": "#109D9F", "button_text_color": "#ffffff", "button_hover_color": "#0C7D7F"}'::jsonb
    WHERE option_value_id = (
        SELECT id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'iteal'
    );
    
    -- Update imint
    UPDATE theme_configs tc
    SET theme_metadata = theme_metadata || 
        '{"button_bk_color": "#3EB88B", "button_text_color": "#ffffff", "button_hover_color": "#2D8B6D"}'::jsonb
    WHERE option_value_id = (
        SELECT id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'imint'
    );
    
    -- Update ibronze
    UPDATE theme_configs tc
    SET theme_metadata = theme_metadata || 
        '{"button_bk_color": "#AA8D80", "button_text_color": "#ffffff", "button_hover_color": "#886B5E"}'::jsonb
    WHERE option_value_id = (
        SELECT id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'ibronze'
    );
    
    -- Update iolive
    UPDATE theme_configs tc
    SET theme_metadata = theme_metadata || 
        '{"button_bk_color": "#9F9F80", "button_text_color": "#ffffff", "button_hover_color": "#7F7F60"}'::jsonb
    WHERE option_value_id = (
        SELECT id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'iolive'
    );
    
    -- Update ilime_green
    UPDATE theme_configs tc
    SET theme_metadata = theme_metadata || 
        '{"button_bk_color": "#32CD32", "button_text_color": "#ffffff", "button_hover_color": "#28A745"}'::jsonb
    WHERE option_value_id = (
        SELECT id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'ilime_green'
    );
    
    -- Update itomato
    UPDATE theme_configs tc
    SET theme_metadata = theme_metadata || 
        '{"button_bk_color": "#FF6347", "button_text_color": "#ffffff", "button_hover_color": "#E03C31"}'::jsonb
    WHERE option_value_id = (
        SELECT id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'itomato'
    );
    
    -- Update iblack
    UPDATE theme_configs tc
    SET theme_metadata = theme_metadata || 
        '{"button_bk_color": "#595C66", "button_text_color": "#ffffff", "button_hover_color": "#3F424C"}'::jsonb
    WHERE option_value_id = (
        SELECT id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'iblack'
    );
    
    RAISE NOTICE 'Successfully added button color configuration to all itheme options';
END $$;

-- Update documentation comment
COMMENT ON COLUMN theme_configs.theme_metadata IS 'iTheme gradient attributes: bg_opacity, bg_gradient, hover_color, menu_bg_opacity, solid_color, menu_opacity_color, toneButton_bk_color, toneButton_text_color, toneButton_boader_color, button_bk_color, button_text_color, button_hover_color';
