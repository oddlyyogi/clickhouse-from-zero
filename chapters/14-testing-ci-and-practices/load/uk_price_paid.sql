INSERT INTO market.uk_price_paid
SELECT price, toDate(date), postcode1, postcode2,
       type, is_new, duration, addr1, addr2, street,
       locality, town, district, county
FROM s3(concat(
        'https://datasets-documentation.s3.eu-west-3.amazonaws.com/',
        'uk-house-prices/parquet/house_prices_{1995..2023}.parquet'),
    NOSIGN);
