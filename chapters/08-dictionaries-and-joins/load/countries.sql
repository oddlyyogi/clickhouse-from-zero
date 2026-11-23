CREATE TABLE IF NOT EXISTS clickstream.countries
(
    code String,
    name String,
    region LowCardinality(String)
)
ENGINE = MergeTree
ORDER BY code;

INSERT INTO clickstream.countries VALUES
    ('US', 'United States', 'Americas'), ('BR', 'Brazil', 'Americas'),
    ('CA', 'Canada', 'Americas'), ('GB', 'United Kingdom', 'Europe'),
    ('DE', 'Germany', 'Europe'), ('FR', 'France', 'Europe'),
    ('NL', 'Netherlands', 'Europe'), ('IN', 'India', 'Asia Pacific'),
    ('JP', 'Japan', 'Asia Pacific'), ('AU', 'Australia', 'Asia Pacific');
