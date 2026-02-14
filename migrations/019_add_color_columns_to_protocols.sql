-- Migration: 019_add_color_columns_to_protocols.sql
-- Purpose: Add background_color and border_color columns to tbl_matrix_protocols
-- To support UI customization of matrix items based on protocol

ALTER TABLE tbl_matrix_protocols 
ADD COLUMN IF NOT EXISTS background_color TEXT,
ADD COLUMN IF NOT EXISTS border_color TEXT;

COMMENT ON COLUMN tbl_matrix_protocols.background_color IS 'Hex color code for UI background';
COMMENT ON COLUMN tbl_matrix_protocols.border_color IS 'Hex color code for UI borders';
