SELECT event_type,
       sum(events) AS events,
       uniqMerge(users) AS users,
       sum(revenue) AS revenue
FROM clickstream.daily_funnel
WHERE day >= '2026-10-01'
GROUP BY event_type
ORDER BY events DESC;
