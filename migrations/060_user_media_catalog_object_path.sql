-- Cache catalog object_path on recently-used rows so delivery URLs need no worker round-trip.
ALTER TABLE user_media ADD COLUMN IF NOT EXISTS source_catalog_object_path TEXT;

COMMENT ON COLUMN user_media.source_catalog_object_path IS
    'Catalog R2 path (e.g. photos/pexels-123.webp) for source_kind=catalog wallpapers';
