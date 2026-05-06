-- Migration 036: Move synapse_number from user_profiles -> smart_hubs
-- 1) Add smart_hubs.synapse_number (VARCHAR(20)) + unique index
-- 2) Backfill from user_profiles.synapse_number to one hub per owner (prefer default hub)
-- 3) Drop old unique index + column from user_profiles

-- 1) Add column + unique index
ALTER TABLE smart_hubs
ADD COLUMN IF NOT EXISTS synapse_number VARCHAR(20);

CREATE UNIQUE INDEX IF NOT EXISTS idx_smart_hubs_synapse_number
ON smart_hubs(synapse_number);

COMMENT ON COLUMN smart_hubs.synapse_number IS 'Unique digits-only synapse identifier for routing (moved from user_profiles)';

-- 2) Backfill: choose one hub per owner_id (default hub first, then oldest)
WITH hub_choice AS (
  SELECT DISTINCT ON (owner_id)
    id AS hub_id,
    owner_id
  FROM smart_hubs
  ORDER BY owner_id, is_default DESC, created_at ASC
)
UPDATE smart_hubs h
SET synapse_number = up.synapse_number
FROM hub_choice hc
JOIN user_profiles up ON up.user_id = hc.owner_id
WHERE h.id = hc.hub_id
  AND (h.synapse_number IS NULL OR h.synapse_number = '')
  AND up.synapse_number IS NOT NULL
  AND up.synapse_number <> '';

-- 3) Drop old index + column
DROP INDEX IF EXISTS idx_synapse_number;

ALTER TABLE user_profiles
DROP COLUMN IF EXISTS synapse_number;

-- Verify
SELECT
  (SELECT count(*) FROM information_schema.columns WHERE table_name='smart_hubs' AND column_name='synapse_number') AS smart_hubs_has_synapse,
  (SELECT count(*) FROM information_schema.columns WHERE table_name='user_profiles' AND column_name='synapse_number') AS user_profiles_has_synapse;

