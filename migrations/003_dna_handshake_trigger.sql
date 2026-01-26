-- Migration: DNA Handshake Trigger
-- Phase 2, Step 2.2: Context Layer (Tier B)
-- Purpose: Automatically inherit 'intent' from parent Manifest when a Context is created

-- Function to inherit DNA from parent manifest
CREATE OR REPLACE FUNCTION inherit_manifest_dna()
RETURNS TRIGGER AS $$
BEGIN
    -- Pull business_dna->>'intent' from parent manifest
    -- We assume business_dna is a JSONB object with an 'intent' key
    SELECT business_dna->>'intent' INTO NEW.inherited_intent
    FROM tbl_manifest
    WHERE manifest_id = NEW.manifest_id;
    
    -- If no intent is found (or manifest doesn't exist yet, which shouldn't happen due to FK),
    -- or if the intent field is missing in JSON, set a default placeholder
    IF NEW.inherited_intent IS NULL THEN
        NEW.inherited_intent := 'No intent defined in Manifest DNA';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger fires BEFORE INSERT to auto-populate inherited_intent
DROP TRIGGER IF EXISTS context_dna_handshake ON tbl_contexts;
CREATE TRIGGER context_dna_handshake
    BEFORE INSERT ON tbl_contexts
    FOR EACH ROW
    EXECUTE FUNCTION inherit_manifest_dna();

COMMENT ON FUNCTION inherit_manifest_dna IS 'Automatically populates context.inherited_intent from parent manifest.business_dna';
