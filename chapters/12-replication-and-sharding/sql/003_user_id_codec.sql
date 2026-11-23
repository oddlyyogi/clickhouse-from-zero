ALTER TABLE clickstream.events
    MODIFY COLUMN user_id UInt32 CODEC(T64, ZSTD(1));
OPTIMIZE TABLE clickstream.events FINAL;
