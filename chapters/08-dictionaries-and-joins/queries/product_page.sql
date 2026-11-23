SELECT toDate(event_time) AS day,
       countIf(event_type = 'product_view') AS views,
       countIf(event_type = 'add_to_cart') AS carts,
       countIf(event_type = 'purchase') AS orders
FROM clickstream.events
WHERE product_id = 1234
GROUP BY day
ORDER BY day DESC
LIMIT 5;
