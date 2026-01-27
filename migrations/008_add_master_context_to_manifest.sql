-- Migration 008: Add master_context_id to manifest
-- Optimizes canvas loading by eliminating separate context query
-- Date: 2026-01-27

BEGIN;

-- Add master_context_id column to tbl_manifest
ALTER TABLE tbl_manifest 
ADD COLUMN master_context_id UUID;

-- Add foreign key constraint
ALTER TABLE tbl_manifest
ADD CONSTRAINT fk_manifest_master_context
FOREIGN KEY (master_context_id) 
REFERENCES tbl_contexts(context_id)
ON DELETE SET NULL;

-- Create index for faster lookups
CREATE INDEX idx_manifest_master_context_id 
ON tbl_manifest(master_context_id);

-- Backfill existing manifests with their master context IDs
UPDATE tbl_manifest m
SET master_context_id = (
    SELECT c.context_id 
    FROM tbl_contexts c 
    WHERE c.manifest_id = m.manifest_id 
    AND c.is_master_context = true
    LIMIT 1
);

-- Verify backfill
DO $$
DECLARE
    total_manifests INTEGER;
    linked_manifests INTEGER;
BEGIN
    SELECT COUNT(*) INTO total_manifests FROM tbl_manifest;
    SELECT COUNT(*) INTO linked_manifests FROM tbl_manifest WHERE master_context_id IS NOT NULL;
    
    RAISE NOTICE 'Migration 008: % of % manifests linked to master contexts', linked_manifests, total_manifests;
END $$;

COMMIT;
