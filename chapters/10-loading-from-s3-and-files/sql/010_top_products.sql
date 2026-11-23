CREATE TABLE IF NOT EXISTS clickstream.top_products
(
    product_id UInt16,
    orders UInt64,
    revenue Decimal(38, 2)
)
ENGINE = MergeTree
ORDER BY product_id;

CREATE MATERIALIZED VIEW IF NOT EXISTS clickstream.top_products_rmv
REFRESH EVERY 1 DAY OFFSET 2 HOUR RANDOMIZE FOR 30 MINUTE
TO clickstream.top_products AS
SELECT product_id, count() AS orders, sum(price) AS revenue
FROM clickstream.events
WHERE event_type = 'purchase' AND event_time >= '2026-11-01'
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 10;

CREATE TABLE IF NOT EXISTS clickstream.top_history
(
    snapshot DateTime,
    product_id UInt16,
    revenue Decimal(38, 2)
)
ENGINE = MergeTree
ORDER BY (snapshot, product_id);

CREATE MATERIALIZED VIEW IF NOT EXISTS clickstream.top_history_rmv
REFRESH DEPENDS ON clickstream.top_products_rmv
APPEND TO clickstream.top_history AS
SELECT now() AS snapshot, product_id, revenue
FROM clickstream.top_products;
