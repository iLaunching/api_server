-- Migration 044: Active Chat navigation context on user_navigation
-- Same config as current_smart_hub_id / current_smart_matrix_id

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'user_navigation'
          AND column_name = 'ac_current_smart_hub_id'
    ) THEN
        ALTER TABLE user_navigation
            ADD COLUMN ac_current_smart_hub_id UUID UNIQUE
                REFERENCES smart_hubs(id) ON DELETE SET NULL;
        COMMENT ON COLUMN user_navigation.ac_current_smart_hub_id IS
            'Active Chat: current smart hub context (mirrors current_smart_hub_id)';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'user_navigation'
          AND column_name = 'ac_current_smart_matrix_id'
    ) THEN
        ALTER TABLE user_navigation
            ADD COLUMN ac_current_smart_matrix_id UUID UNIQUE
                REFERENCES smart_matrices(id) ON DELETE SET NULL;
        COMMENT ON COLUMN user_navigation.ac_current_smart_matrix_id IS
            'Active Chat: current smart matrix context (mirrors current_smart_matrix_id)';
    END IF;

    CREATE INDEX IF NOT EXISTS idx_user_navigation_ac_current_smart_hub_id
        ON user_navigation(ac_current_smart_hub_id);
    CREATE INDEX IF NOT EXISTS idx_user_navigation_ac_current_smart_matrix_id
        ON user_navigation(ac_current_smart_matrix_id);

    UPDATE user_navigation
    SET
        ac_current_smart_hub_id = current_smart_hub_id
    WHERE ac_current_smart_hub_id IS NULL
      AND current_smart_hub_id IS NOT NULL;

    UPDATE user_navigation
    SET
        ac_current_smart_matrix_id = current_smart_matrix_id
    WHERE ac_current_smart_matrix_id IS NULL
      AND current_smart_matrix_id IS NOT NULL;
END $$;
