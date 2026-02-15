-- Migration: Add UI Theme and Assets columns to Matrix Protocols
-- Date: 2026-02-15

-- Add ui_theme column (JSONB)
ALTER TABLE tbl_matrix_protocols 
ADD COLUMN IF NOT EXISTS ui_theme JSONB DEFAULT '{}';

-- Add ui_assets column (JSONB)
ALTER TABLE tbl_matrix_protocols 
ADD COLUMN IF NOT EXISTS ui_assets JSONB DEFAULT '{}';

-- Comment on columns
COMMENT ON COLUMN tbl_matrix_protocols.ui_theme IS 'Stores UI theme customization (colors, fonts)';
COMMENT ON COLUMN tbl_matrix_protocols.ui_assets IS 'Stores UI assets (icons, images, logos)';
