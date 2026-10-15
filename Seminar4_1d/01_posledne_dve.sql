with objednavka as(
SELECT 
    c.customer_id,
    o.order_id,
    o.order_date,
    ROW_NUMBER() OVER(
        PARTITION BY c.customer_id
        ORDER BY o.order_date desc
    ) as cislo_objednavky
FROM customers c
INNER JOIN orders o on c.customer_id = o.customer_id
)
SELECT 
    customer_id,
    order_id,
    order_date
FROM objednavka
WHERE cislo_objednavky BETWEEN 1 AND 2
ORDER BY customer_id, cislo_objednavky;