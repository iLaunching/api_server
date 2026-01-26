-- Migration: Rename metadata column to node_metadata
-- Fixes SQLAlchemy reserved name conflict
-- Date: 2026-01-26

BEGIN;

-- Rename the metadata column to node_metadata in tbl_canvas_nodes
ALTER TABLE tbl_canvas_nodes 
RENAME COLUMN metadata TO node_metadata;

-- Verify the change
DO $$
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'tbl_canvas_nodes' 
        AND column_name = 'node_metadata'
    ) THEN
        RAISE NOTICE 'Successfully renamed metadata to node_metadata';
    ELSE
        RAISE EXCEPTION 'Column rename failed';
    END IF;
END $$;

COMMIT;
