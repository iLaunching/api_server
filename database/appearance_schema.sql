-- ============================================
-- APPEARANCE CONFIGURATION SCHEMA
-- Option Sets for Theme Management
-- ============================================

-- Create the option sets table
CREATE TABLE IF NOT EXISTS option_sets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create the option values table
CREATE TABLE IF NOT EXISTS option_values (
    id SERIAL PRIMARY KEY,
    option_set_id INTEGER NOT NULL REFERENCES option_sets(id) ON DELETE CASCADE,
    value_name VARCHAR(100) NOT NULL,
    display_name VARCHAR(200),
    sort_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create the theme configs table
CREATE TABLE IF NOT EXISTS theme_configs (
    id SERIAL PRIMARY KEY,
    option_value_id INTEGER NOT NULL UNIQUE REFERENCES option_values(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    text_color VARCHAR(7) NOT NULL,
    background_color VARCHAR(7) NOT NULL,
    menu_color VARCHAR(7) NOT NULL,
    border_line_color VARCHAR(7) NOT NULL,
    header_overlay_color VARCHAR(9),
    user_button_color VARCHAR(9),
    user_button_hover VARCHAR(9),
    user_button_icon VARCHAR(7),
    title_menu_color_light VARCHAR(7),
    border_line_color_light VARCHAR(9),
    danger_button_solid_color VARCHAR(9),
    danger_button_hover VARCHAR(9),
    danger_tone_bk VARCHAR(9),
    danger_tone_border VARCHAR(9),
    danger_tone_text VARCHAR(9),
    danger_bk_light_color VARCHAR(9),
    danger_bk_solid_color VARCHAR(9),
    danger_bk_solid_text_color VARCHAR(7),
    theme_metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================
CREATE INDEX IF NOT EXISTS idx_option_sets_name ON option_sets(name);
CREATE INDEX IF NOT EXISTS idx_option_values_set_id ON option_values(option_set_id);
CREATE INDEX IF NOT EXISTS idx_option_values_active ON option_values(is_active) WHERE is_active = TRUE;
CREATE INDEX IF NOT EXISTS idx_theme_configs_option_value ON theme_configs(option_value_id);

-- ============================================
-- INSERT APPEARANCE OPTION SET AND VALUES
-- ============================================

-- Insert the Appearance option set
INSERT INTO option_sets (name, description) VALUES 
    ('appearance', 'User interface appearance themes')
ON CONFLICT (name) DO NOTHING;

-- Get the appearance option set ID for reference
DO $$
DECLARE
    appearance_set_id INTEGER;
    sun_value_id INTEGER;
    moon_value_id INTEGER;
    space_value_id INTEGER;
    star_value_id INTEGER;
BEGIN
    -- Get the appearance set ID
    SELECT id INTO appearance_set_id FROM option_sets WHERE name = 'appearance';
    
    -- Insert option values for appearance themes
    INSERT INTO option_values (option_set_id, value_name, display_name, sort_order) VALUES 
        (appearance_set_id, 'sun', 'Sun Theme', 1),
        (appearance_set_id, 'moon', 'Moon Theme', 2),
        (appearance_set_id, 'space', 'Space Theme', 3),
        (appearance_set_id, 'star', 'Star Theme', 4)
    ON CONFLICT DO NOTHING;
    
    -- Get the option value IDs
    SELECT id INTO sun_value_id FROM option_values WHERE option_set_id = appearance_set_id AND value_name = 'sun';
    SELECT id INTO moon_value_id FROM option_values WHERE option_set_id = appearance_set_id AND value_name = 'moon';
    SELECT id INTO space_value_id FROM option_values WHERE option_set_id = appearance_set_id AND value_name = 'space';
    SELECT id INTO star_value_id FROM option_values WHERE option_set_id = appearance_set_id AND value_name = 'star';
    
    -- Insert theme configurations with final hardcoded colors and button colors
    INSERT INTO theme_configs (option_value_id, name, text_color, background_color, menu_color, border_line_color, header_overlay_color, user_button_color, user_button_hover, user_button_icon, title_menu_color_light, border_line_color_light, global_button_hover, danger_button_solid_color, danger_button_hover, danger_tone_bk, danger_tone_border, danger_tone_text, danger_bk_light_color, danger_bk_solid_color, danger_bk_solid_text_color) VALUES 
        (sun_value_id, 'Sun', '#000000', '#FFFFFF', '#FFFFFF', '#d6d6d6', '#00000080', '#ffffff59', '#ffffff66', '#000000', '#d6d6d6', '#d6d6d659', '#d6d6d64d', '#C62A2FFF', '#C62A2F26', '#C62A2F26', '#C62A2F61', '#C62A2FFF', '#C62A2F26', '#C62A2FFF', '#ffffff'),
        (moon_value_id, 'Moon', '#d6d6d6', '#2F2F2F', '#464545', '#62676F', '#00000000', '#ffffff59', '#ffffff66', '#000000', '#62676F', '#62676F59', '#d6d6d64d', '#C62A2FFF', '#C62A2F26', '#C62A2F26', '#C62A2F61', '#C62A2FFF', '#C62A2F26', '#C62A2FFF', '#ffffff'),
        (space_value_id, 'Space', '#ffffff', '#2A2E35', '#3A3F47', '#62676F', '#00000000', '#505663', '#505663cc', '#ffffff', '#62676F', '#62676F59', '#d6d6d64d', '#C62A2FFF', '#C62A2F26', '#C62A2F26', '#C62A2F61', '#C62A2FFF', '#C62A2F26', '#C62A2FFF', '#ffffff'),
        (star_value_id, 'Star', '#ffffff', '#181B34', '#292F4C', '#616daa', '#00000000', '#181B34', '#181B34cc', '#ffffff', '#616daa', '#616daa59', '#d6d6d64d', '#C62A2FFF', '#C62A2F26', '#C62A2F26', '#C62A2F61', '#C62A2FFF', '#C62A2F26', '#C62A2FFF', '#ffffff')
    ON CONFLICT (option_value_id) DO NOTHING;
    
END $$;

-- ============================================
-- FUNCTIONS FOR THEME MANAGEMENT
-- ============================================

-- Function to get theme configuration by value name
CREATE OR REPLACE FUNCTION get_theme_config(theme_name VARCHAR)
RETURNS TABLE(
    theme_id INTEGER,
    name VARCHAR,
    text_color VARCHAR,
    background_color VARCHAR,
    menu_color VARCHAR,
    border_line_color VARCHAR,
    header_overlay_color VARCHAR,
    metadata JSONB
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        tc.id,
        tc.name,
        tc.text_color,
        tc.background_color,
        tc.menu_color,
        tc.border_line_color,
        tc.header_overlay_color,
        tc.metadata
    FROM theme_configs tc
    JOIN option_values ov ON tc.option_value_id = ov.id
    JOIN option_sets os ON ov.option_set_id = os.id
    WHERE os.name = 'appearance' 
      AND ov.value_name = theme_name 
      AND ov.is_active = TRUE;
END;
$$ LANGUAGE plpgsql;

-- Function to get all available themes
CREATE OR REPLACE FUNCTION get_all_themes()
RETURNS TABLE(
    value_name VARCHAR,
    display_name VARCHAR,
    theme_name VARCHAR,
    text_color VARCHAR,
    background_color VARCHAR,
    menu_color VARCHAR,
    border_line_color VARCHAR,
    header_overlay_color VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        ov.value_name,
        ov.display_name,
        tc.name,
        tc.text_color,
        tc.background_color,
        tc.menu_color,
        tc.border_line_color,
        tc.header_overlay_color
    FROM option_values ov
    JOIN option_sets os ON ov.option_set_id = os.id
    LEFT JOIN theme_configs tc ON ov.id = tc.option_value_id
    WHERE os.name = 'appearance' 
      AND ov.is_active = TRUE
    ORDER BY ov.sort_order;
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- VIEWS FOR CONVENIENCE
-- ============================================

-- View to easily access theme configurations
CREATE OR REPLACE VIEW appearance_themes AS
SELECT 
    ov.id as option_value_id,
    ov.value_name,
    ov.display_name,
    ov.sort_order,
    tc.id as theme_config_id,
    tc.name as theme_name,
    tc.text_color,
    tc.background_color,
    tc.menu_color,
    tc.border_line_color,
    tc.header_overlay_color,
    tc.metadata
FROM option_values ov
JOIN option_sets os ON ov.option_set_id = os.id
LEFT JOIN theme_configs tc ON ov.id = tc.option_value_id
WHERE os.name = 'appearance' 
  AND ov.is_active = TRUE
ORDER BY ov.sort_order;

-- ============================================
-- COMMENTS FOR DOCUMENTATION
-- ============================================
COMMENT ON TABLE option_sets IS 'Configuration sets for grouping related options (e.g., appearance, workflow_types)';
COMMENT ON TABLE option_values IS 'Individual option values within each option set';
COMMENT ON TABLE theme_configs IS 'Appearance theme configuration with color attributes';

COMMENT ON COLUMN theme_configs.text_color IS 'Primary text color (hex format: #RRGGBB)';
COMMENT ON COLUMN theme_configs.background_color IS 'Main background color (hex format: #RRGGBB)';
COMMENT ON COLUMN theme_configs.menu_color IS 'Menu/navigation background color (hex format: #RRGGBB)';
COMMENT ON COLUMN theme_configs.border_line_color IS 'Border and line color (hex format: #RRGGBB)';
COMMENT ON COLUMN theme_configs.header_overlay_color IS 'Header overlay color with transparency (hex format: #RRGGBBAA)';
COMMENT ON COLUMN theme_configs.user_button_color IS 'User menu button background color (hex format: #RRGGBB or #RRGGBBAA)';
COMMENT ON COLUMN theme_configs.user_button_hover IS 'User menu button hover state color (hex format: #RRGGBB or #RRGGBBAA)';
COMMENT ON COLUMN theme_configs.user_button_icon IS 'User menu button icon color (hex format: #RRGGBB)';
COMMENT ON COLUMN theme_configs.title_menu_color_light IS 'Light title/menu text color (hex format: #RRGGBB)';
COMMENT ON COLUMN theme_configs.border_line_color_light IS 'Light border/line color with transparency (hex format: #RRGGBBAA)';