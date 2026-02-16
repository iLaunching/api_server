-- Optimize Chat History for Sovereign Speed

-- 1. Ensure node_id loopcup is O(1)
-- Note: node_id is already UNIQUE in the table definition, which creates an implicit index.
-- We add an explicit index name if it doesn't exist, or just rely on the constraint.
-- To be safe and explicit as requested:
CREATE UNIQUE INDEX IF NOT EXISTS idx_chat_lookup_node ON tbl_chat_history (node_id);

-- 2. Enable deep JSON search with GIN index
-- fast retrieval of keys and values within the document_json
CREATE INDEX IF NOT EXISTS idx_chat_json_search ON tbl_chat_history USING GIN (document_json jsonb_path_ops);
