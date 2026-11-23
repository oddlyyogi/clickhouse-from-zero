SELECT log_comment AS query,
       count() AS runs,
       round(quantile(0.95)(query_duration_ms)) AS p95_ms,
       formatReadableQuantity(max(read_rows)) AS rows_read,
       formatReadableSize(max(memory_usage)) AS memory
FROM system.query_log
WHERE type = 'QueryFinish'
  AND log_comment LIKE 'dash:%'
  AND event_time > now() - INTERVAL 10 MINUTE
GROUP BY query
ORDER BY p95_ms DESC
LIMIT 5;
