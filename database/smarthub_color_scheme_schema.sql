-- ============================================
-- SMARTHUB COLOR SCHEME CONFIGURATION SCHEMA
-- Color options for Smart Hub customization
-- ============================================

-- Insert the smarthub_color_scheme option set
INSERT INTO option_sets (name, description) VALUES 
    ('smarthub_color_scheme', 'Smart Hub color scheme configuration options')
ON CONFLICT (name) DO NOTHING;

-- ============================================
-- INSERT SMARTHUB COLOR SCHEME OPTION VALUES AND CONFIGS
-- ============================================

DO $$
DECLARE
    smarthub_color_set_id INTEGER;
    highlight_green_id INTEGER;
    mid_green_id INTEGER;
    persian_green_id INTEGER;
    charcoal_id INTEGER;
    highlight_pink_id INTEGER;
    dark_red_id INTEGER;
    blush_id INTEGER;
    cinnabar_id INTEGER;
    atomic_tangerine_id INTEGER;
    saffron_id INTEGER;
    royal_blue_id INTEGER;
    yinmn_blue_id INTEGER;
    uranian_blue_id INTEGER;
    mauve_id INTEGER;
    dark_purple_id INTEGER;
    tea_rose_id INTEGER;
    pastal_green_id INTEGER;
    forest_green_id INTEGER;
    olive_id INTEGER;
    taupe_id INTEGER;
    chestnut_id INTEGER;
    beaver_id INTEGER;
    goldenrod_id INTEGER;
    old_gold_id INTEGER;
    charcoal2_id INTEGER;
    french_grey_id INTEGER;
    lapis_lazuli_id INTEGER;
BEGIN
    -- Get the smarthub_color_scheme set ID
    SELECT id INTO smarthub_color_set_id FROM option_sets WHERE name = 'smarthub_color_scheme';
    
    -- Insert option values for Smart Hub color schemes
    INSERT INTO option_values (option_set_id, value_name, display_name, sort_order) VALUES 
        (smarthub_color_set_id, 'highlight_green', 'Highlight Green', 1),
        (smarthub_color_set_id, 'mid_green', 'Mid Green', 2),
        (smarthub_color_set_id, 'persian_green', 'Persian Green', 3),
        (smarthub_color_set_id, 'charcoal', 'Charcoal', 4),
        (smarthub_color_set_id, 'highlight_pink', 'Highlight Pink', 5),
        (smarthub_color_set_id, 'dark_red', 'Dark Red', 6),
        (smarthub_color_set_id, 'blush', 'Blush', 7),
        (smarthub_color_set_id, 'cinnabar', 'Cinnabar', 8),
        (smarthub_color_set_id, 'atomic_tangerine', 'Atomic Tangerine', 9),
        (smarthub_color_set_id, 'saffron', 'Saffron', 10),
        (smarthub_color_set_id, 'royal_blue', 'Royal Blue', 11),
        (smarthub_color_set_id, 'yinmn_blue', 'YInMn Blue', 12),
        (smarthub_color_set_id, 'uranian_blue', 'Uranian Blue', 13),
        (smarthub_color_set_id, 'mauve', 'Mauve', 14),
        (smarthub_color_set_id, 'dark_purple', 'Dark Purple', 15),
        (smarthub_color_set_id, 'tea_rose', 'Tea Rose', 16),
        (smarthub_color_set_id, 'pastal_green', 'Pastal Green', 17),
        (smarthub_color_set_id, 'forest_green', 'Forest Green', 18),
        (smarthub_color_set_id, 'olive', 'Olive', 19),
        (smarthub_color_set_id, 'taupe', 'Taupe', 20),
        (smarthub_color_set_id, 'chestnut', 'Chestnut', 21),
        (smarthub_color_set_id, 'beaver', 'Beaver', 22),
        (smarthub_color_set_id, 'goldenrod', 'Goldenrod', 23),
        (smarthub_color_set_id, 'old_gold', 'Old Gold', 24),
        (smarthub_color_set_id, 'charcoal_dark', 'Charcoal Dark', 25),
        (smarthub_color_set_id, 'french_grey', 'French Grey', 26),
        (smarthub_color_set_id, 'lapis_lazuli', 'Lapis Lazuli', 27)
    ON CONFLICT DO NOTHING;
    
    -- Get option value IDs
    SELECT id INTO highlight_green_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'highlight_green';
    SELECT id INTO mid_green_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'mid_green';
    SELECT id INTO persian_green_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'persian_green';
    SELECT id INTO charcoal_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'charcoal';
    SELECT id INTO highlight_pink_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'highlight_pink';
    SELECT id INTO dark_red_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'dark_red';
    SELECT id INTO blush_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'blush';
    SELECT id INTO cinnabar_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'cinnabar';
    SELECT id INTO atomic_tangerine_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'atomic_tangerine';
    SELECT id INTO saffron_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'saffron';
    SELECT id INTO royal_blue_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'royal_blue';
    SELECT id INTO yinmn_blue_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'yinmn_blue';
    SELECT id INTO uranian_blue_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'uranian_blue';
    SELECT id INTO mauve_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'mauve';
    SELECT id INTO dark_purple_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'dark_purple';
    SELECT id INTO tea_rose_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'tea_rose';
    SELECT id INTO pastal_green_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'pastal_green';
    SELECT id INTO forest_green_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'forest_green';
    SELECT id INTO olive_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'olive';
    SELECT id INTO taupe_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'taupe';
    SELECT id INTO chestnut_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'chestnut';
    SELECT id INTO beaver_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'beaver';
    SELECT id INTO goldenrod_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'goldenrod';
    SELECT id INTO old_gold_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'old_gold';
    SELECT id INTO charcoal2_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'charcoal_dark';
    SELECT id INTO french_grey_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'french_grey';
    SELECT id INTO lapis_lazuli_id FROM option_values WHERE option_set_id = smarthub_color_set_id AND value_name = 'lapis_lazuli';
    
    -- Insert theme configurations with color metadata
    INSERT INTO theme_configs (option_value_id, name, text_color, background_color, menu_color, border_line_color, theme_metadata) VALUES 
        (highlight_green_id, 'Highlight Green', '', '', '', '', '{"color": "#80b918"}'::jsonb),
        (mid_green_id, 'Mid Green', '', '', '', '', '{"color": "#245501"}'::jsonb),
        (persian_green_id, 'Persian Green', '', '', '', '', '{"color": "#2a9d8f"}'::jsonb),
        (charcoal_id, 'Charcoal', '', '', '', '', '{"color": "#264653"}'::jsonb),
        (highlight_pink_id, 'Highlight Pink', '', '', '', '', '{"color": "#FF4D6D"}'::jsonb),
        (dark_red_id, 'Dark Red', '', '', '', '', '{"color": "#A4133C"}'::jsonb),
        (blush_id, 'Blush', '', '', '', '', '{"color": "#DA627D"}'::jsonb),
        (cinnabar_id, 'Cinnabar', '', '', '', '', '{"color": "#D8572A"}'::jsonb),
        (atomic_tangerine_id, 'Atomic Tangerine', '', '', '', '', '{"color": "#E39774"}'::jsonb),
        (saffron_id, 'Saffron', '', '', '', '', '{"color": "#F7B538"}'::jsonb),
        (royal_blue_id, 'Royal Blue', '', '', '', '', '{"color": "#4361EE"}'::jsonb),
        (yinmn_blue_id, 'YInMn Blue', '', '', '', '', '{"color": "#274c77"}'::jsonb),
        (uranian_blue_id, 'Uranian Blue', '', '', '', '', '{"color": "#A3CEF1"}'::jsonb),
        (mauve_id, 'Mauve', '', '', '', '', '{"color": "#CAA8F5"}'::jsonb),
        (dark_purple_id, 'Dark Purple', '', '', '', '', '{"color": "#230C33"}'::jsonb),
        (tea_rose_id, 'Tea Rose', '', '', '', '', '{"color": "#DBA8AC"}'::jsonb),
        (pastal_green_id, 'Pastal Green', '', '', '', '', '{"color": "#797D62"}'::jsonb),
        (forest_green_id, 'Forest Green', '', '', '', '', '{"color": "#548c2f"}'::jsonb),
        (olive_id, 'Olive', '', '', '', '', '{"color": "#6f732f"}'::jsonb),
        (taupe_id, 'Taupe', '', '', '', '', '{"color": "#997B66"}'::jsonb),
        (chestnut_id, 'Chestnut', '', '', '', '', '{"color": "#5E3023"}'::jsonb),
        (beaver_id, 'Beaver', '', '', '', '', '{"color": "#a9927d"}'::jsonb),
        (goldenrod_id, 'Goldenrod', '', '', '', '', '{"color": "#C9A227"}'::jsonb),
        (old_gold_id, 'Old Gold', '', '', '', '', '{"color": "#C9A227"}'::jsonb),
        (charcoal2_id, 'Charcoal Dark', '', '', '', '', '{"color": "#2A2828"}'::jsonb),
        (french_grey_id, 'French Grey', '', '', '', '', '{"color": "#CED4DA"}'::jsonb),
        (lapis_lazuli_id, 'Lapis Lazuli', '', '', '', '', '{"color": "#3152BB"}'::jsonb)
    ON CONFLICT (option_value_id) DO NOTHING;
    
END $$;

-- ============================================
-- COMMENTS FOR DOCUMENTATION
-- ============================================
COMMENT ON COLUMN theme_configs.theme_metadata IS 'Smart Hub color scheme attributes: color (hex code)';
