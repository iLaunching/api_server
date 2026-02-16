ALTER TABLE tbl_matrix_audit_logs 
ADD COLUMN IF NOT EXISTS smart_matrix_id UUID,
ADD COLUMN IF NOT EXISTS user_id UUID,
ADD COLUMN IF NOT EXISTS smart_hub_id UUID;

-- Security Indexing: This prevents "Data Leaks" between different hubs/users
CREATE INDEX IF NOT EXISTS idx_audit_security_lookup ON tbl_matrix_audit_logs (smart_hub_id, user_id);
