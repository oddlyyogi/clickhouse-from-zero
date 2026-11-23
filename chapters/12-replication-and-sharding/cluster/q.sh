#!/bin/sh
# usage: sh cluster/q.sh NODE [client options]
node=$1; shift
exec docker compose -f cluster/docker-compose.yml \
  exec -T "clickhouse-0$node" \
  clickhouse client --format PrettyCompactMonoBlock "$@"
