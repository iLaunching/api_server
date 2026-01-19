-- ============================================
-- ITHEME CONFIGURATION SCHEMA
-- Gradient-based theme system with opacity controls
-- ============================================

-- Insert the iTheme option set
INSERT INTO option_sets (name, description) VALUES 
    ('itheme', 'iTheme gradient configuration options')
ON CONFLICT (name) DO NOTHING;

-- ============================================
-- INSERT ITHEME OPTION VALUES AND CONFIGS
-- ============================================

DO $$
DECLARE
    itheme_set_id INTEGER;
    ipurple_id INTEGER;
    iblue_id INTEGER;
    ipink_id INTEGER;
    iviolet_id INTEGER;
    iindigo_id INTEGER;
    iorange_id INTEGER;
    iteal_id INTEGER;
    imint_id INTEGER;
    ibronze_id INTEGER;
    iolive_id INTEGER;
    ilime_green_id INTEGER;
    itomato_id INTEGER;
    iblack_id INTEGER;
BEGIN
    -- Get the itheme set ID
    SELECT id INTO itheme_set_id FROM option_sets WHERE name = 'itheme';
    
    -- Insert option values for iTheme gradients
    INSERT INTO option_values (option_set_id, value_name, display_name, sort_order) VALUES 
        (itheme_set_id, 'ipurple', 'iLaunching Purple', 1),
        (itheme_set_id, 'iblue', 'Ocean Deep', 2),
        (itheme_set_id, 'ipink', 'Rose Quartz', 3),
        (itheme_set_id, 'iviolet', 'Regal Plum', 4),
        (itheme_set_id, 'iindigo', 'Oceanic Indigo', 5),
        (itheme_set_id, 'iorange', 'Citrus Burst', 6),
        (itheme_set_id, 'iteal', 'Aqua Dream', 7),
        (itheme_set_id, 'imint', 'Fresh Mint', 8),
        (itheme_set_id, 'ibronze', 'Copper Glow', 9),
        (itheme_set_id, 'iolive', 'Olive Grove', 10),
        (itheme_set_id, 'ilime_green', 'Electric Lime', 11),
        (itheme_set_id, 'itomato', 'Tomato Gleam', 12),
        (itheme_set_id, 'iblack', 'Onyx Shadow', 13)
    ON CONFLICT DO NOTHING;
    
    -- Get option value IDs
    SELECT id INTO ipurple_id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'ipurple';
    SELECT id INTO iblue_id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'iblue';
    SELECT id INTO ipink_id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'ipink';
    SELECT id INTO iviolet_id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'iviolet';
    SELECT id INTO iindigo_id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'iindigo';
    SELECT id INTO iorange_id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'iorange';
    SELECT id INTO iteal_id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'iteal';
    SELECT id INTO imint_id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'imint';
    SELECT id INTO ibronze_id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'ibronze';
    SELECT id INTO iolive_id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'iolive';
    SELECT id INTO ilime_green_id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'ilime_green';
    SELECT id INTO itomato_id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'itomato';
    SELECT id INTO iblack_id FROM option_values WHERE option_set_id = itheme_set_id AND value_name = 'iblack';
    
    -- Insert theme configurations with gradient metadata
    INSERT INTO theme_configs (option_value_id, name, text_color, background_color, menu_color, border_line_color, theme_metadata) VALUES 
        (ipurple_id, 'iLaunching purple', '', '', '', '', '{"bg_opacity": "#7F77F125", "bg_gradient": "linear-gradient(to bottom right, rgba(127, 119, 241, 0.8), rgba(165, 161, 248, 0.6), rgba(197, 227, 252, 0.4), rgba(255, 255, 255, 0.2))", "hover_color": "#6B63DD", "menu_bg_opacity": "#7F77F114", "solid_color": "#7F77F1", "menu_opacity_color": "#7F77F106", "toneButton_bk_color": "#7F77F166", "toneButton_text_color": "#6B63DD", "toneButton_boader_color": "#7F77F1"}'::jsonb),
        
        (iblue_id, 'Ocean Deep', '', '', '', '', '{"bg_opacity": "#0F90E025", "bg_gradient": "linear-gradient(to bottom right, rgba(15, 144, 224, 0.8), rgba(71, 180, 237, 0.6), rgba(140, 214, 245, 0.4), rgba(255, 255, 255, 0.2))", "hover_color": "#0F90E0", "menu_bg_opacity": "#0F90E014", "solid_color": "#0F90E0", "menu_opacity_color": "#0F90E006", "toneButton_bk_color": "#0F90E066", "toneButton_text_color": "#0F90E0", "toneButton_boader_color": "#0F90E0"}'::jsonb),
        
        (ipink_id, 'Rose Quartz', '', '', '', '', '{"bg_opacity": "#EE5E9925", "bg_gradient": "linear-gradient(to bottom right, rgba(238, 94, 153, 0.8), rgba(245, 140, 180, 0.6), rgba(251, 191, 212, 0.4), rgba(255, 255, 255, 0.2))", "hover_color": "#BE3E79", "menu_bg_opacity": "#EE5E9914", "solid_color": "#EE5E99", "menu_opacity_color": "#EE5E9906", "toneButton_bk_color": "#EE5E9966", "toneButton_text_color": "#BE3E79", "toneButton_boader_color": "#EE5E99"}'::jsonb),
        
        (iviolet_id, 'Regal Plum', '', '', '', '', '{"bg_opacity": "#B660E025", "bg_gradient": "linear-gradient(to bottom right, rgba(182, 96, 224, 0.8), rgba(201, 137, 232, 0.6), rgba(228, 183, 241, 0.4), rgba(255, 255, 255, 0.2))", "hover_color": "#8E40B0", "menu_bg_opacity": "#B660E014", "solid_color": "#B660E0", "menu_opacity_color": "#B660E006", "toneButton_bk_color": "#B660E066", "toneButton_text_color": "#8E40B0", "toneButton_boader_color": "#B660E0"}'::jsonb),
        
        (iindigo_id, 'Oceanic Indigo', '', '', '', '', '{"bg_opacity": "#6985FF25", "bg_gradient": "linear-gradient(to bottom right, rgba(105, 133, 255, 0.8), rgba(142, 163, 255, 0.6), rgba(196, 211, 255, 0.4), rgba(255, 255, 255, 0.2))", "hover_color": "#4763CC", "menu_bg_opacity": "#6985FF14", "solid_color": "#6985FF", "menu_opacity_color": "#6985FF06", "toneButton_bk_color": "#6985FF66", "toneButton_text_color": "#4763CC", "toneButton_boader_color": "#6985FF"}'::jsonb),
        
        (iorange_id, 'Citrus Burst', '', '', '', '', '{"bg_opacity": "#E16B1625", "bg_gradient": "linear-gradient(to bottom right, rgba(225, 107, 22, 0.8), rgba(240, 140, 71, 0.6), rgba(248, 185, 140, 0.4), rgba(255, 255, 255, 0.2))", "hover_color": "#B15300", "menu_bg_opacity": "#E16B1614", "solid_color": "#E16B16", "menu_opacity_color": "#E16B1606", "toneButton_bk_color": "#E16B1666", "toneButton_text_color": "#B15300", "toneButton_boader_color": "#E16B16"}'::jsonb),
        
        (iteal_id, 'Aqua Dream', '', '', '', '', '{"bg_opacity": "#109D9F25", "bg_gradient": "linear-gradient(to bottom right, rgba(16, 157, 159, 0.8), rgba(68, 181, 182, 0.6), rgba(136, 212, 213, 0.4), rgba(255, 255, 255, 0.2))", "hover_color": "#0C7D7F", "menu_bg_opacity": "#109D9F14", "solid_color": "#109D9F", "menu_opacity_color": "#109D9F06", "toneButton_bk_color": "#109D9F66", "toneButton_text_color": "#0C7D7F", "toneButton_boader_color": "#109D9F"}'::jsonb),
        
        (imint_id, 'Fresh Mint', '', '', '', '', '{"bg_opacity": "#3EB88B25", "bg_gradient": "linear-gradient(to bottom right, rgba(62, 184, 139, 0.8), rgba(99, 199, 163, 0.6), rgba(161, 226, 200, 0.4), rgba(255, 255, 255, 0.2))", "hover_color": "#2D8B6D", "menu_bg_opacity": "#3EB88B14", "solid_color": "#3EB88B", "menu_opacity_color": "#3EB88B06", "toneButton_bk_color": "#3EB88B66", "toneButton_text_color": "#2D8B6D", "toneButton_boader_color": "#3EB88B"}'::jsonb),
        
        (ibronze_id, 'Copper Glow', '', '', '', '', '{"bg_opacity": "#AA8D8025", "bg_gradient": "linear-gradient(to bottom right, rgba(170, 141, 128, 0.8), rgba(192, 167, 155, 0.6), rgba(216, 200, 184, 0.4), rgba(255, 255, 255, 0.2))", "hover_color": "#886B5E", "menu_bg_opacity": "#AA8D8014", "solid_color": "#AA8D80", "menu_opacity_color": "#AA8D8006", "toneButton_bk_color": "#AA8D8066", "toneButton_text_color": "#886B5E", "toneButton_boader_color": "#AA8D80"}'::jsonb),
        
        (iolive_id, 'Olive Grove', '', '', '', '', '{"bg_opacity": "#9F9F8025", "bg_gradient": "linear-gradient(to bottom right, rgba(159, 159, 128, 0.8), rgba(181, 181, 154, 0.6), rgba(211, 211, 190, 0.4), rgba(255, 255, 255, 0.2))", "hover_color": "#7F7F60", "menu_bg_opacity": "#9F9F8014", "solid_color": "#9F9F80", "menu_opacity_color": "#9F9F8006", "toneButton_bk_color": "#9F9F8066", "toneButton_text_color": "#7F7F60", "toneButton_boader_color": "#9F9F80"}'::jsonb),
        
        (ilime_green_id, 'Electric Lime', '', '', '', '', '{"bg_opacity": "#32CD3225", "bg_gradient": "linear-gradient(to bottom right, rgba(50, 205, 50, 0.8), rgba(102, 224, 102, 0.6), rgba(169, 247, 169, 0.4), rgba(255, 255, 255, 0.2))", "hover_color": "#28A745", "menu_bg_opacity": "#32CD3214", "solid_color": "#32CD32", "menu_opacity_color": "#32CD3206", "toneButton_bk_color": "#32CD3266", "toneButton_text_color": "#28A745", "toneButton_boader_color": "#32CD32"}'::jsonb),
        
        (itomato_id, 'Tomato Gleam', '', '', '', '', '{"bg_opacity": "#FF634725", "bg_gradient": "linear-gradient(to bottom right, rgba(255, 99, 71, 0.8), rgba(255, 130, 101, 0.6), rgba(255, 183, 156, 0.4), rgba(255, 255, 255, 0.2))", "hover_color": "#E03C31", "menu_bg_opacity": "#FF634714", "solid_color": "#FF6347", "menu_opacity_color": "#FF634706", "toneButton_bk_color": "#FF634766", "toneButton_text_color": "#E03C31", "toneButton_boader_color": "#FF6347"}'::jsonb),
        
        (iblack_id, 'Onyx Shadow', '', '', '', '', '{"bg_opacity": "#595C6625", "bg_gradient": "linear-gradient(to bottom right, rgba(89, 92, 102, 0.8), rgba(122, 127, 136, 0.6), rgba(161, 166, 177, 0.4), rgba(255, 255, 255, 0.2))", "hover_color": "#3F424C", "menu_bg_opacity": "#595C6614", "solid_color": "#595C66", "menu_opacity_color": "#595C6606", "toneButton_bk_color": "#595C6666", "toneButton_text_color": "#3F424C", "toneButton_boader_color": "#595C66"}'::jsonb)
    ON CONFLICT (option_value_id) DO NOTHING;
    
END $$;

-- ============================================
-- COMMENTS FOR DOCUMENTATION
-- ============================================
COMMENT ON COLUMN theme_configs.theme_metadata IS 'iTheme gradient attributes: bg_opacity, bg_gradient, hover_color, menu_bg_opacity, solid_color, menu_opacity_color, toneButton_bk_color, toneButton_text_color, toneButton_boader_color';
