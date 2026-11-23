CREATE TABLE IF NOT EXISTS clickstream.events_sorted
AS clickstream.events
ENGINE = MergeTree
ORDER BY (event_type, user_id, event_time)
PRIMARY KEY (event_type, user_id);

INSERT INTO clickstream.events_sorted SELECT * FROM clickstream.events;
EXCHANGE TABLES clickstream.events AND clickstream.events_sorted;
DROP TABLE clickstream.events_sorted;
