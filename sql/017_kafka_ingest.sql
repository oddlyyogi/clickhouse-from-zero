CREATE TABLE IF NOT EXISTS clickstream.events_queue
(
    event_time DateTime,
    event_type LowCardinality(String),
    user_id UInt32,
    session_id UUID,
    url LowCardinality(String),
    country LowCardinality(String),
    device Enum8('desktop' = 1, 'mobile' = 2, 'tablet' = 3),
    browser LowCardinality(String),
    product_id UInt16,
    price Decimal(9, 2)
)
ENGINE = Kafka
SETTINGS kafka_broker_list = '127.0.0.1:9092',
         kafka_topic_list = 'events',
         kafka_group_name = 'clickstream',
         kafka_format = 'JSONEachRow',
         kafka_client_id = 'clickstream',
         kafka_handle_error_mode = 'stream';

CREATE TABLE IF NOT EXISTS clickstream.kafka_errors
(
    received DateTime DEFAULT now(),
    topic LowCardinality(String),
    partition UInt32,
    offset UInt64,
    raw_message String,
    error String
)
ENGINE = MergeTree
ORDER BY received
TTL received + INTERVAL 30 DAY;

CREATE MATERIALIZED VIEW IF NOT EXISTS clickstream.events_kafka_mv
TO clickstream.events AS
SELECT event_time, event_type, user_id, session_id, url, country,
       device, browser, product_id, price
FROM clickstream.events_queue
WHERE length(_error) = 0;

CREATE MATERIALIZED VIEW IF NOT EXISTS clickstream.kafka_errors_mv
TO clickstream.kafka_errors AS
SELECT _topic AS topic, _partition AS partition, _offset AS offset,
       _raw_message AS raw_message, _error AS error
FROM clickstream.events_queue
WHERE length(_error) > 0;
