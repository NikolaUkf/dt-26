SELECT 
    customer_id, 
    invoice_no, 
    invoice_date, quantity, 
    unit_price, 
    (quantity * unit_price) as revenue,
    sum(quantity * unit_price) OVER(
    PARTITION BY customer_id
    ORDER BY invoice_date
    RANGE BETWEEN INTERVAL '14 days' PRECEDING AND CURRENT ROW
) as revenue_last_14_days
FROM retail_sales
WHERE customer_id is not null
ORDER BY customer_id, invoice_date