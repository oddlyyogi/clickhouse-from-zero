from datetime import datetime, timezone
from decimal import Decimal

COLUMNS = ["order_id", "user_id", "product_id", "amount", "status",
           "updated_at", "is_deleted"]
PRICE = Decimal("19.99")


def at(minute):
    return datetime(2030, 1, 1, 12, minute, tzinfo=timezone.utc)


def latest(client, db):
    return client.query(f"SELECT status FROM {db}.orders FINAL "
                        "WHERE order_id = 1").result_rows


def test_orders_keep_the_latest_version(client, scratch_db):
    client.command(f"CREATE TABLE {scratch_db}.orders "
                   "AS clickstream.orders")
    client.insert(f"{scratch_db}.orders", [
        (1, 7, 42, PRICE, "placed", at(0), 0),
        (1, 7, 42, PRICE, "paid", at(5), 0),
    ], column_names=COLUMNS)
    assert latest(client, scratch_db) == [("paid",)]


def test_deleted_orders_disappear(client, scratch_db):
    client.command(f"CREATE TABLE {scratch_db}.orders "
                   "AS clickstream.orders")
    client.insert(f"{scratch_db}.orders", [
        (1, 7, 42, PRICE, "placed", at(0), 0),
        (1, 7, 42, PRICE, "cancelled", at(9), 1),
    ], column_names=COLUMNS)
    assert latest(client, scratch_db) == []
