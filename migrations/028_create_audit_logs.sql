CREATE TABLE IF NOT EXISTS tbl_matrix_audit_logs (
    log_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- LINKS: The 'Who' and 'Where'
    node_id UUID REFERENCES tbl_canvas_nodes(node_id) ON DELETE SET NULL,
    context_id UUID REFERENCES tbl_contexts(context_id) ON DELETE SET NULL,
    
    -- ACTION: The 'What'
    -- Examples: 'GENESIS', 'OKRs_UPDATED', 'DNA_SHIFT', 'STATE_CHANGE'
    action_type VARCHAR(50) NOT NULL,
    
    -- DATA: The 'Before' and 'After' for the Diff
    previous_state JSONB, 
    new_state JSONB,
    
    -- INTENT: The 'Why'
    reasoning TEXT, 
    executed_by VARCHAR(50) DEFAULT 'AI_ORCHESTRATOR',
    
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- INDEXING: For Master-level and Node-level speed
CREATE INDEX IF NOT EXISTS idx_audit_node_time ON tbl_matrix_audit_logs (node_id, timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_audit_global_time ON tbl_matrix_audit_logs (timestamp DESC);
