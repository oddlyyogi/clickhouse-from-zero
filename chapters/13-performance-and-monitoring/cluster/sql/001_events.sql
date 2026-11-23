CREATE TABLE clickstream.events_local ON CLUSTER clickstream
(
    event_time DateTime CODEC(Delta(4), ZSTD(1)),
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
ENGINE = ReplicatedMergeTree
PARTITION BY toYYYYMM(event_time)
ORDER BY (event_type, user_id, event_time);

CREATE TABLE clickstream.events ON CLUSTER clickstream
AS clickstream.events_local
ENGINE = Distributed(clickstream, clickstream, events_local,
                     cityHash64(user_id));
