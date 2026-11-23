SELECT country, count() AS views
FROM clickstream.events
WHERE event_type = 'page_view'
GROUP BY country
ORDER BY views DESC;
