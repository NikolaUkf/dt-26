CREATE INDEX idx_orders_order_date
on orders(order_date)

SELECT date_trunc('month',order_date) as month, sum(sales) as sum
FROM orders
GROUP BY month
ORDER BY month ASC