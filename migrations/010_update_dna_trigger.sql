-- Migration: Update DNA Handshake Trigger for Smart Matrix
-- Fixes: relation "tbl_manifest" does not exist error
-- Updates trigger to use smart_matrices instead of obsolete tbl_manifest

-- 1. Drop old trigger and function
DROP TRIGGER IF EXISTS context_dna_handshake ON tbl_contexts;
DROP FUNCTION IF EXISTS inherit_manifest_dna();

-- 2. Create new function to inherit from SmartMatrix
CREATE OR REPLACE FUNCTION inherit_smart_matrix_dna()
RETURNS TRIGGER AS $$
BEGIN
    -- Pull business_dna->>'intent' from parent SmartMatrix
    SELECT business_dna->>'intent' INTO NEW.inherited_intent
    FROM smart_matrices
    WHERE id = NEW.smart_matrix_id;
    
    -- If no intent is found, set default
    IF NEW.inherited_intent IS NULL THEN
        NEW.inherited_intent := 'No intent defined in Smart Matrix DNA';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 3. Re-attach trigger
CREATE TRIGGER context_dna_handshake
    BEFORE INSERT ON tbl_contexts
    FOR EACH ROW
    EXECUTE FUNCTION inherit_smart_matrix_dna();

COMMENT ON FUNCTION inherit_smart_matrix_dna IS 'Automatically populates context.inherited_intent from parent smart_matrix.business_dna';
