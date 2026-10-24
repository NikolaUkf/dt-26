SELECT p.sub_category, avg(o.discount) as priemer
FROM orders o
inner join products p on o.product_id = p.product_id
GROUP BY p.sub_category