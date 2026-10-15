SELECT 
    stock_code, 
    country, 
    invoice_date, 
    quantity,
    round(
    avg(quantity) over(
    PARTITION BY stock_code,country
    ORDER BY invoice_date
    RANGE BETWEEN interval '7 days' PRECEDING and current row 
),2)as avg_quantity_7_days
FROM retail_sales
WHERE quantity > 1