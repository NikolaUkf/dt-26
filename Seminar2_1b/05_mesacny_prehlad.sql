SELECT * 
from (
    SELECT extract(MONTH from sale_date) as month, sum(total_amount) as monthly_sales 
    FROM flourmills_sales
    GROUP BY extract(MONTH from sale_date)
    ORDER BY extract(MONTH from sale_date)
)as mesiacik
