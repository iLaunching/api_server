-- Migration: Add manifest_id to smart_matrices table
-- Purpose: Direct access to manifest from smart_matrix for performance
-- This creates a bidirectional one-to-one relationship

-- Add manifest_id column to smart_matrices
ALTER TABLE smart_matrices 
ADD COLUMN IF NOT EXISTS manifest_id UUID UNIQUE REFERENCES tbl_manifest(manifest_id) ON DELETE SET NULL;

-- Create index for fast lookups
CREATE INDEX IF NOT EXISTS idx_smart_matrices_manifest ON smart_matrices(manifest_id);

-- Add comment
COMMENT ON COLUMN smart_matrices.manifest_id IS 'Direct reference to manifest for fast access (one-to-one relationship)';
