CREATE NAMED COLLECTION IF NOT EXISTS archive AS
    url = 'http://127.0.0.1:8333/clickstream/',
    access_key_id = 'local-access-key',
    secret_access_key = 'local-secret-key';

INSERT INTO FUNCTION s3(archive,
    filename = 'events/month={_partition_id}/events.parquet',
    format = 'Parquet')
PARTITION BY toYYYYMM(event_time)
SELECT * EXCEPT props
FROM clickstream.events;
