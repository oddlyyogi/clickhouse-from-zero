#!/bin/sh
# usage: sh gen/produce.sh COUNT [SEED]
python3 gen/stream_events.py "$@" |
  docker compose exec -T kafka /opt/kafka/bin/kafka-console-producer.sh \
    --bootstrap-server 127.0.0.1:9092 --topic events
