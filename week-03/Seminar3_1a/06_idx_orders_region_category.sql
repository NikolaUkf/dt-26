CREATE INDEX idx_orders_region_category
on orders(customer_id, order_date)

SELECT c.customer_id, c.region, o.profit
FROM orders o
inner join customers c on o.customer_id = c.customer_id
WHERE c.region = 'West' AND o.order_date >= '2024-01-01'