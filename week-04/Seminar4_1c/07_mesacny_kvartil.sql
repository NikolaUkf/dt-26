with krajina as (
SELECT
    country,
    date_trunc('month', invoice_date) as mesiac,
    sum(quantity*unit_price) as total_amount
FROM retail_sales
GROUP BY country, mesiac
)
SELECT 
    country,
    mesiac,
    total_amount,
    ntile(4) OVER (PARTITION BY country ORDER BY total_amount desc) as sales_quartile
FROM krajina
ORDER BY country, mesiac asc