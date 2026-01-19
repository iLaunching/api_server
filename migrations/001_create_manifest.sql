-- Migration: Create tbl_manifest table
-- Phase 1, Step 1.1: Master Manifest (Tier A)
-- Purpose: Store spatial state (camera position, zoom) for each Smart Matrix

-- Create the manifest table
CREATE TABLE IF NOT EXISTS tbl_manifest (
    manifest_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    smart_matrix_id UUID NOT NULL UNIQUE REFERENCES smart_matrices(id) ON DELETE CASCADE,
    user_id UUID NOT NULL,
    current_x FLOAT DEFAULT 0.0,
    current_y FLOAT DEFAULT 0.0,
    zoom_level FLOAT DEFAULT 1.0,
    business_dna JSONB,
    last_heartbeat TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for fast lookups
CREATE INDEX IF NOT EXISTS idx_manifest_smart_matrix ON tbl_manifest(smart_matrix_id);
CREATE INDEX IF NOT EXISTS idx_manifest_user ON tbl_manifest(user_id);
CREATE INDEX IF NOT EXISTS idx_manifest_active ON tbl_manifest(is_active);

-- Add comments for documentation
COMMENT ON TABLE tbl_manifest IS 'Tier A: Master Manifest - Stores spatial state and business DNA for each Smart Matrix';
COMMENT ON COLUMN tbl_manifest.manifest_id IS 'Primary key for the manifest';
COMMENT ON COLUMN tbl_manifest.smart_matrix_id IS 'Foreign key to smart_matrices table (one-to-one relationship)';
COMMENT ON COLUMN tbl_manifest.user_id IS 'User who owns this manifest';
COMMENT ON COLUMN tbl_manifest.current_x IS 'Current camera X position in world coordinates';
COMMENT ON COLUMN tbl_manifest.current_y IS 'Current camera Y position in world coordinates';
COMMENT ON COLUMN tbl_manifest.zoom_level IS 'Current zoom level (1.0 = 100%)';
COMMENT ON COLUMN tbl_manifest.business_dna IS 'JSONB containing founder intent, constraints, and style';
COMMENT ON COLUMN tbl_manifest.last_heartbeat IS 'Last time the manifest was accessed/updated';
COMMENT ON COLUMN tbl_manifest.is_active IS 'Whether this manifest is currently active';

-- Create trigger to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_manifest_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_manifest_timestamp
    BEFORE UPDATE ON tbl_manifest
    FOR EACH ROW
    EXECUTE FUNCTION update_manifest_timestamp();
