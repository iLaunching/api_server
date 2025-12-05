-- User Navigation Table Schema
-- Tracks user's current active Smart Hub and other navigation contexts for quick navigation and memory

-- Create user_navigation table
CREATE TABLE IF NOT EXISTS user_navigation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Foreign Keys
    user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
    
    -- Navigation contexts - can be expanded for other features
    current_smart_hub_id UUID REFERENCES smart_hubs(id) ON DELETE SET NULL,
    -- Future navigation fields can be added here:
    -- current_project_id UUID REFERENCES projects(id) ON DELETE SET NULL,
    -- current_workspace_id UUID REFERENCES workspaces(id) ON DELETE SET NULL,
    -- current_view VARCHAR(100),  -- e.g., 'dashboard', 'calendar', 'tasks'
    
    -- Additional navigation state (JSONB for flexibility)
    navigation_state JSONB DEFAULT '{}',
    
    -- Timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Constraints
    CONSTRAINT fk_user_navigation_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_user_navigation_smart_hub FOREIGN KEY (current_smart_hub_id) REFERENCES smart_hubs(id) ON DELETE SET NULL
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_user_navigation_user_id ON user_navigation(user_id);
CREATE INDEX IF NOT EXISTS idx_user_navigation_current_smart_hub ON user_navigation(current_smart_hub_id);

-- Ensure only one navigation record per user
CREATE UNIQUE INDEX IF NOT EXISTS idx_user_navigation_user_unique ON user_navigation(user_id);

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
COMMENT ON TABLE user_navigation IS 'Stores user navigation state including current contexts and view preferences';
COMMENT ON COLUMN user_navigation.id IS 'Unique identifier for the navigation record';
COMMENT ON COLUMN user_navigation.user_id IS 'Foreign key to users table (one-to-one relationship with user_profile)';
COMMENT ON COLUMN user_navigation.current_smart_hub_id IS 'Current active Smart Hub the user is viewing/working in';
COMMENT ON COLUMN user_navigation.navigation_state IS 'Flexible JSONB field for storing additional navigation context (views, filters, etc.)';
COMMENT ON COLUMN user_navigation.created_at IS 'When this navigation record was created';
COMMENT ON COLUMN user_navigation.updated_at IS 'Last time the navigation state was updated';
