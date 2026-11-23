CREATE ROLE IF NOT EXISTS dashboard_ro;
GRANT SELECT ON clickstream.* TO dashboard_ro;

CREATE SETTINGS PROFILE IF NOT EXISTS dashboards
SETTINGS max_threads = 4,
         max_memory_usage = 2000000000,
         max_execution_time = 30,
         readonly = 1
TO dashboard_ro;

CREATE QUOTA IF NOT EXISTS dashboard_quota
KEYED BY user_name
FOR INTERVAL 1 hour MAX queries = 100, read_rows = 1000000000
TO dashboard_ro;
