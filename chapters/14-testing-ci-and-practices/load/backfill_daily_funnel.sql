INSERT INTO clickstream.daily_funnel
SELECT toDate(event_time) AS day, country, event_type,
       count() AS events,
       uniqState(user_id) AS users,
       sum(price) AS revenue
FROM clickstream.events
WHERE event_time < '2026-11-02 00:00:00'
GROUP BY day, country, event_type;
