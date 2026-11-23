import os
import uuid

import clickhouse_connect
import pytest


@pytest.fixture(scope="session")
def client():
    c = clickhouse_connect.get_client(
        host=os.environ.get("CH_HOST", "localhost"),
        port=int(os.environ.get("CH_PORT", "8123")),
        username=os.environ.get("CH_USER", "default"),
        password=os.environ.get("CH_PASSWORD", ""),
    )
    yield c
    c.close()


@pytest.fixture
def scratch_db(client):
    name = "test_" + uuid.uuid4().hex[:8]
    client.command(f"CREATE DATABASE {name}")
    yield name
    client.command(f"DROP DATABASE {name} SYNC")
