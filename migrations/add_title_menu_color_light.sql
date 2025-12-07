-- Migration: Add title_menu_color_light column to theme_configs table

-- Add the new column
ALTER TABLE theme_configs 
ADD COLUMN IF NOT EXISTS title_menu_color_light VARCHAR(7);

-- Update existing themes with correct values
UPDATE theme_configs tc
SET title_menu_color_light = CASE 
    WHEN ov.value_name = 'sun' THEN '#d6d6d6'
    WHEN ov.value_name = 'moon' THEN '#62676F'
    WHEN ov.value_name = 'space' THEN '#62676F'
    WHEN ov.value_name = 'star' THEN '#616daa'
END
FROM option_values ov
WHERE tc.option_value_id = ov.id
  AND ov.option_set_id = (SELECT id FROM option_sets WHERE name = 'appearance');

-- Add comment for documentation
COMMENT ON COLUMN theme_configs.title_menu_color_light IS 'Light title/menu text color (hex format: #RRGGBB)';
