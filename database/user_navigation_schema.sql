-- User Navigation Table
-- Tracks current user context and navigation state
-- One-to-one relationship with user_profile (auth-api)
-- One-to-one relationship with current_smart_hub

CREATE TABLE IF NOT EXISTS user_navigation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_profile_id UUID NOT NULL UNIQUE,
    current_smart_hub_id UUID UNIQUE REFERENCES smart_hubs(id) ON DELETE SET NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_user_navigation_user_profile_id ON user_navigation(user_profile_id);
CREATE INDEX IF NOT EXISTS idx_user_navigation_current_smart_hub_id ON user_navigation(current_smart_hub_id);

-- Updated at trigger
CREATE OR REPLACE FUNCTION update_user_navigation_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER user_navigation_updated_at
    BEFORE UPDATE ON user_navigation
    FOR EACH ROW
    EXECUTE FUNCTION update_user_navigation_updated_at();
