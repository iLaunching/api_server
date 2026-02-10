-- Migration: 017_add_dna_to_contexts.sql
-- Purpose: Link contexts to DNA profiles (global and local)
-- This establishes the "Soul" (global) and "Role" (local) DNA relationships

-- Add DNA profile relationships
ALTER TABLE tbl_contexts 
-- The "Soul": Constant across the whole account
ADD COLUMN IF NOT EXISTS global_user_dna_id UUID REFERENCES tbl_dna_profiles(dna_id),
-- The "Role": Specific and programmable for THIS Matrix only
ADD COLUMN IF NOT EXISTS local_matrix_dna_id UUID REFERENCES tbl_dna_profiles(dna_id);

-- Add indexes for fast DNA lookups
CREATE INDEX IF NOT EXISTS idx_context_global_dna ON tbl_contexts(global_user_dna_id);
CREATE INDEX IF NOT EXISTS idx_context_local_dna ON tbl_contexts(local_matrix_dna_id);

-- Add comments
COMMENT ON COLUMN tbl_contexts.global_user_dna_id IS 'The "Soul" - Global user DNA constant across all matrices in the account';
COMMENT ON COLUMN tbl_contexts.local_matrix_dna_id IS 'The "Role" - Local matrix-specific DNA programmable for this context only';
