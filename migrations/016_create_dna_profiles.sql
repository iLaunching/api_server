-- Migration: 016_create_dna_profiles.sql
-- Purpose: Create the Universal DNA Template table
-- This is the "Pure Vessel" - a dynamic container where AI creates the structure

-- 1. The Universal DNA Template (Pure Vessel)
CREATE TABLE IF NOT EXISTS tbl_dna_profiles (
    dna_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- THE DYNAMIC PROGRAMMING BLOCK
    -- We start with an empty JSON object. 
    -- The AI is responsible for creating the keys, the nesting, and the logic.
    dna_payload JSONB DEFAULT '{}',
    
    is_global_user_dna BOOLEAN DEFAULT FALSE,
    last_synthesis TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Index for fast lookup of global user DNA
CREATE INDEX IF NOT EXISTS idx_dna_global_user ON tbl_dna_profiles(is_global_user_dna) WHERE is_global_user_dna = TRUE;

-- Index for JSONB payload queries (GIN index for efficient JSONB operations)
CREATE INDEX IF NOT EXISTS idx_dna_payload ON tbl_dna_profiles USING GIN (dna_payload);

-- Index for last synthesis timestamp
CREATE INDEX IF NOT EXISTS idx_dna_last_synthesis ON tbl_dna_profiles(last_synthesis DESC);

-- Add comments
COMMENT ON TABLE tbl_dna_profiles IS 'Universal DNA Template - Pure vessel for AI-driven dynamic programming';
COMMENT ON COLUMN tbl_dna_profiles.dna_payload IS 'Dynamic JSONB container where AI creates structure, keys, and logic';
COMMENT ON COLUMN tbl_dna_profiles.is_global_user_dna IS 'Indicates if this is a global user-level DNA profile';
COMMENT ON COLUMN tbl_dna_profiles.last_synthesis IS 'Timestamp of last DNA synthesis/update';
