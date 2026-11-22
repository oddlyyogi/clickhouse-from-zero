SELECT
    props.experiment.:String AS experiment,
    uniq(session_id) AS sessions,
    countIf(event_type = 'purchase') AS purchases,
    round(100 * purchases / sessions, 2) AS conversion_pct
FROM clickstream.events
WHERE props.experiment IS NOT NULL
GROUP BY experiment
ORDER BY experiment;
