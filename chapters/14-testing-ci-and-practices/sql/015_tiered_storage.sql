ALTER TABLE clickstream.events
    MODIFY SETTING storage_policy = 'hot_cold';

ALTER TABLE clickstream.events
    MODIFY TTL
        event_time + INTERVAL 30 DAY TO VOLUME 'cold',
        event_time + INTERVAL 60 DAY DELETE
            WHERE event_type = 'page_view',
        event_time + INTERVAL 90 DAY;
