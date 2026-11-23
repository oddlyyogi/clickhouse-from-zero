SELECT dictGet('clickstream.products_dict', 'category', product_id)
           AS category,
       count() AS orders,
       sum(price) AS revenue
FROM clickstream.events
WHERE event_type = 'purchase'
  AND event_time >= '2026-11-01'
GROUP BY category
ORDER BY revenue DESC;