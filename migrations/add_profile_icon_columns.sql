-- Migration: Add profile_icon_id and avatar_display_option_value_id to user_profiles
-- Purpose: Enable icon-based avatar display with display mode tracking

DO $$
BEGIN
    -- Add profile_icon_id column if it doesn't exist
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'user_profiles' 
        AND column_name = 'profile_icon_id'
    ) THEN
        ALTER TABLE user_profiles 
        ADD COLUMN profile_icon_id INTEGER;
        
        ALTER TABLE user_profiles
        ADD CONSTRAINT fk_user_profiles_profile_icon
        FOREIGN KEY (profile_icon_id) 
        REFERENCES option_values(id) 
        ON DELETE SET NULL;
        
        CREATE INDEX idx_user_profiles_profile_icon_id 
        ON user_profiles(profile_icon_id);
        
        RAISE NOTICE 'Added profile_icon_id column to user_profiles';
    ELSE
        RAISE NOTICE 'profile_icon_id column already exists';
    END IF;

    -- Add avatar_display_option_value_id column if it doesn't exist
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'user_profiles' 
        AND column_name = 'avatar_display_option_value_id'
    ) THEN
        ALTER TABLE user_profiles 
        ADD COLUMN avatar_display_option_value_id INTEGER DEFAULT 24;
        
        -- Update existing NULL values to 24 (default/initials mode)
        UPDATE user_profiles 
        SET avatar_display_option_value_id = 24 
        WHERE avatar_display_option_value_id IS NULL;
        
        CREATE INDEX idx_user_profiles_avatar_display 
        ON user_profiles(avatar_display_option_value_id);
        
        RAISE NOTICE 'Added avatar_display_option_value_id column to user_profiles';
    ELSE
        RAISE NOTICE 'avatar_display_option_value_id column already exists';
    END IF;
END $$;
