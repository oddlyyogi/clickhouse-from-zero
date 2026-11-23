SELECT status, count() AS orders
FROM
(
    SELECT order_id, argMax(status, updated_at) AS status
    FROM clickstream.orders
    GROUP BY order_id
)
GROUP BY status
ORDER BY status;
