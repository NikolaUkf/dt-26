SELECT DISTINCT region
FROM flourmills_sales t1
WHERE NOT EXISTS (
    SELECT 1 
    FROM flourmills_sales t2 
    WHERE t2.region = t1.region 
      AND t2.product_category = 'Flour'
);