-- Add smart hub icon and avatar display columns
-- Adds smartHub_icon_id and avatar_display_option_value_id to smart_hubs table

-- Add smartHub_icon_id column (FK to option_values for avatar_library)
ALTER TABLE smart_hubs 
ADD COLUMN IF NOT EXISTS smartHub_icon_id INTEGER;

-- Add foreign key constraint for smartHub_icon_id
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'fk_smart_hubs_smartHub_icon_id'
    ) THEN
        ALTER TABLE smart_hubs
        ADD CONSTRAINT fk_smart_hubs_smartHub_icon_id
        FOREIGN KEY (smartHub_icon_id) 
        REFERENCES option_values(id) 
        ON DELETE SET NULL;
    END IF;
END $$;

-- Add index for smartHub_icon_id
CREATE INDEX IF NOT EXISTS idx_smart_hubs_smartHub_icon_id 
ON smart_hubs(smartHub_icon_id);

-- Add avatar_display_option_value_id column with default value 24
ALTER TABLE smart_hubs 
ADD COLUMN IF NOT EXISTS avatar_display_option_value_id INTEGER DEFAULT 24;

-- Add index for avatar_display_option_value_id
CREATE INDEX IF NOT EXISTS idx_smart_hubs_avatar_display_option_value_id 
ON smart_hubs(avatar_display_option_value_id);

-- Verify columns were added
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'smart_hubs' 
AND column_name IN ('smartHub_icon_id', 'avatar_display_option_value_id');
