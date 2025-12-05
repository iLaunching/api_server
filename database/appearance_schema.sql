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
    
    -- Insert theme configurations with final hardcoded colors
    INSERT INTO theme_configs (option_value_id, name, text_color, background_color, menu_color, border_line_color) VALUES 
        (sun_value_id, 'Sun', '#ffffff', '#2a2e35', '#3a3f47', '#62676f'),
        (moon_value_id, 'Moon', '#d6d6d6', '#2f2f2f', '#464545', '#62676f'),
        (space_value_id, 'Space', '#ffffff', '#2a2e35', '#3a3f47', '#62676f'),
        (star_value_id, 'Star', '#ffffff', '#181b34', '#292f4c', '#616daa')
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
    border_line_color VARCHAR
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
        tc.border_line_color
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