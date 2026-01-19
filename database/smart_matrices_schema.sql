-- Smart Matrices Schema
-- The brain/data center for each Smart Hub - ONE per hub (one-to-one relationship)

-- Create smart_matrices table
CREATE TABLE IF NOT EXISTS smart_matrices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    smart_hub_id UUID NOT NULL UNIQUE REFERENCES smart_hubs(id) ON DELETE CASCADE,
    owner_id UUID NOT NULL,  -- References users.id in auth database
    name TEXT NOT NULL,
    color TEXT,
    order_number INTEGER DEFAULT 0 NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    modified_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_smart_matrices_smart_hub_id ON smart_matrices(smart_hub_id);
CREATE INDEX IF NOT EXISTS idx_smart_matrices_owner_id ON smart_matrices(owner_id);
CREATE INDEX IF NOT EXISTS idx_smart_matrices_created_at ON smart_matrices(created_at);
CREATE INDEX IF NOT EXISTS idx_smart_matrices_hub_order ON smart_matrices(smart_hub_id, order_number);

-- Add trigger to update modified_at timestamp
CREATE OR REPLACE FUNCTION update_smart_matrices_modified_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.modified_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_smart_matrices_modified_at
    BEFORE UPDATE ON smart_matrices
    FOR EACH ROW
    EXECUTE FUNCTION update_smart_matrices_modified_at();

-- Comments for documentation
COMMENT ON TABLE smart_matrices IS 'Smart Matrix - The brain/data center for each Smart Hub (one-to-one)';
COMMENT ON COLUMN smart_matrices.smart_hub_id IS 'The Smart Hub this matrix belongs to (unique - one per hub)';
COMMENT ON COLUMN smart_matrices.owner_id IS 'User who owns this matrix (references auth database)';
COMMENT ON COLUMN smart_matrices.name IS 'Display name of the matrix';
COMMENT ON COLUMN smart_matrices.color IS 'Color theme for this matrix';
COMMENT ON COLUMN smart_matrices.order_number IS 'Display order within the hub (ascending)';
COMMENT ON COLUMN smart_matrices.modified_at IS 'Last modification timestamp (auto-updated)';
