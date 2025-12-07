-- Migration: Add global_button_hover column to theme_configs table
-- Date: 2025-12-07
-- Description: Adds global button hover color configuration to appearance option set

-- Add the new column
ALTER TABLE theme_configs 
ADD COLUMN IF NOT EXISTS global_button_hover VARCHAR(9);

-- Update existing themes with the correct value (same for all themes)
UPDATE theme_configs tc
SET global_button_hover = '#d6d6d64d'
FROM option_values ov
WHERE tc.option_value_id = ov.id
  AND ov.value_name IN ('sun', 'moon', 'space', 'star')
  AND tc.global_button_hover IS NULL;
