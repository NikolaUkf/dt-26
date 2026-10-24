SELECT c.customer_id, sum(o.sales) as celkom
FROM orders o 
INNER JOIN customers c on o.customer_id = c.customer_id
GROUP BY c.customer_id
HAVING sum(o.sales) > 2000