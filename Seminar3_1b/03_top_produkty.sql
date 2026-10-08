with cte1 as(
    SELECT product_category, product_name,sum(total_amount) as total_product_sales
    FROM flourmills_sales
    GROUP BY product_category, product_name
),
cte2 as(
    SELECT product_category, total_product_sales,
    rank() over(
        PARTITION BY product_category
        order by total_product_sales desc
    ) as category_rank
    from cte1
)
SELECT *
from cte2
WHERE category_rank <=3
order by product_category, category_rank