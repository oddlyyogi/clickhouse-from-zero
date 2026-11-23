CREATE TABLE IF NOT EXISTS clickstream.events_typed
(
    event_time DateTime CODEC(Delta, ZSTD(1)),
    event_type LowCardinality(String),
    user_id UInt32,
    session_id UUID,
    url LowCardinality(String),
    country LowCardinality(String),
    device Enum8('desktop' = 1, 'mobile' = 2, 'tablet' = 3),
    browser LowCardinality(String),
    product_id UInt16,
    price Decimal(9, 2),
    props JSON,
    event_date Date ALIAS toDate(event_time)
)
ENGINE = MergeTree
ORDER BY (event_type, event_time);

INSERT INTO clickstream.events_typed
    (event_time, event_type, user_id, session_id, url,
     country, device, browser, product_id, price)
SELECT event_time, event_type, user_id, session_id, url,
       country, device, browser, product_id,
       toDecimal32(toString(price), 2)
FROM clickstream.events;

EXCHANGE TABLES clickstream.events AND clickstream.events_typed;
DROP TABLE clickstream.events_typed;
