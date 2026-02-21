-- Migration 031: Add setup flag to tbl_contexts
-- When setup=TRUE, the properties panel shows SetupContext instead of the
-- node-specific context. This "locks" the protocol and forces a user decision.

ALTER TABLE tbl_contexts
    ADD COLUMN IF NOT EXISTS setup BOOLEAN NOT NULL DEFAULT FALSE;

-- Index for quick lookup of setup-mode contexts
CREATE INDEX IF NOT EXISTS idx_contexts_setup ON tbl_contexts(setup) WHERE setup = TRUE;

-- Comment for documentation
COMMENT ON COLUMN tbl_contexts.setup IS
    'When TRUE, the properties panel renders SetupContext (global setup mode) instead of the node-specific context. Resets to FALSE when the user chooses to change protocol.';
