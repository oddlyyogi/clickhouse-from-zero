INSERT INTO clickstream.orders
    (order_id, user_id, product_id, amount, status, updated_at)
SELECT
    row_number() OVER (ORDER BY event_time, session_id),
    user_id, product_id, price, 'placed', event_time
FROM clickstream.events
WHERE event_type = 'purchase';
