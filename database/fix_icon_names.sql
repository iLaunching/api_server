-- Fix icon names in icon_metadata table
-- Remove "fa" or "fa-" prefix from icon names since the frontend adds it

-- First, let's see what we're working with
SELECT 'BEFORE FIX - Sample icon names:' as status;
SELECT icon_name, icon_prefix, COUNT(*) as count
FROM icon_metadata
WHERE icon_name LIKE 'fa%'
GROUP BY icon_name, icon_prefix
ORDER BY icon_name
LIMIT 10;

-- Update icons that start with "fa-" (fa-dollar-sign -> dollar-sign)
-- This must come BEFORE the numeric update
UPDATE icon_metadata
SET icon_name = SUBSTRING(icon_name FROM 4)
WHERE icon_name LIKE 'fa-%';

-- Update numeric icons (fa0 -> 0, fa1 -> 1, etc.)
UPDATE icon_metadata 
SET icon_name = SUBSTRING(icon_name FROM 3)
WHERE icon_name ~ '^fa[0-9]+$';

-- Verify the changes
SELECT 'AFTER FIX - Sample icon names:' as status;
SELECT icon_name, icon_prefix, COUNT(*) as count
FROM icon_metadata
GROUP BY icon_name, icon_prefix
ORDER BY icon_name
LIMIT 20;
