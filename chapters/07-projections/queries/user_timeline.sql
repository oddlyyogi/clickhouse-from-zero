SELECT event_time, event_type, url
FROM clickstream.events
WHERE user_id = 4242
ORDER BY event_time;
