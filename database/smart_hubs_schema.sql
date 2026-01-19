-- Smart Hubs Schema
-- Self-contained collaboration workspaces for users

-- Create smart_hubs table
CREATE TABLE IF NOT EXISTS smart_hubs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_id UUID NOT NULL,  -- References users.id in auth database
    name VARCHAR(255) NOT NULL,
    description TEXT,
    avatar TEXT,
    hub_color VARCHAR(50),
    order_number INTEGER DEFAULT 0 NOT NULL,
    is_active BOOLEAN DEFAULT true NOT NULL,
    is_default BOOLEAN DEFAULT false NOT NULL,
    settings JSONB DEFAULT '{}' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    modified_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_smart_hubs_owner_id ON smart_hubs(owner_id);
CREATE INDEX IF NOT EXISTS idx_smart_hubs_is_active ON smart_hubs(is_active);
CREATE INDEX IF NOT EXISTS idx_smart_hubs_created_at ON smart_hubs(created_at);
CREATE INDEX IF NOT EXISTS idx_smart_hubs_owner_active ON smart_hubs(owner_id, is_active);

-- Ensure only one default hub per user
CREATE UNIQUE INDEX IF NOT EXISTS idx_smart_hubs_owner_default ON smart_hubs(owner_id) WHERE is_default = true;

-- Add trigger to update modified_at timestamp
CREATE OR REPLACE FUNCTION update_smart_hubs_modified_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.modified_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_smart_hubs_modified_at
    BEFORE UPDATE ON smart_hubs
    FOR EACH ROW
    EXECUTE FUNCTION update_smart_hubs_modified_at();

-- Comments for documentation
COMMENT ON TABLE smart_hubs IS 'User workspaces - self-contained collaboration spaces';
COMMENT ON COLUMN smart_hubs.owner_id IS 'User who owns/created this hub (references auth database)';
COMMENT ON COLUMN smart_hubs.name IS 'Display name of the hub';
COMMENT ON COLUMN smart_hubs.description IS 'Hub description/purpose';
COMMENT ON COLUMN smart_hubs.avatar IS 'Hub avatar image URL or icon identifier';
COMMENT ON COLUMN smart_hubs.hub_color IS 'Hub theme color (hex code)';
COMMENT ON COLUMN smart_hubs.order_number IS 'Display order for user hubs (ascending)';
COMMENT ON COLUMN smart_hubs.is_active IS 'Whether hub is active or archived';
COMMENT ON COLUMN smart_hubs.is_default IS 'Whether this is the user default hub (only one per user)';
COMMENT ON COLUMN smart_hubs.settings IS 'Hub-specific settings and preferences (JSONB)';
COMMENT ON COLUMN smart_hubs.modified_at IS 'Last modification timestamp (auto-updated)';
