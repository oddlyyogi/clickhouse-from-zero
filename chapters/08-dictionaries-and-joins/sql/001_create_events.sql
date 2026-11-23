CREATE DATABASE IF NOT EXISTS clickstream;

CREATE TABLE IF NOT EXISTS clickstream.events
(
    event_time DateTime,
    event_type String,
    user_id UInt32,
    session_id String,
    url String,
    country String,
    device String,
    browser String,
    product_id UInt32,
    price Float64
)
ENGINE = MergeTree
ORDER BY (event_type, event_time);
