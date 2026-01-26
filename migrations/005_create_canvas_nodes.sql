-- ============================================================================
-- Phase 3: Canvas Nodes (Tier C) - The Cells
-- Migration 005: Create canvas nodes and connections tables
-- ============================================================================

-- Create fn_update_timestamp if it doesn't exist
CREATE OR REPLACE FUNCTION fn_update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- Table: tbl_canvas_nodes
-- Purpose: Individual nodes on the spatial canvas
-- ============================================================================

CREATE TABLE tbl_canvas_nodes (
    -- BASE IDENTITY & NAMING
    node_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    context_id UUID NOT NULL REFERENCES tbl_contexts(context_id) ON DELETE CASCADE,
    node_name VARCHAR(255) NOT NULL,
    node_description TEXT,
    node_type VARCHAR(50) NOT NULL, -- 'smart-matrix', 'email', 'webhook', 'router', etc.
    
    -- SPATIAL DATA (World Coordinates)
    pos_x FLOAT NOT NULL,
    pos_y FLOAT NOT NULL,
    width FLOAT DEFAULT 200,
    height FLOAT DEFAULT 150,
    
    -- VISUAL PROPERTIES
    color VARCHAR(20) DEFAULT '#3b82f6',
    background_color VARCHAR(20),
    text_color VARCHAR(20),
    
    -- PORT CONFIGURATION
    -- Stores port definitions with metadata
    port_config JSONB DEFAULT '{
        "inputs": [],
        "outputs": []
    }',
    
    -- THE "SOVEREIGN" TOGGLE (Master Bridge)
    is_master_bridge BOOLEAN DEFAULT FALSE,
    
    -- MULTI-SOURCE INPUT (The Semantic Vacuum)
    bridge_inputs JSONB DEFAULT '{
        "source_node_ids": [], 
        "source_context_ids": [],
        "last_synthesis_at": null
    }',
    
    -- DYNAMIC CAPABILITIES (Logic Forge Output)
    node_dna_overrides JSONB DEFAULT '{}',
    
    -- OPERATIONAL & VISUAL STATES
    operational_status VARCHAR(20) DEFAULT 'IDLE',
    visual_state VARCHAR(20) DEFAULT 'IDLE',
    is_selected BOOLEAN DEFAULT FALSE,
    is_hovered BOOLEAN DEFAULT FALSE,
    
    -- EXECUTION METADATA
    execution_count INTEGER DEFAULT 0,
    last_execution_time TIMESTAMP WITH TIME ZONE,
    error_message TEXT,
    
    -- CUSTOM METADATA (for node-specific config)
    node_metadata JSONB DEFAULT '{}',
    
    -- TRACEABILITY
    reference_data_id UUID,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance
CREATE INDEX idx_nodes_position ON tbl_canvas_nodes(pos_x, pos_y);
CREATE INDEX idx_nodes_context ON tbl_canvas_nodes(context_id);
CREATE INDEX idx_nodes_type ON tbl_canvas_nodes(node_type);
CREATE INDEX idx_nodes_master_bridge ON tbl_canvas_nodes(is_master_bridge) WHERE is_master_bridge IS TRUE;
CREATE INDEX idx_nodes_port_config ON tbl_canvas_nodes USING GIN (port_config);

-- Trigger for updated_at
CREATE TRIGGER trg_nodes_updated_at
    BEFORE UPDATE ON tbl_canvas_nodes
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

-- ============================================================================
-- Table: tbl_node_connections
-- Purpose: Connections (links) between node ports
-- ============================================================================

CREATE TABLE tbl_node_connections (
    -- IDENTITY
    connection_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- SOURCE (Output Port)
    source_node_id UUID NOT NULL REFERENCES tbl_canvas_nodes(node_id) ON DELETE CASCADE,
    source_port_id VARCHAR(50) NOT NULL,
    
    -- TARGET (Input Port)
    target_node_id UUID NOT NULL REFERENCES tbl_canvas_nodes(node_id) ON DELETE CASCADE,
    target_port_id VARCHAR(50) NOT NULL,
    
    -- VISUAL & ANIMATION
    color VARCHAR(20) DEFAULT '#3b82f6',
    animated BOOLEAN DEFAULT TRUE,
    pulse_speed INTEGER DEFAULT 200, -- ms per pulse cycle
    
    -- CONNECTION STATE
    status VARCHAR(20) DEFAULT 'idle', -- 'idle', 'active', 'error'
    
    -- BEZIER CURVE METADATA (Optional - for analytics/debugging)
    curve_metadata JSONB DEFAULT '{
        "control_offset": null,
        "path_length": null,
        "last_calculated": null
    }',
    
    -- TRACEABILITY
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- CONSTRAINTS
    -- Ensure unique connections (no duplicate links)
    UNIQUE(source_node_id, source_port_id, target_node_id, target_port_id)
);

-- Indexes for efficient queries
CREATE INDEX idx_connections_source ON tbl_node_connections(source_node_id);
CREATE INDEX idx_connections_target ON tbl_node_connections(target_node_id);
CREATE INDEX idx_connections_source_port ON tbl_node_connections(source_node_id, source_port_id);
CREATE INDEX idx_connections_target_port ON tbl_node_connections(target_node_id, target_port_id);

-- Trigger for updated_at
CREATE TRIGGER trg_connections_updated_at
    BEFORE UPDATE ON tbl_node_connections
    FOR EACH ROW
    EXECUTE FUNCTION fn_update_timestamp();

-- ============================================================================
-- Table: tbl_node_templates (Node Library)
-- Purpose: Define available node types and their default configurations
-- ============================================================================

CREATE TABLE tbl_node_templates (
    template_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    template_name VARCHAR(255) NOT NULL,
    node_type VARCHAR(50) NOT NULL UNIQUE, -- 'email-sender', 'router', etc.
    
    -- Context compatibility
    allowed_context_types VARCHAR(50)[] DEFAULT '{}', -- ['CAMPAIGN', 'WORKFLOW']
    
    -- Visual defaults
    default_width FLOAT DEFAULT 200,
    default_height FLOAT DEFAULT 150,
    default_color VARCHAR(20) DEFAULT '#3b82f6',
    shape_type VARCHAR(50) DEFAULT 'rectangle', -- 'circle', 'rectangle', 'hexagon'
    icon VARCHAR(10), -- Emoji or icon identifier
    
    -- Port configuration template
    port_template JSONB DEFAULT '{
        "inputs": [],
        "outputs": []
    }',
    
    -- Custom renderer (optional)
    renderer_class VARCHAR(100), -- 'SmartMatrixNodeRenderer', 'EmailNodeRenderer'
    
    -- Metadata
    description TEXT,
    category VARCHAR(50), -- 'communication', 'logic', 'data', 'ai'
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for fast lookups
CREATE INDEX idx_templates_context_type ON tbl_node_templates USING GIN (allowed_context_types);
CREATE INDEX idx_templates_category ON tbl_node_templates(category);
CREATE INDEX idx_templates_active ON tbl_node_templates(is_active) WHERE is_active IS TRUE;

-- ============================================================================
-- Seed Data: Default Node Templates
-- ============================================================================

INSERT INTO tbl_node_templates (
    template_name, node_type, allowed_context_types,
    default_width, default_height, default_color, shape_type, icon,
    port_template, category, description, renderer_class
) VALUES
(
    'Smart Matrix',
    'smart-matrix',
    ARRAY['GENESIS'],
    250, 250, '#8b5cf6', 'circle', '🧠',
    '{
        "inputs": [],
        "outputs": [{"id": "output", "dataType": "any", "label": "Output"}]
    }',
    'ai',
    'AI-powered decision engine with dynamic port rotation',
    'SmartMatrixNodeRenderer'
),
(
    'Email Sender',
    'email-sender',
    ARRAY['CAMPAIGN', 'WORKFLOW'],
    200, 150, '#3b82f6', 'rectangle', '📧',
    '{
        "inputs": [{"id": "trigger", "dataType": "event", "label": "Trigger"}],
        "outputs": [{"id": "sent", "dataType": "event", "label": "Sent"}]
    }',
    'communication',
    'Send emails to your audience',
    'DefaultNodeRenderer'
),
(
    'Condition Router',
    'condition-router',
    ARRAY['ROUTER', 'WORKFLOW'],
    220, 180, '#f59e0b', 'hexagon', '🔀',
    '{
        "inputs": [{"id": "input", "dataType": "any", "label": "Input"}],
        "outputs": [
            {"id": "true-path", "dataType": "any", "label": "True"},
            {"id": "false-path", "dataType": "any", "label": "False"}
        ]
    }',
    'logic',
    'Route data based on conditions',
    'DefaultNodeRenderer'
);

-- ============================================================================
-- Comments for documentation
-- ============================================================================

COMMENT ON TABLE tbl_canvas_nodes IS 'Individual nodes on the spatial canvas with dynamic port rotation support';
COMMENT ON TABLE tbl_node_connections IS 'Connections between node ports with Bezier curve rendering support';
COMMENT ON TABLE tbl_node_templates IS 'Node library templates defining available node types per context';

COMMENT ON COLUMN tbl_canvas_nodes.port_config IS 'JSONB storing port definitions with dynamic positioning metadata';
COMMENT ON COLUMN tbl_canvas_nodes.is_master_bridge IS 'Sovereign toggle for Master Bridge synthesis capability';
COMMENT ON COLUMN tbl_canvas_nodes.bridge_inputs IS 'Multi-source input tracking for semantic vacuum';

COMMENT ON COLUMN tbl_node_connections.pulse_speed IS 'Animation speed in milliseconds per pulse cycle';
COMMENT ON COLUMN tbl_node_connections.curve_metadata IS 'Optional Bezier curve analytics (calculated client-side)';
