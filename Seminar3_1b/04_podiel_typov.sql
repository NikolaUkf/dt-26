with cte1 as(
    SELECT customer_type, sum(total_amount) as revenue
    FROM flourmills_sales
    GROUP BY customer_type
),
cte2 as(
    SELECT customer_type, revenue, sum(revenue) OVER () AS total_revenue,
            ROUND(
            revenue * 100.0 / SUM(revenue) OVER (),
            2
        ) AS revenue_percentage
    FROM cte1
)
SELECT customer_type, revenue, total_revenue, revenue_percentage
from cte2 
order by revenue desc