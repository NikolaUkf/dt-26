SELECT *
FROM flourmills_sales
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales
    where extract(YEAR FROM sale_date) = 2024
)