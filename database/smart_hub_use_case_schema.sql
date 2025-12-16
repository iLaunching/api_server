-- ============================================
-- SMART HUB USE CASE CONFIGURATION SCHEMA
-- Purpose-based smart hub categorization
-- ============================================

-- Insert the smart_hub_use_case option set
INSERT INTO option_sets (name, description) VALUES 
    ('smart_hub_use_case', 'Smart Hub use case categorization options')
ON CONFLICT (name) DO NOTHING;

-- ============================================
-- INSERT SMART HUB USE CASE OPTION VALUES AND CONFIGS
-- ============================================

DO $$
DECLARE
    use_case_set_id INTEGER;
    start_business_id INTEGER;
    work_id INTEGER;
    personal_id INTEGER;
    school_id INTEGER;
    rapid_validation_id INTEGER;
    launch_idea_id INTEGER;
    validate_idea_id INTEGER;
BEGIN
    -- Get the smart_hub_use_case set ID
    SELECT id INTO use_case_set_id FROM option_sets WHERE name = 'smart_hub_use_case';
    
    -- Insert option values for Smart Hub Use Cases
    INSERT INTO option_values (option_set_id, value_name, display_name, sort_order) VALUES 
        (use_case_set_id, 'start_business', 'Start a business', 1),
        (use_case_set_id, 'work', 'Work', 2),
        (use_case_set_id, 'personal', 'Personal', 3),
        (use_case_set_id, 'school', 'School', 4),
        (use_case_set_id, 'rapid_validation', 'Rapid product validation', 5),
        (use_case_set_id, 'launch_idea', 'Launch a idea', 6),
        (use_case_set_id, 'validate_idea', 'Validate my idea', 7)
    ON CONFLICT DO NOTHING;
    
    -- Get option value IDs
    SELECT id INTO start_business_id FROM option_values WHERE option_set_id = use_case_set_id AND value_name = 'start_business';
    SELECT id INTO work_id FROM option_values WHERE option_set_id = use_case_set_id AND value_name = 'work';
    SELECT id INTO personal_id FROM option_values WHERE option_set_id = use_case_set_id AND value_name = 'personal';
    SELECT id INTO school_id FROM option_values WHERE option_set_id = use_case_set_id AND value_name = 'school';
    SELECT id INTO rapid_validation_id FROM option_values WHERE option_set_id = use_case_set_id AND value_name = 'rapid_validation';
    SELECT id INTO launch_idea_id FROM option_values WHERE option_set_id = use_case_set_id AND value_name = 'launch_idea';
    SELECT id INTO validate_idea_id FROM option_values WHERE option_set_id = use_case_set_id AND value_name = 'validate_idea';
    
    -- Insert theme configurations (minimal config since use cases don't need visual themes)
    INSERT INTO theme_configs (option_value_id, name, text_color, background_color, menu_color, border_line_color, theme_metadata) VALUES 
        (start_business_id, 'Start a business', '', '', '', '', '{}'::jsonb),
        (work_id, 'Work', '', '', '', '', '{}'::jsonb),
        (personal_id, 'Personal', '', '', '', '', '{}'::jsonb),
        (school_id, 'School', '', '', '', '', '{}'::jsonb),
        (rapid_validation_id, 'Rapid product validation', '', '', '', '', '{}'::jsonb),
        (launch_idea_id, 'Launch a idea', '', '', '', '', '{}'::jsonb),
        (validate_idea_id, 'Validate my idea', '', '', '', '', '{}'::jsonb)
    ON CONFLICT (option_value_id) DO NOTHING;
    
END $$;

-- ============================================
-- COMMENTS FOR DOCUMENTATION
-- ============================================
COMMENT ON COLUMN theme_configs.theme_metadata IS 'Smart Hub use case metadata (currently empty, can be extended with category-specific attributes)';
