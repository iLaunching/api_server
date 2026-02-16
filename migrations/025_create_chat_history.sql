CREATE TABLE IF NOT EXISTS tbl_chat_history (
    chat_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- THE 1:1:1 TRIANGLE
    context_id UUID UNIQUE NOT NULL REFERENCES tbl_contexts(context_id) ON DELETE CASCADE,
    node_id UUID UNIQUE REFERENCES tbl_canvas_nodes(node_id) ON DELETE CASCADE,
    
    -- THE FLAG
    is_master_chat BOOLEAN NOT NULL DEFAULT FALSE,

    -- THE DOCUMENT (TipTap JSON)
    document_json JSONB NOT NULL DEFAULT '{"type": "doc", "content": []}',
    
    -- META DATA
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Index for faster lookups
CREATE INDEX IF NOT EXISTS idx_chat_history_context_id ON tbl_chat_history(context_id);
CREATE INDEX IF NOT EXISTS idx_chat_history_node_id ON tbl_chat_history(node_id);
