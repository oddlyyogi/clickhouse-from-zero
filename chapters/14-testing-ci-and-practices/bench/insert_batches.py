"""Compare single-row inserts with one batch insert."""
import time

import clickhouse_connect

client = clickhouse_connect.get_client(host="localhost")
client.command("CREATE DATABASE IF NOT EXISTS lab")
client.command("CREATE OR REPLACE TABLE lab.batch_test "
               "(id UInt32, v String) ENGINE = MergeTree ORDER BY id")
rows = [(i, "x") for i in range(1000)]

start = time.time()
for row in rows[:100]:
    client.insert("lab.batch_test", [row], column_names=["id", "v"])
print(f"100 single-row inserts: {time.time() - start:.2f} s")

start = time.time()
client.insert("lab.batch_test", rows, column_names=["id", "v"])
print(f"one insert of 1000 rows: {time.time() - start:.3f} s")
