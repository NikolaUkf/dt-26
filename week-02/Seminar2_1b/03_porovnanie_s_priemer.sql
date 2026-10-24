SELECT product_name, total_amount, 
(
    SELECT avg(total_amount)
    FROM flourmills_sales
) AS avg_amount
FROM flourmills_sales