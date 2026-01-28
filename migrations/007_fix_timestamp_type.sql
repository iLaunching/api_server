-- Migration: Change timestamp columns from TIMESTAMP to TEXT
-- Matches the pattern used throughout the codebase (ISO 8601 strings)
-- Date: 2026-01-26

BEGIN;

-- Change all timestamp columns from TIMESTAMP WITH TIME ZONE to TEXT
ALTER TABLE tbl_canvas_nodes 
ALTER COLUMN last_execution_time TYPE TEXT;

ALTER TABLE tbl_canvas_nodes 
ALTER COLUMN created_at TYPE TEXT;

ALTER TABLE tbl_canvas_nodes 
ALTER COLUMN updated_at TYPE TEXT;

-- Verify the changes
DO $$
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'tbl_canvas_nodes' 
        AND column_name IN ('last_execution_time', 'created_at', 'updated_at')
        AND data_type = 'text'
        HAVING COUNT(*) = 3
    ) THEN
        RAISE NOTICE 'Successfully changed all timestamp columns to TEXT';
    ELSE
        RAISE EXCEPTION 'Column type changes failed';
    END IF;
END $$;

COMMIT;
