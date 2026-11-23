CREATE TABLE IF NOT EXISTS clickstream.daily_funnel
(
    day Date,
    country LowCardinality(String),
    event_type LowCardinality(String),
    events SimpleAggregateFunction(sum, UInt64),
    users AggregateFunction(uniq, UInt32),
    revenue SimpleAggregateFunction(sum, Decimal(38, 2))
)
ENGINE = AggregatingMergeTree
PARTITION BY toYYYYMM(day)
ORDER BY (day, country, event_type);

CREATE MATERIALIZED VIEW IF NOT EXISTS clickstream.daily_funnel_mv
TO clickstream.daily_funnel AS
SELECT toDate(event_time) AS day, country, event_type,
       count() AS events,
       uniqState(user_id) AS users,
       sum(price) AS revenue
FROM clickstream.events
GROUP BY day, country, event_type;
