-- Rename user_profiles.phone -> user_profiles.phone_e164 (E.164 format)
-- Keeps existing data, avoids failure if constraints differ across environments.

DO $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_name = 'user_profiles'
      AND column_name = 'phone'
  ) AND NOT EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_name = 'user_profiles'
      AND column_name = 'phone_e164'
  ) THEN
    EXECUTE 'ALTER TABLE user_profiles RENAME COLUMN phone TO phone_e164';
  END IF;
END $$;

COMMENT ON COLUMN user_profiles.phone_e164 IS 'User phone number in E.164 format';

SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'user_profiles'
  AND column_name IN ('phone', 'phone_e164');

