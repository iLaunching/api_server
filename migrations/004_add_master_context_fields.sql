-- Migration: Add Master Context columns to tbl_contexts
-- Purpose: Enable "Soul" identification, AI-led DNA payload, and heartbeat sync for Master Bridge Node.

-- Add is_master_context column
ALTER TABLE tbl_contexts 
ADD COLUMN IF NOT EXISTS is_master_context BOOLEAN DEFAULT FALSE;

-- Add master_dna_payload column
ALTER TABLE tbl_contexts 
ADD COLUMN IF NOT EXISTS master_dna_payload JSONB DEFAULT '{}';

-- Add sync_heartbeat column
ALTER TABLE tbl_contexts 
ADD COLUMN IF NOT EXISTS sync_heartbeat TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP;

-- Create GIN index for fast AI retrieval of DNA
CREATE INDEX IF NOT EXISTS idx_master_dna ON tbl_contexts USING GIN (master_dna_payload);

-- Add comments
COMMENT ON COLUMN tbl_contexts.is_master_context IS 'FLAG: Identifies the "Soul" of the business';
COMMENT ON COLUMN tbl_contexts.master_dna_payload IS 'THE DNA: AI-led architecture keys like "revenue_engine" or "market_shadow"';
COMMENT ON COLUMN tbl_contexts.sync_heartbeat IS 'THE HEARTBEAT: Essential for real-time sync with the Master Bridge Node';
