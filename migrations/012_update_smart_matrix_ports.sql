-- ============================================================================
-- Migration 012: Update Smart Matrix Template Ports
-- Purpose: Add a default input port to the 'Smart Matrix' node template
--          to match the output connection ('any' type).
-- ============================================================================

UPDATE tbl_node_templates
SET port_template = '{
    "inputs": [
        {
            "id": "input", 
            "dataType": "any", 
            "label": "Master Input"
        }
    ],
    "outputs": [
        {
            "id": "output", 
            "dataType": "any", 
            "label": "Master Output"
        }
    ]
}'
WHERE node_type = 'smart-matrix';

-- ALSO update existing instances of Smart Matrix nodes
UPDATE tbl_canvas_nodes
SET port_config = '{
    "inputs": [
        {
            "id": "input", 
            "dataType": "any", 
            "label": "Master Input"
        }
    ],
    "outputs": [
        {
            "id": "output", 
            "dataType": "any", 
            "label": "Master Output"
        }
    ]
}'
WHERE node_type = 'smart-matrix';
