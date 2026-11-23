CREATE TABLE IF NOT EXISTS clickstream.orders
(
    order_id UInt64,
    user_id UInt32,
    product_id UInt16,
    amount Decimal(9, 2),
    status Enum8('placed' = 1, 'paid' = 2, 'shipped' = 3,
                  'delivered' = 4, 'cancelled' = 5),
    updated_at DateTime,
    is_deleted UInt8 DEFAULT 0
)
ENGINE = ReplacingMergeTree(updated_at, is_deleted)
ORDER BY order_id
SETTINGS enable_block_number_column = 1, enable_block_offset_column = 1;
