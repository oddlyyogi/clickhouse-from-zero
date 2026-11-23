ALTER TABLE clickstream.events
    MODIFY TTL
        event_time + INTERVAL 60 DAY DELETE
            WHERE event_type = 'page_view',
        event_time + INTERVAL 90 DAY;

ALTER TABLE clickstream.events
    MODIFY COLUMN props JSON TTL event_time + INTERVAL 30 DAY;

ALTER TABLE clickstream.daily_funnel
    MODIFY TTL day + INTERVAL 2 YEAR;
