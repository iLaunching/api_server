-- Migration: 033_add_synapse_number_to_user_profiles.sql
-- Purpose: Ear Server lookups — unique synapse identifier and country on user_profiles

ALTER TABLE user_profiles
ADD COLUMN IF NOT EXISTS synapse_number VARCHAR(20);

ALTER TABLE user_profiles
ADD COLUMN IF NOT EXISTS country_code VARCHAR(5);

-- Unique index for lightning-fast lookups by synapse_number (Ear Server)
CREATE UNIQUE INDEX IF NOT EXISTS idx_synapse_number ON user_profiles(synapse_number);

COMMENT ON COLUMN user_profiles.synapse_number IS 'Unique public identifier for Ear Server and related routing';
COMMENT ON COLUMN user_profiles.country_code IS 'ISO-style country code for regional routing';
