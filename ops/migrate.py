"""Apply sql/*.sql in order, once each, and record them."""
import os
import pathlib
import re
import sys

import clickhouse_connect

client = clickhouse_connect.get_client(
    host=os.environ.get("CH_HOST", "localhost"),
    port=int(os.environ.get("CH_PORT", "8123")),
    username=os.environ.get("CH_USER", "default"),
    password=os.environ.get("CH_PASSWORD", ""),
)

client.command("""
    CREATE TABLE IF NOT EXISTS default.schema_migrations
    (version String, applied_at DateTime DEFAULT now())
    ENGINE = MergeTree ORDER BY version""")
done = {row[0] for row in client.query(
    "SELECT version FROM default.schema_migrations").result_rows}

baseline = "--baseline" in sys.argv
applied = 0
for path in sorted(pathlib.Path("sql").glob("*.sql")):
    if path.name in done:
        continue
    if not baseline:
        for statement in re.split(r";\s*\n", path.read_text()):
            if statement.strip():
                client.command(statement)
    client.insert("default.schema_migrations", [[path.name]],
                  column_names=["version"])
    print("baseline" if baseline else "applied", path.name)
    applied += 1
print(f"{applied} new, {len(done)} already applied")
