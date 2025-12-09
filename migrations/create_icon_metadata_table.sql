-- Create icon_metadata table to store Font Awesome icon information
-- This extends option_values for icon_library option set

CREATE TABLE IF NOT EXISTS icon_metadata (
    id SERIAL PRIMARY KEY,
    option_value_id INTEGER NOT NULL REFERENCES option_values(id) ON DELETE CASCADE,
    icon_name VARCHAR(100) NOT NULL,
    icon_prefix VARCHAR(10) NOT NULL CHECK (icon_prefix IN ('fas', 'far', 'fab')),
    icon_category VARCHAR(50) NOT NULL,
    unicode VARCHAR(10),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(option_value_id)
);

-- Create indexes for fast lookups
CREATE INDEX IF NOT EXISTS idx_icon_metadata_category ON icon_metadata(icon_category);
CREATE INDEX IF NOT EXISTS idx_icon_metadata_prefix ON icon_metadata(icon_prefix);
CREATE INDEX IF NOT EXISTS idx_icon_metadata_name ON icon_metadata(icon_name);

COMMENT ON TABLE icon_metadata IS 'Font Awesome icon metadata linked to option_values in icon_library set';
