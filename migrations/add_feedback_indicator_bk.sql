-- ============================================
-- ADD feedback_indicator_bk TO APPEARANCE THEMES
-- Migration to add feedback indicator background color
-- ============================================

-- Add the new column to theme_configs table
ALTER TABLE theme_configs 
ADD COLUMN IF NOT EXISTS feedback_indicator_bk VARCHAR(7);

-- Update existing appearance themes with feedback_indicator_bk values
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
    
    -- Get the option value IDs
    SELECT id INTO sun_value_id FROM option_values WHERE option_set_id = appearance_set_id AND value_name = 'sun';
    SELECT id INTO moon_value_id FROM option_values WHERE option_set_id = appearance_set_id AND value_name = 'moon';
    SELECT id INTO space_value_id FROM option_values WHERE option_set_id = appearance_set_id AND value_name = 'space';
    SELECT id INTO star_value_id FROM option_values WHERE option_set_id = appearance_set_id AND value_name = 'star';
    
    -- Update each theme with its feedback_indicator_bk value
    UPDATE theme_configs SET feedback_indicator_bk = '#FFFFFF' WHERE option_value_id = sun_value_id;
    UPDATE theme_configs SET feedback_indicator_bk = '#2F2F2F' WHERE option_value_id = moon_value_id;
    UPDATE theme_configs SET feedback_indicator_bk = '#2A2E35' WHERE option_value_id = space_value_id;
    UPDATE theme_configs SET feedback_indicator_bk = '#181B34' WHERE option_value_id = star_value_id;
    
    RAISE NOTICE 'Successfully added feedback_indicator_bk to all appearance themes';
END $$;

-- Add comment for documentation
COMMENT ON COLUMN theme_configs.feedback_indicator_bk IS 'Feedback indicator background color (hex format: #RRGGBB)';
