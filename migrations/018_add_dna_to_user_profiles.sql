-- Migration: 018_add_dna_to_user_profiles.sql
-- Purpose: Link user profiles to global DNA
-- This establishes the "Soul" - the constant DNA across the whole account

-- Add global DNA reference to user profiles
ALTER TABLE user_profiles 
-- The "Soul": Constant across the whole account
ADD COLUMN IF NOT EXISTS global_user_dna_id UUID REFERENCES tbl_dna_profiles(dna_id);

-- Add index for fast DNA lookups
CREATE INDEX IF NOT EXISTS idx_user_profiles_global_dna ON user_profiles(global_user_dna_id);

-- Add comment
COMMENT ON COLUMN user_profiles.global_user_dna_id IS 'The "Soul" - Global user DNA constant across all matrices and contexts in the account';
