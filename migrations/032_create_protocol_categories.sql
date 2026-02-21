-- Migration: 032_create_protocol_categories.sql
-- Purpose: Add a protocol categories table and link it to tbl_matrix_protocols
-- Enables filtering and management of protocols by category in the UI

-- 1. Create the categories lookup table
CREATE TABLE IF NOT EXISTS tbl_protocol_categories (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    color TEXT,        -- hex color for UI chips/badges, e.g. '#7F77F1'
    icon_name TEXT,    -- FontAwesome icon name, e.g. 'fa-robot'
    icon_prefix TEXT DEFAULT 'fas',  -- FontAwesome prefix: 'fas', 'far', 'fab'
    sort_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE tbl_protocol_categories IS 'Lookup table for protocol categories used for filtering and UI organization';

-- 2. Add category_id FK to protocols table
ALTER TABLE tbl_matrix_protocols
    ADD COLUMN IF NOT EXISTS category_id INT REFERENCES tbl_protocol_categories(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_matrix_protocols_category ON tbl_matrix_protocols(category_id);

COMMENT ON COLUMN tbl_matrix_protocols.category_id IS 'FK to tbl_protocol_categories — allows category-based filtering';

-- 3. Seed with initial categories
INSERT INTO tbl_protocol_categories (name, description, color, icon_name, icon_prefix, sort_order) VALUES
    ('AI & Automation',  'Protocols powered by artificial intelligence and automated workflows',  '#7F77F1', 'fa-robot',        'fas', 1),
    ('Marketing',        'Protocols for campaigns, lead generation and outreach',                  '#f59e0b', 'fa-bullhorn',     'fas', 2),
    ('Data & Analytics', 'Protocols for data collection, validation and analysis',                 '#3b82f6', 'fa-chart-bar',    'fas', 3),
    ('Operations',       'Protocols for operational management and process automation',             '#10b981', 'fa-cogs',         'fas', 4),
    ('Sales',            'Protocols for sales pipelines, conversion and CRM workflows',            '#ef4444', 'fa-handshake',    'fas', 5),
    ('Content',          'Protocols for content creation, scheduling and publishing',              '#8b5cf6', 'fa-pen-nib',      'fas', 6),
    ('Finance',          'Protocols for financial reporting, budgeting and forecasting',           '#f97316', 'fa-dollar-sign',  'fas', 7),
    ('General',          'General purpose protocols not tied to a specific domain',                '#6b7280', 'fa-layer-group',  'fas', 99)
ON CONFLICT (name) DO NOTHING;
