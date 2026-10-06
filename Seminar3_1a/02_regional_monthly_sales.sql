CREATE VIEW regional_monthly_sales as
SELECT c.region, date_trunc('month', o.order_date), sum(o.sales) as monthly_sales
FROM orders o 
INNER JOIN customers c on o.customer_id = c.customer_id
GROUP BY c.region, date_trunc('month', o.order_date)
HAVING c.region = 'West'

SELECT * FROM regional_monthly_sales