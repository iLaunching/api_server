-- User Navigation Table Schema
-- Tracks user's current active Smart Hub for quick navigation and memory
-- One-to-one relationship with user_profiles (not users)

-- Drop existing table if it exists (to recreate with correct constraints)
DROP TABLE IF EXISTS user_navigation CASCADE;

-- Create user_navigation table
CREATE TABLE user_navigation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Foreign Keys - references user_profiles for one-to-one relationship
    user_profile_id UUID NOT NULL UNIQUE REFERENCES user_profiles(id) ON DELETE CASCADE,
    current_smart_hub_id UUID REFERENCES smart_hubs(id) ON DELETE SET NULL,
    
    -- Timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Constraints
    CONSTRAINT fk_user_navigation_profile FOREIGN KEY (user_profile_id) REFERENCES user_profiles(id) ON DELETE CASCADE,
    CONSTRAINT fk_user_navigation_smart_hub FOREIGN KEY (current_smart_hub_id) REFERENCES smart_hubs(id) ON DELETE SET NULL
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_user_navigation_user_profile_id ON user_navigation(user_profile_id);
CREATE INDEX IF NOT EXISTS idx_user_navigation_current_smart_hub ON user_navigation(current_smart_hub_id);

-- Ensure only one navigation record per user profile
CREATE UNIQUE INDEX IF NOT EXISTS idx_user_navigation_profile_unique ON user_navigation(user_profile_id);

-- Auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION update_user_navigation_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_user_navigation_updated_at
    BEFORE UPDATE ON user_navigation
    FOR EACH ROW
    EXECUTE FUNCTION update_user_navigation_updated_at();

-- Comments for documentation
COMMENT ON TABLE user_navigation IS 'Stores user navigation state including current active Smart Hub';
COMMENT ON COLUMN user_navigation.id IS 'Unique identifier for the navigation record';
COMMENT ON COLUMN user_navigation.user_profile_id IS 'Foreign key to user_profiles table (one-to-one relationship)';
COMMENT ON COLUMN user_navigation.current_smart_hub_id IS 'Current active Smart Hub the user is viewing/working in';
COMMENT ON COLUMN user_navigation.created_at IS 'When this navigation record was created';
COMMENT ON COLUMN user_navigation.updated_at IS 'Last time the navigation state was updated';
