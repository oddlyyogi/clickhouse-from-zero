SELECT event_type,
       count() AS events,
       uniq(user_id) AS users,
       sum(price) AS revenue
FROM clickstream.events
WHERE event_time >= '2026-10-01'
GROUP BY event_type
ORDER BY events DESC;
