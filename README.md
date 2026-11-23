# ClickHouse from Zero: ClickStream

[![ci](https://github.com/oddlyyogi/clickhouse-from-zero/actions/workflows/ci.yml/badge.svg)](https://github.com/oddlyyogi/clickhouse-from-zero/actions/workflows/ci.yml)

The code for the **ClickHouse** video course. One project, **ClickStream**, grows chapter by chapter: web and product
analytics for a fictional online shop. It starts with five million generated events and a slow dashboard query, then
adds typed and partitioned MergeTree tables, materialized views, projections, dictionaries, TTL, S3 and Kafka ingestion,
a two-shard, two-replica cluster, performance tuning, tests and CI. Some chapters also show ClickHouse Cloud.

The root of this repository is the finished project. Each chapter's finished project is in [`chapters/`](chapters).
Generated data (`data/`) and the server's own folders (everything in `server/` except `server/config.d/`) are not committed:
run `python3 gen/make_events.py 5000000 data/events.csv` to recreate the events.

| # | Chapter | Folder |
|---|---------|--------|
| 1 | Why Are My Analytics Queries So Slow? Your First ClickHouse Table | [chapters/01-your-first-clickhouse-table](chapters/01-your-first-clickhouse-table) |
| 2 | Picking the Right Data Types So the Data Stays Small and Fast | [chapters/02-picking-the-right-data-types](chapters/02-picking-the-right-data-types) |
| 3 | Designing ORDER BY and the Primary Key: Why One Query Scans Everything | [chapters/03-order-by-and-the-primary-key](chapters/03-order-by-and-the-primary-key) |
| 4 | Partitions, Parts and Merges: Organising Data by Time Without Hurting Speed | [chapters/04-partitions-parts-and-merges](chapters/04-partitions-parts-and-merges) |
| 5 | Updates, Deletes and Duplicates: the MergeTree Family | [chapters/05-updates-deletes-and-duplicates](chapters/05-updates-deletes-and-duplicates) |
| 6 | Real-Time Dashboards Without Re-Scanning: Materialized Views and Aggregate States | [chapters/06-materialized-views-and-aggregate-states](chapters/06-materialized-views-and-aggregate-states) |
| 7 | One Table, Many Query Patterns: Projections | [chapters/07-projections](chapters/07-projections) |
| 8 | Joining Events to Products and Customers: Dictionaries and Joins | [chapters/08-dictionaries-and-joins](chapters/08-dictionaries-and-joins) |
| 9 | Keeping Storage Under Control: TTL, Retention and Tiered Storage | [chapters/09-ttl-retention-and-tiered-storage](chapters/09-ttl-retention-and-tiered-storage) |
| 10 | Loading History from S3 and Files at Scale | [chapters/10-loading-from-s3-and-files](chapters/10-loading-from-s3-and-files) |
| 11 | Streaming Live Events from Kafka | [chapters/11-streaming-from-kafka](chapters/11-streaming-from-kafka) |
| 12 | When One Server Isn't Enough: Replication and Sharding | [chapters/12-replication-and-sharding](chapters/12-replication-and-sharding) |
| 13 | Finding and Fixing Slow Queries: Performance Tuning and Monitoring | [chapters/13-performance-and-monitoring](chapters/13-performance-and-monitoring) |
| 14 | Shipping It: Testing, CI with GitHub Actions and Good Practices | [chapters/14-testing-ci-and-practices](chapters/14-testing-ci-and-practices) |

## Run the tests

With a ClickHouse 26.8 server on localhost (see `docker-compose.yml` or the chapters for a local server):

```bash
python3.12 -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt
python ops/migrate.py
pytest -q
```

The same steps run in GitHub Actions on every push (`.github/workflows/ci.yml`).

## Versions

ClickHouse 26.8 LTS (26.8.43.13) locally and in CI (`clickhouse/clickhouse-server:26.8`), Python 3.12, clickhouse-connect 1.13.0, pytest 9.2.0.

## License

MIT
