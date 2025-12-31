-- Migration: Add canvas grid settings to smart_hubs table
-- Date: 2025-12-31
-- Description: Adds show_grid, grid_style, and snap_to_grid columns for SmartMatrix canvas configuration

BEGIN;

-- Add show_grid column (default: false)
ALTER TABLE smart_hubs 
ADD COLUMN IF NOT EXISTS show_grid BOOLEAN DEFAULT false NOT NULL;

-- Add grid_style column (default: 'line', options: 'line' or 'dotted')
ALTER TABLE smart_hubs 
ADD COLUMN IF NOT EXISTS grid_style TEXT DEFAULT 'line' NOT NULL
CHECK (grid_style IN ('line', 'dotted'));

-- Add snap_to_grid column (default: false)
ALTER TABLE smart_hubs 
ADD COLUMN IF NOT EXISTS snap_to_grid BOOLEAN DEFAULT false NOT NULL;

-- Add comments for documentation
COMMENT ON COLUMN smart_hubs.show_grid IS 'Whether to display the grid in the SmartMatrix canvas';
COMMENT ON COLUMN smart_hubs.grid_style IS 'Grid display style: ''line'' for line grid or ''dotted'' for dotted grid';
COMMENT ON COLUMN smart_hubs.snap_to_grid IS 'Whether nodes should snap to the grid when dragged';

COMMIT;
