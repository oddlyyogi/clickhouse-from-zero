from datetime import date, datetime, timezone

TEST_DAY = date(2030, 1, 1)
COLUMNS = ["event_time", "event_type", "user_id", "country"]


def at(hour, minute):
    return datetime(2030, 1, 1, hour, minute, tzinfo=timezone.utc)


def test_daily_funnel_counts_new_events(client):
    rows = [
        (at(10, 0), "page_view", 1, "DE"),
        (at(10, 1), "purchase", 1, "DE"),
        (at(10, 2), "page_view", 2, "DE"),
    ]
    client.insert("clickstream.events", rows, column_names=COLUMNS)
    day = {"day": TEST_DAY}
    try:
        result = client.query(
            "SELECT sum(events), uniqMerge(users) "
            "FROM clickstream.daily_funnel "
            "WHERE day = {day:Date} AND country = 'DE'",
            parameters=day).result_rows[0]
        assert result == (3, 2)
    finally:
        client.command(
            "DELETE FROM clickstream.events "
            "WHERE toDate(event_time) = {day:Date}", parameters=day)
        client.command(
            "ALTER TABLE clickstream.daily_funnel "
            "DELETE WHERE day = {day:Date} "
            "SETTINGS mutations_sync = 2", parameters=day)
