CREATE DICTIONARY IF NOT EXISTS clickstream.products_dict
(
    product_id UInt64,
    name String,
    category String DEFAULT 'unknown',
    list_price Decimal(9, 2)
)
PRIMARY KEY product_id
SOURCE(CLICKHOUSE(TABLE 'products' DB 'clickstream'))
LAYOUT(FLAT())
LIFETIME(MIN 300 MAX 360);

CREATE DICTIONARY IF NOT EXISTS clickstream.customers_dict
(
    user_id UInt64,
    signup_date Date,
    plan String DEFAULT 'free'
)
PRIMARY KEY user_id
SOURCE(CLICKHOUSE(TABLE 'customers' DB 'clickstream'))
LAYOUT(HASHED())
LIFETIME(MIN 300 MAX 360);

CREATE DICTIONARY IF NOT EXISTS clickstream.countries_dict
(
    code String,
    name String DEFAULT 'unknown',
    region String DEFAULT 'unknown'
)
PRIMARY KEY code
SOURCE(CLICKHOUSE(TABLE 'countries' DB 'clickstream'))
LAYOUT(COMPLEX_KEY_HASHED())
LIFETIME(MIN 3600 MAX 7200);
