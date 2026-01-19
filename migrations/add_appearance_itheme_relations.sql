
-- ============================================
-- Migration: Add appearance_id and itheme_id to user_profiles
-- Date: 2025-12-06
-- Description: Replace selected_theme string with proper foreign key relationships
-- ============================================

-- Add appearance_id column
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'user_profiles' AND column_name = 'appearance_id'
    ) THEN
        ALTER TABLE user_profiles ADD COLUMN appearance_id INTEGER;
        ALTER TABLE user_profiles ADD CONSTRAINT fk_user_profiles_appearance 
            FOREIGN KEY (appearance_id) REFERENCES option_values(id) ON DELETE SET NULL;
        CREATE INDEX IF NOT EXISTS idx_user_profiles_appearance_id ON user_profiles(appearance_id);
        RAISE NOTICE 'Added appearance_id column to user_profiles';
    ELSE
        RAISE NOTICE 'appearance_id column already exists';
    END IF;
END $$;

-- Add itheme_id column
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'user_profiles' AND column_name = 'itheme_id'
    ) THEN
        ALTER TABLE user_profiles ADD COLUMN itheme_id INTEGER;
        ALTER TABLE user_profiles ADD CONSTRAINT fk_user_profiles_itheme 
            FOREIGN KEY (itheme_id) REFERENCES option_values(id) ON DELETE SET NULL;
        CREATE INDEX IF NOT EXISTS idx_user_profiles_itheme_id ON user_profiles(itheme_id);
        RAISE NOTICE 'Added itheme_id column to user_profiles';
    ELSE
        RAISE NOTICE 'itheme_id column already exists';
    END IF;
END $$;

-- Migrate existing selected_theme data to appearance_id
DO $$
DECLARE
    sun_id INTEGER;
    appearance_set_id INTEGER;
BEGIN
    -- Get appearance option set ID
    SELECT id INTO appearance_set_id FROM option_sets WHERE name = 'appearance';
    
    IF appearance_set_id IS NOT NULL THEN
        -- Get the 'sun' option value ID
        SELECT id INTO sun_id FROM option_values 
        WHERE option_set_id = appearance_set_id AND value_name = 'sun';
        
        IF sun_id IS NOT NULL THEN
            -- Update all users without appearance_id to use 'sun'
            UPDATE user_profiles 
            SET appearance_id = sun_id 
            WHERE appearance_id IS NULL;
            
            RAISE NOTICE 'Set default appearance to sun (ID: %) for all users', sun_id;
        ELSE
            RAISE NOTICE 'Sun theme not found in option_values';
        END IF;
    ELSE
        RAISE NOTICE 'Appearance option set not found';
    END IF;
END $$;

-- Drop the old selected_theme column (optional - uncomment if you want to remove it)
-- DO $$
-- BEGIN
--     IF EXISTS (
--         SELECT 1 FROM information_schema.columns 
--         WHERE table_name = 'user_profiles' AND column_name = 'selected_theme'
--     ) THEN
--         ALTER TABLE user_profiles DROP COLUMN selected_theme;
--         RAISE NOTICE 'Dropped selected_theme column from user_profiles';
--     END IF;
-- END $$;

-- Add comments
COMMENT ON COLUMN user_profiles.appearance_id IS 'Foreign key to option_values for appearance theme (one-to-one)';
COMMENT ON COLUMN user_profiles.itheme_id IS 'Foreign key to option_values for iTheme gradient (one-to-one)';
