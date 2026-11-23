SELECT path, count() AS sessions
FROM
(
    SELECT arrayMap(e -> e.2,
               arraySort(groupArray((event_time, event_type)))) AS path
    FROM clickstream.events
    WHERE event_time >= now() - INTERVAL 7 DAY
    GROUP BY session_id
)
GROUP BY path
ORDER BY sessions DESC
LIMIT 5;
