#!/bin/sh
# usage: sh bench/dashboard_load.sh [ROUNDS]
rounds=${1:-5}
for i in $(seq "$rounds"); do
  for f in queries/*.sql; do
    clickhouse client --log_comment="dash:$(basename "$f" .sql)" \
      --queries-file "$f" > /dev/null
  done
done
echo "ran $rounds rounds of $(ls queries/*.sql | wc -l | tr -d ' ') queries"
