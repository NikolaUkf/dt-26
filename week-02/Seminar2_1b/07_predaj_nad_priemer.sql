SELECT t1.product_name, t1.product_category, t1.total_amount
FROM flourmills_sales t1
WHERE t1.total_amount > (
    SELECT AVG(t2.total_amount)
    FROM flourmills_sales t2
    WHERE t2.product_category = t1.product_category
);