CREATE TABLE IF NOT EXISTS clickstream.products
(
    product_id UInt16,
    name String,
    category LowCardinality(String),
    list_price Decimal(9, 2)
)
ENGINE = MergeTree
ORDER BY product_id;

CREATE TABLE IF NOT EXISTS clickstream.customers
(
    user_id UInt32,
    signup_date Date,
    plan LowCardinality(String)
)
ENGINE = MergeTree
ORDER BY user_id;
