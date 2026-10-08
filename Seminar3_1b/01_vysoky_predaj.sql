with daily_sales as(
    SELECT date_trunc('day', sale_date) as sale_date, sum(total_amount) as total_daily_sales
    FROM flourmills_sales
    GROUP BY date_trunc('day', sale_date)
)
SELECT sale_date, total_daily_sales
from daily_sales
WHERE total_daily_sales > 3000000
order by total_daily_sales desc