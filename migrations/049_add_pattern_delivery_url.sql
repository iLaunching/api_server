-- Migration 049: Store canonical Asset_server pattern delivery URL for reliable reload.

DO $$
BEGIN
    IF to_regclass('public."synapticExpressiveBackground"') IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1
            FROM information_schema.columns
            WHERE table_schema = 'public'
              AND table_name = 'synapticExpressiveBackground'
              AND column_name = 'pattern_delivery_url'
        ) THEN
            ALTER TABLE "synapticExpressiveBackground"
            ADD COLUMN pattern_delivery_url TEXT;

            COMMENT ON COLUMN "synapticExpressiveBackground".pattern_delivery_url IS
                'Full or relative Asset_server CDN URL for the pattern SVG (e.g. /cdn/patterns/cinema/foo.svg).';
        END IF;
    END IF;
END $$;
