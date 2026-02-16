-- Ensure user_id is NOT NULL (if it contains nulls, we might need to handle them, assuming empty or valid for now)
-- Note: 'user_id' was added in 029.
ALTER TABLE tbl_matrix_audit_logs ALTER COLUMN user_id SET NOT NULL;

-- Ensure executed_by is NOT NULL
ALTER TABLE tbl_matrix_audit_logs ALTER COLUMN executed_by SET NOT NULL;

-- Indexing for "Who did what"
CREATE INDEX IF NOT EXISTS idx_audit_attribution ON tbl_matrix_audit_logs (user_id, executed_by);
