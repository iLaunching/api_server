-- Migration: 014_create_matrix_protocols.sql
-- Purpose: Create the Matrix Protocols table
-- This table defines the "Start of Life" protocols for different matrix phases

CREATE TABLE IF NOT EXISTS tbl_matrix_protocols (
    protocol_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    protocol_key VARCHAR(50) NOT NULL UNIQUE,  -- 'GENESIS', 'VALIDATION', 'CAMPAIGN'
    initial_instructions TEXT,                  -- The "Start of Life" prompt for the AI
    context_framework JSONB,                    -- The blueprint for the Master Context
    success_criteria JSONB,                     -- The initial OKRs the AI must set up
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Index for fast protocol key lookup
CREATE INDEX IF NOT EXISTS idx_matrix_protocol_key ON tbl_matrix_protocols(protocol_key);

-- Index for active protocols
CREATE INDEX IF NOT EXISTS idx_matrix_protocol_active ON tbl_matrix_protocols(is_active) WHERE is_active = TRUE;

-- Seed data: Initial matrix protocols
INSERT INTO tbl_matrix_protocols (protocol_key, initial_instructions, context_framework, success_criteria) VALUES
('GENESIS', 
'You are initializing a new Smart Matrix in GENESIS phase. Your role is to help the user establish the foundation of their business automation system.

Key Objectives:
1. Understand the user''s business vision and goals
2. Set up the Master Context with clear objectives
3. Create initial nodes for data collection and validation
4. Establish the framework for the CAMPAIGN phase

Guide the user through defining their target market, value proposition, and initial automation workflows.',
'{
    "phase": "GENESIS",
    "focus_areas": ["market_research", "data_collection", "validation", "foundation_building"],
    "required_contexts": {
        "business_vision": {
            "description": "Core business vision and mission",
            "required_fields": ["vision_statement", "target_market", "value_proposition"]
        },
        "initial_objectives": {
            "description": "First set of measurable objectives",
            "required_fields": ["primary_goal", "success_metrics", "timeline"]
        }
    },
    "recommended_nodes": ["Web Scraper", "Data Validator", "API Connector"],
    "next_phase_trigger": "validation_complete"
}',
'{
    "objectives": [
        {
            "key": "establish_foundation",
            "description": "Set up Master Context with clear business vision",
            "success_metric": "Master Context created with all required fields",
            "target": "100%"
        },
        {
            "key": "data_collection",
            "description": "Implement initial data collection workflows",
            "success_metric": "At least 3 active data collection nodes",
            "target": "3+"
        },
        {
            "key": "validation_ready",
            "description": "Prepare for validation phase",
            "success_metric": "All collected data validated and structured",
            "target": "100%"
        }
    ]
}'),

('CAMPAIGN', 
'You are managing a Smart Matrix in CAMPAIGN phase. The foundation is established, and now you must execute the business automation strategy.

Key Objectives:
1. Execute automated workflows based on validated data
2. Monitor performance and optimize campaigns
3. Generate leads and drive conversions
4. Track ROI and adjust strategies

Focus on execution, optimization, and scaling successful patterns.',
'{
    "phase": "CAMPAIGN",
    "focus_areas": ["execution", "optimization", "lead_generation", "conversion"],
    "required_contexts": {
        "campaign_strategy": {
            "description": "Active campaign strategy and tactics",
            "required_fields": ["campaign_type", "target_audience", "channels", "budget"]
        },
        "performance_tracking": {
            "description": "Real-time performance metrics",
            "required_fields": ["kpis", "current_performance", "targets"]
        }
    },
    "recommended_nodes": ["Lead Scorer", "Content Generator", "Engagement Tracker", "A/B Test Manager"],
    "next_phase_trigger": "campaign_complete"
}',
'{
    "objectives": [
        {
            "key": "campaign_execution",
            "description": "Launch and manage active campaigns",
            "success_metric": "Campaign execution rate",
            "target": "95%"
        },
        {
            "key": "lead_generation",
            "description": "Generate qualified leads",
            "success_metric": "Number of qualified leads per week",
            "target": "50+"
        },
        {
            "key": "conversion_optimization",
            "description": "Optimize conversion rates",
            "success_metric": "Conversion rate improvement",
            "target": "20%"
        }
    ]
}'),

('VALIDATION', 
'You are overseeing a Smart Matrix in VALIDATION phase. Your role is to ensure quality, compliance, and continuous improvement.

Key Objectives:
1. Validate all outputs for quality and compliance
2. Analyze performance and generate insights
3. Calculate ROI and business impact
4. Identify optimization opportunities

Focus on quality assurance, analytics, and strategic recommendations.',
'{
    "phase": "VALIDATION",
    "focus_areas": ["quality_assurance", "compliance", "analytics", "optimization"],
    "required_contexts": {
        "quality_standards": {
            "description": "Quality and compliance requirements",
            "required_fields": ["quality_criteria", "compliance_rules", "brand_guidelines"]
        },
        "performance_analysis": {
            "description": "Comprehensive performance analysis",
            "required_fields": ["metrics", "trends", "insights", "recommendations"]
        }
    },
    "recommended_nodes": ["Quality Checker", "Performance Analyzer", "Compliance Validator", "ROI Calculator"],
    "next_phase_trigger": "validation_approved"
}',
'{
    "objectives": [
        {
            "key": "quality_assurance",
            "description": "Maintain high quality standards",
            "success_metric": "Quality score",
            "target": "95%"
        },
        {
            "key": "compliance_check",
            "description": "Ensure full compliance",
            "success_metric": "Compliance rate",
            "target": "100%"
        },
        {
            "key": "roi_analysis",
            "description": "Calculate and optimize ROI",
            "success_metric": "ROI improvement",
            "target": "25%"
        }
    ]
}');

-- Add comments to table and columns
COMMENT ON TABLE tbl_matrix_protocols IS 'Matrix Protocols - Defines the "Start of Life" instructions and framework for each matrix phase';
COMMENT ON COLUMN tbl_matrix_protocols.protocol_key IS 'Unique identifier for the protocol phase';
COMMENT ON COLUMN tbl_matrix_protocols.initial_instructions IS 'AI system prompt for this phase';
COMMENT ON COLUMN tbl_matrix_protocols.context_framework IS 'Blueprint for Master Context structure';
COMMENT ON COLUMN tbl_matrix_protocols.success_criteria IS 'Initial OKRs and success metrics';
