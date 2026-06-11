-- Cache catalog object_path on recently-used rows so delivery URLs need no worker round-trip.
ALTER TABLE user_media ADD COLUMN IF NOT EXISTS source_catalog_object_path TEXT;
