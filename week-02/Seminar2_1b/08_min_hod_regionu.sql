SELECT t1.product_name, t1.region, t1.total_amount,
       (SELECT MIN(t2.total_amount) 
        FROM flourmills_sales t2 
        WHERE t2.region = t1.region) AS region_min_amount
FROM flourmills_sales t1;