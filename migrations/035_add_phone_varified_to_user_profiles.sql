-- Add phone_varified to user_profiles
-- Boolean, default false (matches requested naming)

ALTER TABLE user_profiles
ADD COLUMN IF NOT EXISTS phone_varified BOOLEAN DEFAULT FALSE NOT NULL;

COMMENT ON COLUMN user_profiles.phone_varified IS 'Whether phone number has been verified';

SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'user_profiles' AND column_name = 'phone_varified';

