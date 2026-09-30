SELECT * 
FROM (
    SELECT product_category, sum(total_amount) as celkom
    FROM flourmills_sales
    GROUP BY product_category
)as kategorie
where celkom > 50000000