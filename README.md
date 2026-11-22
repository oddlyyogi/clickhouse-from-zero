# ClickHouse from Zero: ClickStream

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

## Versions

ClickHouse 26.8 LTS (26.8.43.13) locally and in CI (`clickhouse/clickhouse-server:26.8`), Python 3.12.

## License

MIT
