-- Migration: Add button color columns to theme_configs table
-- These should be proper columns, not in theme_metadata JSONB

-- Add the new columns
ALTER TABLE theme_configs 
ADD COLUMN IF NOT EXISTS user_button_color VARCHAR(9),
ADD COLUMN IF NOT EXISTS user_button_hover VARCHAR(9),
ADD COLUMN IF NOT EXISTS user_button_icon VARCHAR(7);

-- Update existing themes with correct values
UPDATE theme_configs tc
SET 
    user_button_color = CASE 
        WHEN ov.value_name = 'sun' THEN '#ffffff59'
        WHEN ov.value_name = 'moon' THEN '#ffffff59'
        WHEN ov.value_name = 'space' THEN '#505663'
        WHEN ov.value_name = 'star' THEN '#181B34'
    END,
    user_button_hover = CASE 
        WHEN ov.value_name = 'sun' THEN '#ffffff66'
        WHEN ov.value_name = 'moon' THEN '#ffffff66'
        WHEN ov.value_name = 'space' THEN '#505663cc'
        WHEN ov.value_name = 'star' THEN '#181B34cc'
    END,
    user_button_icon = CASE 
        WHEN ov.value_name = 'sun' THEN '#ffffff'
        WHEN ov.value_name = 'moon' THEN '#000000'
        WHEN ov.value_name = 'space' THEN '#ffffff'
        WHEN ov.value_name = 'star' THEN '#ffffff'
    END
FROM option_values ov
WHERE tc.option_value_id = ov.id
  AND ov.option_set_id = (SELECT id FROM option_sets WHERE name = 'appearance');

-- Add comments for documentation
COMMENT ON COLUMN theme_configs.user_button_color IS 'User menu button background color (hex format: #RRGGBB or #RRGGBBAA)';
COMMENT ON COLUMN theme_configs.user_button_hover IS 'User menu button hover state color (hex format: #RRGGBB or #RRGGBBAA)';
COMMENT ON COLUMN theme_configs.user_button_icon IS 'User menu button icon color (hex format: #RRGGBB)';
