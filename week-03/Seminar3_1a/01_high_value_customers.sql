CREATE View high_value_customers as 
SELECT c.customer_id, c.customer_name, sum(o.sales) as total_sales 
FROM customers c
inner JOIN orders o on c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING sum(o.sales) > 2000

SELECT *
FROM high_value_customers