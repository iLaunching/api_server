-- ============================================================================
-- Migration 011: Add Smart Router Template
-- Purpose: Add a new node template for 'Smart Router' with multiple output ports
--          to satisfy the "one input, multiple outputs" requirement.
-- ============================================================================

INSERT INTO tbl_node_templates (
    template_name, node_type, allowed_context_types,
    default_width, default_height, default_color, shape_type, icon,
    port_template, category, description, renderer_class
) VALUES
(
    'Smart Router',
    'smart-router',
    ARRAY['ROUTER', 'WORKFLOW', 'CAMPAIGN'],
    250, 200, '#f59e0b', 'hexagon', '🔀',
    '{
        "inputs": [{"id": "input", "dataType": "any", "label": "Input"}],
        "outputs": [
            {"id": "route-a", "dataType": "any", "label": "Route A"},
            {"id": "route-b", "dataType": "any", "label": "Route B"},
            {"id": "route-c", "dataType": "any", "label": "Route C"},
            {"id": "fallback", "dataType": "any", "label": "Fallback"}
        ]
    }',
    'logic',
    'Intelligent routing with multiple output paths',
    'DefaultNodeRenderer'
)
ON CONFLICT (node_type) DO UPDATE SET
    port_template = EXCLUDED.port_template,
    allowed_context_types = EXCLUDED.allowed_context_types,
    template_name = EXCLUDED.template_name,
    description = EXCLUDED.description;
