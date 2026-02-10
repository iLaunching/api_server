-- Migration: 013_create_node_definitions.sql
-- Purpose: Create the Node Definition Library table
-- This table serves as the "DNA Catalog" for spawnable nodes in the Smart Matrix

-- Create the node definitions table
CREATE TABLE IF NOT EXISTS tbl_node_definitions (
    def_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    category VARCHAR(50) NOT NULL,      -- 'GENESIS', 'CAMPAIGN', 'VALIDATION'
    display_name VARCHAR(100) NOT NULL, -- e.g., 'Web Scraper', 'Email Actuator'
    description TEXT,                   -- Detailed purpose for user and AI
    icon_name VARCHAR(50),              -- Lucide/FontAwesome icon key
    node_type VARCHAR(50),              -- e.g., 'action', 'trigger', 'logic'
    
    -- INITIAL DNA: Stores the base instructions the AI will refactor via overrides
    default_config JSONB DEFAULT '{
        "base_prompt": "",
        "required_inputs": [],
        "loop_logic": "fixed"
    }',
    
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Index for fast category filtering in the dropdown menu
CREATE INDEX IF NOT EXISTS idx_node_def_category ON tbl_node_definitions(category);

-- Index for active definitions
CREATE INDEX IF NOT EXISTS idx_node_def_active ON tbl_node_definitions(is_active) WHERE is_active = TRUE;

-- Seed data: Initial node definitions
INSERT INTO tbl_node_definitions (category, display_name, description, icon_name, node_type, default_config) VALUES
-- GENESIS Phase Nodes
('GENESIS', 'Web Scraper', 'Extract structured data from websites using AI-powered scraping. Ideal for competitor research, market analysis, and data collection.', 'globe', 'action', '{
    "base_prompt": "Extract structured data from the provided URL. Analyze the page structure and return data in the requested format.",
    "required_inputs": ["url", "data_schema"],
    "loop_logic": "fixed",
    "capabilities": ["html_parsing", "data_extraction", "schema_validation"]
}'),

('GENESIS', 'Email Actuator', 'Send automated, personalized emails based on triggers and templates. Perfect for outreach campaigns and follow-ups.', 'mail', 'action', '{
    "base_prompt": "Compose and send a personalized email based on the provided context and template.",
    "required_inputs": ["recipient", "subject", "template"],
    "loop_logic": "fixed",
    "capabilities": ["email_composition", "personalization", "delivery_tracking"]
}'),

('GENESIS', 'Data Validator', 'Validate and clean incoming data to ensure quality and consistency before processing.', 'check-square', 'validation', '{
    "base_prompt": "Validate the incoming data against the specified rules and flag any issues.",
    "required_inputs": ["data", "validation_rules"],
    "loop_logic": "fixed",
    "capabilities": ["data_validation", "error_detection", "quality_assurance"]
}'),

('GENESIS', 'API Connector', 'Connect to external APIs to fetch or send data. Supports REST, GraphQL, and webhooks.', 'link', 'action', '{
    "base_prompt": "Make an API request to the specified endpoint and handle the response.",
    "required_inputs": ["endpoint", "method", "headers"],
    "loop_logic": "fixed",
    "capabilities": ["api_integration", "authentication", "response_parsing"]
}'),

-- CAMPAIGN Phase Nodes
('CAMPAIGN', 'Lead Scorer', 'Analyze and score leads based on engagement metrics, demographics, and behavior patterns.', 'target', 'logic', '{
    "base_prompt": "Analyze the lead data and assign a score based on the scoring criteria.",
    "required_inputs": ["lead_data", "scoring_criteria"],
    "loop_logic": "batch",
    "capabilities": ["lead_analysis", "scoring_algorithm", "prioritization"]
}'),

('CAMPAIGN', 'Content Generator', 'Generate personalized content for campaigns using AI. Supports emails, social posts, and ad copy.', 'file-text', 'action', '{
    "base_prompt": "Generate engaging content based on the campaign brief and target audience.",
    "required_inputs": ["campaign_brief", "target_audience", "content_type"],
    "loop_logic": "fixed",
    "capabilities": ["content_creation", "personalization", "tone_adaptation"]
}'),

('CAMPAIGN', 'Engagement Tracker', 'Track and analyze user engagement across multiple channels (email, social, web).', 'activity', 'trigger', '{
    "base_prompt": "Monitor engagement events and trigger actions based on user behavior.",
    "required_inputs": ["user_id", "engagement_events"],
    "loop_logic": "continuous",
    "capabilities": ["event_tracking", "behavior_analysis", "trigger_logic"]
}'),

('CAMPAIGN', 'A/B Test Manager', 'Manage and analyze A/B tests for campaigns to optimize performance.', 'git-branch', 'logic', '{
    "base_prompt": "Set up and analyze A/B tests, providing statistical insights and recommendations.",
    "required_inputs": ["test_variants", "success_metrics"],
    "loop_logic": "batch",
    "capabilities": ["test_management", "statistical_analysis", "optimization"]
}'),

-- VALIDATION Phase Nodes
('VALIDATION', 'Quality Checker', 'Review output quality before delivery. Checks for errors, compliance, and brand consistency.', 'check-circle', 'validation', '{
    "base_prompt": "Review the output and flag any quality issues, errors, or compliance violations.",
    "required_inputs": ["output_data", "quality_criteria"],
    "loop_logic": "fixed",
    "capabilities": ["quality_review", "error_detection", "compliance_check"]
}'),

('VALIDATION', 'Performance Analyzer', 'Analyze campaign performance and generate insights for optimization.', 'trending-up', 'logic', '{
    "base_prompt": "Analyze performance metrics and provide actionable insights for improvement.",
    "required_inputs": ["performance_data", "kpis"],
    "loop_logic": "batch",
    "capabilities": ["metrics_analysis", "insight_generation", "reporting"]
}'),

('VALIDATION', 'Compliance Validator', 'Ensure all outputs meet regulatory and brand compliance requirements.', 'shield', 'validation', '{
    "base_prompt": "Validate content against compliance rules and regulations.",
    "required_inputs": ["content", "compliance_rules"],
    "loop_logic": "fixed",
    "capabilities": ["compliance_check", "regulation_validation", "risk_assessment"]
}'),

('VALIDATION', 'ROI Calculator', 'Calculate return on investment for campaigns and business initiatives.', 'dollar-sign', 'logic', '{
    "base_prompt": "Calculate ROI based on costs, revenue, and performance metrics.",
    "required_inputs": ["costs", "revenue", "timeframe"],
    "loop_logic": "fixed",
    "capabilities": ["roi_calculation", "financial_analysis", "reporting"]
}');

-- Add comment to table
COMMENT ON TABLE tbl_node_definitions IS 'Node Definition Library - DNA Catalog for spawnable nodes in the Smart Matrix';
COMMENT ON COLUMN tbl_node_definitions.category IS 'Business phase: GENESIS (setup), CAMPAIGN (execution), VALIDATION (review)';
COMMENT ON COLUMN tbl_node_definitions.default_config IS 'Base DNA configuration that will be copied to node_dna_overrides when node is created';
