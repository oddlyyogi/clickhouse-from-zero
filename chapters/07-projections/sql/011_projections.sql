ALTER TABLE clickstream.events
    ADD PROJECTION IF NOT EXISTS product_lite
    (SELECT event_time, event_type, product_id, price
     ORDER BY product_id);

ALTER TABLE clickstream.events
    MATERIALIZE PROJECTION product_lite
    SETTINGS mutations_sync = 1;

ALTER TABLE clickstream.events
    ADD PROJECTION IF NOT EXISTS daily_types
    (SELECT toDate(event_time), event_type, count()
     GROUP BY toDate(event_time), event_type);

ALTER TABLE clickstream.events
    MATERIALIZE PROJECTION daily_types
    SETTINGS mutations_sync = 1;

ALTER TABLE clickstream.events
    MODIFY SETTING lightweight_mutation_projection_mode = 'rebuild';
