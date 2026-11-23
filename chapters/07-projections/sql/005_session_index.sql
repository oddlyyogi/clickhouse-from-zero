ALTER TABLE clickstream.events
    ADD INDEX IF NOT EXISTS idx_session session_id
    TYPE bloom_filter(0.01) GRANULARITY 4;
ALTER TABLE clickstream.events MATERIALIZE INDEX idx_session;
