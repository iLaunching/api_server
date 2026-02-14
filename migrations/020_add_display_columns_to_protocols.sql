-- Migration: 020_add_display_columns_to_protocols.sql
-- Purpose: Add display_name and display_description columns to tbl_matrix_protocols
-- To support user-friendly display text in the UI

ALTER TABLE tbl_matrix_protocols 
ADD COLUMN IF NOT EXISTS display_name VARCHAR(100),
ADD COLUMN IF NOT EXISTS display_description TEXT;

COMMENT ON COLUMN tbl_matrix_protocols.display_name IS 'Human-readable name for the protocol phase';
COMMENT ON COLUMN tbl_matrix_protocols.display_description IS 'Detailed description for UI display';

-- Update existing records with defaults based on key
UPDATE tbl_matrix_protocols SET display_name = 'Genesis Phase', display_description = 'Initial setup and foundation building phase' WHERE protocol_key = 'GENESIS';
UPDATE tbl_matrix_protocols SET display_name = 'Campaign Phase', display_description = 'Execution and growth phase' WHERE protocol_key = 'CAMPAIGN';
UPDATE tbl_matrix_protocols SET display_name = 'Validation Phase', display_description = 'Quality assurance and compliance phase' WHERE protocol_key = 'VALIDATION';
