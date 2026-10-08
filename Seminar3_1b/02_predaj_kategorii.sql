with category_sales as(
    SELECT product_category, sum(total_amount) as total_sales
    from flourmills_sales
    GROUP BY product_category
)
SELECT *
from category_sales
order by total_sales desc