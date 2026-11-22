SELECT
    toDate(event_time) AS day,
    uniq(user_id) AS users,
    countIf(event_type = 'purchase') AS orders,
    round(sum(price), 2) AS revenue
FROM clickstream.events
GROUP BY day
ORDER BY day
LIMIT 7;
