-- Migration: 015_add_protocol_to_contexts.sql
-- Purpose: Link contexts to matrix protocols
-- This establishes the relationship between Master Context and the current protocol phase

-- Add the protocol relationship column
ALTER TABLE tbl_contexts 
ADD COLUMN IF NOT EXISTS current_protocol_id UUID REFERENCES tbl_matrix_protocols(protocol_id);

-- Add index for fast protocol lookups
CREATE INDEX IF NOT EXISTS idx_context_protocol ON tbl_contexts(current_protocol_id);

-- Add comment
COMMENT ON COLUMN tbl_contexts.current_protocol_id IS 'Links the Master Context to a specific protocol path (Genesis, Campaign, Validation)';

-- Optional: Set default protocol for existing contexts (Genesis as starting point)
UPDATE tbl_contexts 
SET current_protocol_id = (
    SELECT protocol_id 
    FROM tbl_matrix_protocols 
    WHERE protocol_key = 'GENESIS' 
    LIMIT 1
)
WHERE current_protocol_id IS NULL 
  AND is_master_context = TRUE;
