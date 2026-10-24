SELECT sales_id, sale_date, region, product_category
FROM flourmills_sales
WHERE product_category = (
SELECT product_category
FROM flourmills_sales
GROUP BY product_category
ORDER BY sum(total_amount) DESC
limit 1 
)

