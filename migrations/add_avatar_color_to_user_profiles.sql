-- Migration: Add avatar_color_id column to user_profiles table
-- Date: 2025-12-07
-- Description: Adds avatar color configuration with relation to smarthub_color_scheme option set

-- Add the new column
ALTER TABLE user_profiles 
ADD COLUMN IF NOT EXISTS avatar_color_id INTEGER REFERENCES option_values(id) ON DELETE SET NULL;

-- Create index for better query performance
CREATE INDEX IF NOT EXISTS idx_user_profiles_avatar_color_id ON user_profiles(avatar_color_id);

-- Set default avatar color to 'royal_blue' for existing users
UPDATE user_profiles
SET avatar_color_id = (
    SELECT ov.id 
    FROM option_values ov
    JOIN option_sets os ON ov.option_set_id = os.id
    WHERE os.name = 'smarthub_color_scheme' 
    AND ov.value_name = 'royal_blue'
)
WHERE avatar_color_id IS NULL;
