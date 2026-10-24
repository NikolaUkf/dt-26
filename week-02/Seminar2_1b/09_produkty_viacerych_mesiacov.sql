SELECT *
FROM flourmills_sales t1
WHERE EXISTS (
    SELECT 1
    FROM flourmills_sales t2
    WHERE t2.sales_id = t1.sales_id
    GROUP BY t2.sales_id
    HAVING COUNT(DISTINCT DATE_TRUNC('month', t2.sale_date)) > 1
);