def test_core_tables_exist(client):
    names = {r[0] for r in client.query(
        "SELECT name FROM system.tables "
        "WHERE database = 'clickstream'").result_rows}
    assert {"events", "daily_funnel", "products", "customers"} <= names


def test_events_sort_key(client):
    key = client.query(
        "SELECT sorting_key FROM system.tables "
        "WHERE database = 'clickstream' "
        "AND name = 'events'").result_rows[0][0]
    assert key == "event_type, user_id, event_time"


def test_dashboard_role_is_read_only(client):
    grants = [r[0] for r in client.query(
        "SHOW GRANTS FOR dashboard_ro").result_rows]
    assert grants == ["GRANT SELECT ON clickstream.* TO dashboard_ro"]


def test_events_have_referrer(client):
    cols = dict(client.query(
        "SELECT name, type FROM system.columns "
        "WHERE database = 'clickstream' "
        "AND table = 'events'").result_rows)
    assert cols.get("referrer") == "LowCardinality(String)"
