SELECT c.customer_name, sum(o.sales) as hodnota_predaja, avg(o.discount) as priemerna_zlava, COUNT(o.order_id) as pocet_objednavok,
CASE 
    WHEN sum(o.sales) > 2500 THEN 'VIP'  
    ELSE  'REGULAR'
END as typ_zakaznika
FROM customers c 
inner JOIN orders o on c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY sum(o.sales) DESC