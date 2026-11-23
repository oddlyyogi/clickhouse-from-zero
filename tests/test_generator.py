import subprocess

KINDS = "'page_view', 'product_view', 'add_to_cart', 'purchase'"


def local(sql):
    result = subprocess.run(["clickhouse", "local", "-q", sql],
                            capture_output=True, text=True, check=True)
    return result.stdout.split()


def test_stream_generator_writes_valid_events(tmp_path):
    out = tmp_path / "events.jsonl"
    gen = subprocess.run(["python3", "gen/stream_events.py", "500", "7"],
                         capture_output=True, text=True, check=True)
    out.write_text(gen.stdout)
    assert local(
        "SELECT count(), "
        f"countIf(event_type NOT IN ({KINDS})), "
        "countIf(event_type = 'purchase' AND price <= 0) "
        f"FROM file('{out}', JSONEachRow)") == ["500", "0", "0"]
