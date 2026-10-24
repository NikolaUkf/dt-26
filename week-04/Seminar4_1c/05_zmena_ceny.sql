SELECT 
    stock_code,
    invoice_no,
    invoice_date,
    previous_price,
    current_price,
    price_difference
FROM (
    SELECT 
        stock_code,
        invoice_no,
        invoice_date,
        LAG(unit_price) OVER (
            PARTITION BY stock_code 
            ORDER BY invoice_date, invoice_no
        ) AS previous_price,
        unit_price AS current_price,
        unit_price - LAG(unit_price) OVER (
            PARTITION BY stock_code 
            ORDER BY invoice_date, invoice_no
        ) AS price_difference
    FROM retail_sales
) sub
WHERE previous_price IS NOT NULL 
  AND price_difference <> 0
ORDER BY invoice_date ASC;