-- Migration: Create tbl_contexts table
-- Phase 2, Step 2.1: Context Layer (Tier B)
-- Purpose: Containers that inherit DNA from Manifest and represent logical groupings

-- Enable PostGIS extension for spatial data if not already enabled
CREATE EXTENSION IF NOT EXISTS postgis;

-- Create contexts table
CREATE TABLE IF NOT EXISTS tbl_contexts (
    context_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    manifest_id UUID NOT NULL REFERENCES tbl_manifest(manifest_id) ON DELETE CASCADE,
    context_name VARCHAR(255) NOT NULL,
    context_type VARCHAR(50) NOT NULL, -- Enum: CAMPAIGN, GENESIS, VALIDATE, GOAL, PROJECT, SMART_ROUTER, etc.
    boundary_polygon GEOMETRY(POLYGON, 0), -- Cartesian 2D plane (SRID 0)
    inherited_intent TEXT,
    local_variables JSONB DEFAULT '{}',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for fast lookups
CREATE INDEX IF NOT EXISTS idx_contexts_manifest ON tbl_contexts(manifest_id);
CREATE INDEX IF NOT EXISTS idx_contexts_type ON tbl_contexts(context_type);
-- GIST index for spatial queries on the boundary polygon
CREATE INDEX IF NOT EXISTS idx_contexts_boundary ON tbl_contexts USING GIST(boundary_polygon);

-- Add comments for documentation
COMMENT ON TABLE tbl_contexts IS 'Tier B: Context Layer - Logical containers inheriting DNA from Manifest';
COMMENT ON COLUMN tbl_contexts.context_id IS 'Primary key for the context';
COMMENT ON COLUMN tbl_contexts.manifest_id IS 'Foreign key to tbl_manifest (many-to-one)';
COMMENT ON COLUMN tbl_contexts.boundary_polygon IS 'Spatial boundary on the canvas (Cartesian 2D plane, SRID 0)';
COMMENT ON COLUMN tbl_contexts.inherited_intent IS 'Intent string inherited automatically from Manifest DNA';
COMMENT ON COLUMN tbl_contexts.local_variables IS 'Context-specific variables and configuration';

-- reuse the update timestamp function if it exists, or create a specific one for contexts
-- relying on a shared function is better, but to be safe and self-contained within this migration chain:
CREATE OR REPLACE FUNCTION update_context_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_update_context_timestamp ON tbl_contexts;
CREATE TRIGGER trigger_update_context_timestamp
    BEFORE UPDATE ON tbl_contexts
    FOR EACH ROW
    EXECUTE FUNCTION update_context_timestamp();
