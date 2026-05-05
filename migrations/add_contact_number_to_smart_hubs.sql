-- Add contact_number column to smart_hubs
-- Matches sizing of user_profiles.phone (VARCHAR(20), nullable)

ALTER TABLE smart_hubs
ADD COLUMN IF NOT EXISTS contact_number VARCHAR(20);

COMMENT ON COLUMN smart_hubs.contact_number IS
'Optional hub-level contact phone number (same sizing as user_profiles.phone)';

-- Verify column exists
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'smart_hubs' AND column_name = 'contact_number';

