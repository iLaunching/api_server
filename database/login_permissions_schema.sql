-- ============================================
-- LOGIN PERMISSIONS CONFIGURATION SCHEMA
-- Option Sets for Support Access Permissions
-- ============================================

-- Create the option sets table (if not exists from other schemas)
CREATE TABLE IF NOT EXISTS option_sets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create the option values table (if not exists from other schemas)
CREATE TABLE IF NOT EXISTS option_values (
    id SERIAL PRIMARY KEY,
    option_set_id INTEGER NOT NULL REFERENCES option_sets(id) ON DELETE CASCADE,
    value_name VARCHAR(100) NOT NULL,
    display_name VARCHAR(200),
    sort_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create the theme configs table (if not exists from other schemas)
CREATE TABLE IF NOT EXISTS theme_configs (
    id SERIAL PRIMARY KEY,
    option_value_id INTEGER NOT NULL UNIQUE REFERENCES option_values(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    text_color VARCHAR(7),
    background_color VARCHAR(7),
    menu_color VARCHAR(7),
    border_line_color VARCHAR(7),
    theme_metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- ADD DESCRIPTION COLUMN IF NOT EXISTS
-- ============================================
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'theme_configs' AND column_name = 'description'
    ) THEN
        ALTER TABLE theme_configs ADD COLUMN description TEXT;
    END IF;
END $$;

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================
CREATE INDEX IF NOT EXISTS idx_option_sets_name ON option_sets(name);
CREATE INDEX IF NOT EXISTS idx_option_values_set_id ON option_values(option_set_id);
CREATE INDEX IF NOT EXISTS idx_option_values_active ON option_values(is_active) WHERE is_active = TRUE;
CREATE INDEX IF NOT EXISTS idx_theme_configs_option_value ON theme_configs(option_value_id);

-- ============================================
-- INSERT LOGIN PERMISSIONS OPTION SET AND VALUES
-- ============================================

-- Insert the login_permissions option set
INSERT INTO option_sets (name, description) VALUES 
    ('login_permissions', 'Support access permission levels for user accounts')
ON CONFLICT (name) DO NOTHING;

-- Get the login_permissions option set ID for reference
DO $$
DECLARE
    login_permissions_set_id INTEGER;
    disabled_value_id INTEGER;
    lt_value_id INTEGER;
    ltvs_value_id INTEGER;
BEGIN
    -- Get the login_permissions set ID
    SELECT id INTO login_permissions_set_id FROM option_sets WHERE name = 'login_permissions';
    
    -- Insert option values for login permissions
    INSERT INTO option_values (option_set_id, value_name, display_name, sort_order) VALUES 
        (login_permissions_set_id, 'disabled', 'Disabled', 1),
        (login_permissions_set_id, 'LT', 'Login and Testing Permissions Granted', 2),
        (login_permissions_set_id, 'LTVS', 'Login, Testing, Video, and Screenshot Permissions Granted', 3)
    ON CONFLICT DO NOTHING;
    
    -- Get the option value IDs
    SELECT id INTO disabled_value_id FROM option_values 
        WHERE option_set_id = login_permissions_set_id AND value_name = 'disabled';
    SELECT id INTO lt_value_id FROM option_values 
        WHERE option_set_id = login_permissions_set_id AND value_name = 'LT';
    SELECT id INTO ltvs_value_id FROM option_values 
        WHERE option_set_id = login_permissions_set_id AND value_name = 'LTVS';
    
    -- Insert theme configurations with names and descriptions
    INSERT INTO theme_configs (
        option_value_id, 
        name, 
        description,
        text_color, 
        background_color, 
        menu_color, 
        border_line_color,
        theme_metadata
    ) VALUES 
        (
            disabled_value_id, 
            'Disabled', 
            'No access - Support cannot access your account',
            '', 
            '', 
            '', 
            '',
            '{"name": "Disabled", "description": "No access - Support cannot access your account"}'::jsonb
        ),
        (
            lt_value_id, 
            'Login and Testing Permissions Granted', 
            'Login and testing permissions granted',
            '', 
            '', 
            '', 
            '',
            '{"name": "Login and Testing Permissions Granted", "description": "Login and testing permissions granted"}'::jsonb
        ),
        (
            ltvs_value_id, 
            'Login, Testing, Video, and Screenshot Permissions Granted', 
            'Login, testing, video, and screenshot permissions granted',
            '', 
            '', 
            '', 
            '',
            '{"name": "Login, Testing, Video, and Screenshot Permissions Granted", "description": "Login, testing, video, and screenshot permissions granted"}'::jsonb
        )
    ON CONFLICT (option_value_id) DO UPDATE SET
        name = EXCLUDED.name,
        description = EXCLUDED.description,
        theme_metadata = EXCLUDED.theme_metadata;
END $$;

-- ============================================
-- VERIFICATION QUERY
-- ============================================
-- SELECT 
--     os.name AS option_set_name,
--     ov.value_name,
--     ov.display_name,
--     tc.name AS config_name,
--     tc.description
-- FROM option_sets os
-- JOIN option_values ov ON os.id = ov.option_set_id
-- JOIN theme_configs tc ON ov.id = tc.option_value_id
-- WHERE os.name = 'login_permissions'
-- ORDER BY ov.sort_order;

-- ============================================
-- ADD LOGIN_PERMISSIONS COLUMN TO USER_PROFILES
-- ============================================
DO $$
DECLARE
    disabled_id INTEGER;
BEGIN
    -- Get the 'disabled' option value ID
    SELECT ov.id INTO disabled_id
    FROM option_values ov
    JOIN option_sets os ON ov.option_set_id = os.id
    WHERE os.name = 'login_permissions' AND ov.value_name = 'disabled';
    
    -- Add the column if it doesn't exist
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'user_profiles' AND column_name = 'login_permissions_option_value_id'
    ) THEN
        EXECUTE format(
            'ALTER TABLE user_profiles 
             ADD COLUMN login_permissions_option_value_id INTEGER 
             REFERENCES option_values(id) ON DELETE SET DEFAULT 
             DEFAULT %s',
            disabled_id
        );
        
        -- Create index for performance
        CREATE INDEX IF NOT EXISTS idx_user_profiles_login_permissions 
        ON user_profiles(login_permissions_option_value_id);
        
        RAISE NOTICE 'Added login_permissions_option_value_id column to user_profiles with default: %', disabled_id;
    END IF;
END $$;
