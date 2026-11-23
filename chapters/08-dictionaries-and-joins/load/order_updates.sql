INSERT INTO clickstream.orders
SELECT order_id, user_id, product_id, amount, 'paid',
       updated_at + INTERVAL 5 MINUTE, 0
FROM clickstream.orders WHERE status = 'placed'
  AND cityHash64(order_id) % 100 < 97;

INSERT INTO clickstream.orders
SELECT order_id, user_id, product_id, amount, 'cancelled',
       updated_at + INTERVAL 1 HOUR, 0
FROM clickstream.orders WHERE status = 'placed'
  AND cityHash64(order_id) % 100 >= 97;

INSERT INTO clickstream.orders
SELECT order_id, user_id, product_id, amount, 'shipped',
       updated_at + INTERVAL 1 DAY, 0
FROM clickstream.orders WHERE status = 'paid';

INSERT INTO clickstream.orders
SELECT order_id, user_id, product_id, amount, 'delivered',
       updated_at + INTERVAL 3 DAY, 0
FROM clickstream.orders WHERE status = 'shipped'
  AND cityHash64(order_id) % 100 < 90;
