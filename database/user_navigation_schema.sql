-- User Navigation Table Schema
-- Global navigation system for the entire application - tracks user's current position across all app features
-- Created on user signup - one-to-one with user_profile

-- Create user_navigation table
CREATE TABLE IF NOT EXISTS user_navigation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- One-to-one relationship with users
    user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
    
    -- Current navigation contexts (each field is nullable and replaceable)
    current_smart_hub_id UUID REFERENCES smart_hubs(id) ON DELETE SET NULL,
    current_smart_matrix_id UUID REFERENCES smart_matrices(id) ON DELETE SET NULL,
    
    -- Timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Constraints
    CONSTRAINT fk_user_navigation_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_user_navigation_smart_hub FOREIGN KEY (current_smart_hub_id) REFERENCES smart_hubs(id) ON DELETE SET NULL,
    CONSTRAINT fk_user_navigation_smart_matrix FOREIGN KEY (current_smart_matrix_id) REFERENCES smart_matrices(id) ON DELETE SET NULL
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_user_navigation_user_id ON user_navigation(user_id);
CREATE INDEX IF NOT EXISTS idx_user_navigation_current_smart_hub ON user_navigation(current_smart_hub_id);
CREATE INDEX IF NOT EXISTS idx_user_navigation_current_smart_matrix ON user_navigation(current_smart_matrix_id);

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
COMMENT ON TABLE user_navigation IS 'Global navigation system for entire application - tracks current position across all features';
COMMENT ON COLUMN user_navigation.id IS 'Unique identifier for the navigation record';
COMMENT ON COLUMN user_navigation.user_id IS 'Foreign key to users table (one-to-one relationship with user_profile)';
COMMENT ON COLUMN user_navigation.current_smart_hub_id IS 'Current active Smart Hub (replaceable)';
COMMENT ON COLUMN user_navigation.current_smart_matrix_id IS 'Current active Smart Matrix (replaceable)';
COMMENT ON COLUMN user_navigation.created_at IS 'When this navigation record was created (on signup)';
COMMENT ON COLUMN user_navigation.updated_at IS 'Last time any navigation field was updated';
