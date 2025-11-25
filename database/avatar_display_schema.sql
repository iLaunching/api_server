-- ============================================
-- AVATAR_DISPLAY CONFIGURATION SCHEMA
-- Control option set for avatar display modes
-- ============================================

-- Insert the avatar_display option set
INSERT INTO option_sets (name, description) VALUES 
    ('avatar_display', 'Avatar display mode options')
ON CONFLICT (name) DO NOTHING;

-- ============================================
-- INSERT AVATAR_DISPLAY OPTION VALUES
-- ============================================

DO $$
DECLARE
    avatar_display_set_id INTEGER;
BEGIN
    -- Get the avatar_display set ID
    SELECT id INTO avatar_display_set_id FROM option_sets WHERE name = 'avatar_display';
    
    -- Insert option values for avatar display modes
    -- No theme_configs needed - this is a simple control option set with no additional attributes
    INSERT INTO option_values (option_set_id, value_name, display_name, sort_order) VALUES 
        (avatar_display_set_id, 'default', 'Default', 1),
        (avatar_display_set_id, 'image', 'Image', 2),
        (avatar_display_set_id, 'icon', 'Icon', 3)
    ON CONFLICT DO NOTHING;
    
END $$;

-- ============================================
-- COMMENTS FOR DOCUMENTATION
-- ============================================
COMMENT ON TABLE option_sets IS 'Configuration sets for grouping related options. avatar_display is a control option set with no additional attributes.';
