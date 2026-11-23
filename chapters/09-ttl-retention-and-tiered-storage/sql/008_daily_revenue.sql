CREATE TABLE IF NOT EXISTS clickstream.daily_revenue
(
    day Date,
    country LowCardinality(String),
    orders UInt64,
    revenue Decimal(18, 2)
)
ENGINE = SummingMergeTree((orders, revenue))
ORDER BY (day, country);
