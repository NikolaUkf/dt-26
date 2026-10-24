SELECT c.region, SUM(o.sales) as celkova_hodnota
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.region;
