with mesiacik as(
    SELECT 
        date_trunc('month', order_date) as month,
        sum(sales) as monthly_sales
    FROM orders
    GROUP BY month
)
SELECT 
    month,
    monthly_sales,
    lag(monthly_sales,1) OVER (ORDER BY month) AS prev_month_sales,
    lead(monthly_sales,1) OVER (ORDER BY month) AS next_month_sales
FROM mesiacik
ORDER BY month asc