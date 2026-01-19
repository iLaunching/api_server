-- ============================================
-- Migration: Add header_overlay_color to appearance themes
-- Date: 2025-12-06
-- ============================================

-- Add header_overlay_color column to theme_configs if it doesn't exist
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'theme_configs' AND column_name = 'header_overlay_color'
    ) THEN
        ALTER TABLE theme_configs ADD COLUMN header_overlay_color VARCHAR(9);
        RAISE NOTICE 'Added header_overlay_color column to theme_configs';
    ELSE
        RAISE NOTICE 'header_overlay_color column already exists';
    END IF;
END $$;

-- Update appearance themes with header_overlay_color values
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
    
    IF appearance_set_id IS NULL THEN
        RAISE EXCEPTION 'Appearance option set not found';
    END IF;
    
    -- Get the option value IDs
    SELECT id INTO sun_value_id FROM option_values 
    WHERE option_set_id = appearance_set_id AND value_name = 'sun';
    
    SELECT id INTO moon_value_id FROM option_values 
    WHERE option_set_id = appearance_set_id AND value_name = 'moon';
    
    SELECT id INTO space_value_id FROM option_values 
    WHERE option_set_id = appearance_set_id AND value_name = 'space';
    
    SELECT id INTO star_value_id FROM option_values 
    WHERE option_set_id = appearance_set_id AND value_name = 'star';
    
    -- Update header_overlay_color for each theme
    IF sun_value_id IS NOT NULL THEN
        UPDATE theme_configs 
        SET header_overlay_color = '#00000080'
        WHERE option_value_id = sun_value_id;
        RAISE NOTICE 'Updated sun theme: header_overlay_color = #00000080';
    END IF;
    
    IF star_value_id IS NOT NULL THEN
        UPDATE theme_configs 
        SET header_overlay_color = '#00000000'
        WHERE option_value_id = star_value_id;
        RAISE NOTICE 'Updated star theme: header_overlay_color = #00000000';
    END IF;
    
    IF moon_value_id IS NOT NULL THEN
        UPDATE theme_configs 
        SET header_overlay_color = '#00000000'
        WHERE option_value_id = moon_value_id;
        RAISE NOTICE 'Updated moon theme: header_overlay_color = #00000000';
    END IF;
    
    IF space_value_id IS NOT NULL THEN
        UPDATE theme_configs 
        SET header_overlay_color = '#00000000'
        WHERE option_value_id = space_value_id;
        RAISE NOTICE 'Updated space theme: header_overlay_color = #00000000';
    END IF;
    
    RAISE NOTICE 'Successfully updated appearance themes with header_overlay_color';
END $$;

-- Add comment for documentation
COMMENT ON COLUMN theme_configs.header_overlay_color IS 'Header overlay color with transparency (hex format: #RRGGBBAA)';
