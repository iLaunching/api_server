-- Migration: Add profile icon support to user_profiles
-- Adds icon selection capability following option set architecture

-- Add profile_icon_id column to user_profiles
ALTER TABLE user_profiles 
ADD COLUMN IF NOT EXISTS profile_icon_id INTEGER REFERENCES option_values(id);

-- Create index for fast icon lookups
CREATE INDEX IF NOT EXISTS idx_user_profiles_icon ON user_profiles(profile_icon_id);

-- Set default icon (will be set after seed data is loaded)
-- For now, leave NULL and users can select their icon

COMMENT ON COLUMN user_profiles.profile_icon_id IS 'Reference to icon_library option set for user avatar icon';
