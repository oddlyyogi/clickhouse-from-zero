CREATE TABLE IF NOT EXISTS clickstream.events_monthly
AS clickstream.events
ENGINE = MergeTree
PARTITION BY toYYYYMM(event_time)
ORDER BY (event_type, user_id, event_time)
PRIMARY KEY (event_type, user_id);

INSERT INTO clickstream.events_monthly SELECT * FROM clickstream.events;
EXCHANGE TABLES clickstream.events AND clickstream.events_monthly;
DROP TABLE clickstream.events_monthly;
