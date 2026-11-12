-- User dictation style library + catalog download/rating stats.

CREATE TABLE IF NOT EXISTS user_dictation_categories (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    type_kind TEXT NOT NULL DEFAULT 'personal_casual',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_user_dictation_categories_user
    ON user_dictation_categories (user_id);

CREATE TABLE IF NOT EXISTS user_dictation_styles (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    category_id UUID NULL REFERENCES user_dictation_categories(id) ON DELETE SET NULL,
    name TEXT NOT NULL,
    explanation TEXT NOT NULL DEFAULT '',
    rules TEXT NOT NULL DEFAULT '',
    taxonomy_path TEXT NULL,
    compiled_contract JSONB NULL,
    source_catalog_id TEXT NULL,
    catalog_version INT NULL,
    parent_style_id UUID NULL REFERENCES user_dictation_styles(id) ON DELETE SET NULL,
    bound_room_id TEXT NULL,
    kind TEXT NOT NULL DEFAULT 'template',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT user_dictation_styles_kind_check
        CHECK (kind IN ('template', 'room_copy', 'custom_fork'))
);

CREATE INDEX IF NOT EXISTS idx_user_dictation_styles_user
    ON user_dictation_styles (user_id);
CREATE INDEX IF NOT EXISTS idx_user_dictation_styles_catalog
    ON user_dictation_styles (user_id, source_catalog_id);
CREATE INDEX IF NOT EXISTS idx_user_dictation_styles_room
    ON user_dictation_styles (user_id, bound_room_id);

CREATE TABLE IF NOT EXISTS dictation_style_stats (
    catalog_style_id TEXT PRIMARY KEY,
    download_count BIGINT NOT NULL DEFAULT 0,
    rating_sum BIGINT NOT NULL DEFAULT 0,
    rating_count BIGINT NOT NULL DEFAULT 0,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS dictation_style_ratings (
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    catalog_style_id TEXT NOT NULL,
    stars INT NOT NULL CHECK (stars >= 1 AND stars <= 5),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (user_id, catalog_style_id)
);

CREATE INDEX IF NOT EXISTS idx_dictation_style_ratings_style
    ON dictation_style_ratings (catalog_style_id);

CREATE TABLE IF NOT EXISTS dictation_style_installs (
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    catalog_style_id TEXT NOT NULL,
    style_id UUID NULL REFERENCES user_dictation_styles(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (user_id, catalog_style_id)
);
