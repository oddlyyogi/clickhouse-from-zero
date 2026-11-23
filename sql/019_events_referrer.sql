ALTER TABLE clickstream.events
    ADD COLUMN IF NOT EXISTS referrer LowCardinality(String) DEFAULT '';
