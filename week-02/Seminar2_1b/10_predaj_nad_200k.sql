SELECT product_category, product_name, total_amount
FROM flourmills_sales
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales
    WHERE total_amount > 200000
)