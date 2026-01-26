-- Migration: Change last_execution_time from TIMESTAMP to TEXT
-- Matches the pattern used for created_at and updated_at
-- Date: 2026-01-26

BEGIN;

-- Change the column type from TIMESTAMP WITH TIME ZONE to TEXT
ALTER TABLE tbl_canvas_nodes 
ALTER COLUMN last_execution_time TYPE TEXT;

-- Verify the change
DO $$
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_name = 'tbl_canvas_nodes' 
        AND column_name = 'last_execution_time'
        AND data_type = 'text'
    ) THEN
        RAISE NOTICE 'Successfully changed last_execution_time to TEXT';
    ELSE
        RAISE EXCEPTION 'Column type change failed';
    END IF;
END $$;

COMMIT;
