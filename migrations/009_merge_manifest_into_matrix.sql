-- Migration: Merge tbl_manifest into smart_matrices
-- Description: Consolidates the Manifest entity (Business DNA & State) into the Smart Matrix entity for a sovereign architecture.

BEGIN;

-- 1. Add Manifest columns to Smart Matrices table
ALTER TABLE smart_matrices
ADD COLUMN IF NOT EXISTS business_dna JSONB DEFAULT '{}',
ADD COLUMN IF NOT EXISTS current_x FLOAT DEFAULT 0.0,
ADD COLUMN IF NOT EXISTS current_y FLOAT DEFAULT 0.0,
ADD COLUMN IF NOT EXISTS zoom_level FLOAT DEFAULT 1.0,
ADD COLUMN IF NOT EXISTS last_heartbeat TIMESTAMPTZ DEFAULT NOW(),
ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT TRUE,
ADD COLUMN IF NOT EXISTS master_context_id UUID REFERENCES tbl_contexts(context_id) ON DELETE SET NULL;

-- 2. Migrate data from tbl_manifest to smart_matrices
-- We join on smart_matrix_id to map the correct source data
UPDATE smart_matrices sm
SET 
    business_dna = tm.business_dna,
    current_x = tm.current_x,
    current_y = tm.current_y,
    zoom_level = tm.zoom_level,
    last_heartbeat = tm.last_heartbeat,
    is_active = tm.is_active,
    master_context_id = tm.master_context_id
FROM tbl_manifest tm
WHERE sm.id = tm.smart_matrix_id;

-- 3. Update related tables (Contexts)
-- Add smart_matrix_id to contexts table
ALTER TABLE tbl_contexts
ADD COLUMN IF NOT EXISTS smart_matrix_id UUID REFERENCES smart_matrices(id) ON DELETE CASCADE;

-- Populate smart_matrix_id based on the old manifest linkage
UPDATE tbl_contexts tc
SET smart_matrix_id = tm.smart_matrix_id
FROM tbl_manifest tm
WHERE tc.manifest_id = tm.manifest_id;

-- Make smart_matrix_id required for new contexts (after migration)
-- Note: We might have contexts without manifests if data is dirty, so we check first
-- ALTER TABLE tbl_contexts ALTER COLUMN smart_matrix_id SET NOT NULL; -- Keeping optional for safety

-- 4. Drop the old relationship column from contexts
ALTER TABLE tbl_contexts
DROP COLUMN IF EXISTS manifest_id;

-- 5. Drop the manifest reference from smart_matrices (the circular link)
ALTER TABLE smart_matrices
DROP COLUMN IF EXISTS manifest_id;

-- 6. Drop the tbl_manifest table entirely
DROP TABLE IF EXISTS tbl_manifest;

COMMIT;
