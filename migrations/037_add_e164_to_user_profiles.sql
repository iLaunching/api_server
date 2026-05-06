-- Migration 037: Add e164 column to user_profiles
-- Stores a phone number in E.164 format (VARCHAR(20), nullable)

ALTER TABLE user_profiles
ADD COLUMN IF NOT EXISTS e164 VARCHAR(20);

COMMENT ON COLUMN user_profiles.e164 IS 'Phone number in E.164 format';

SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'user_profiles' AND column_name = 'e164';

