WITH MonthlySales AS (
    SELECT 
        DATE_TRUNC('month', order_date) AS month,
        SUM(sales) AS monthly_sales
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
),
PreviousMonthSales AS (
    SELECT 
        month,
        monthly_sales,
        LAG(monthly_sales, 1) OVER (ORDER BY month) AS prev_month_sales
    FROM MonthlySales
),
CalculatedChanges AS (
    SELECT 
        month,
        monthly_sales,
        prev_month_sales,
        (monthly_sales - prev_month_sales) AS sales_change,
        ROUND(
            ((monthly_sales - prev_month_sales) * 100.0) / prev_month_sales, 
            2
        ) AS growth_percentage
    FROM PreviousMonthSales
)
SELECT 
    month,
    monthly_sales,
    prev_month_sales,
    sales_change,
    growth_percentage
FROM CalculatedChanges
ORDER BY month ASC;