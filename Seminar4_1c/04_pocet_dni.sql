SELECT 
    customer_id,
    invoice_no,
    invoice_date,
    next_invoice_date,
    EXTRACT(DAY FROM (next_invoice_date - invoice_date))::integer AS days_to_next_invoice
FROM (
    SELECT DISTINCT
        customer_id,
        invoice_no,
        invoice_date,
        LEAD(invoice_date) OVER (PARTITION BY customer_id ORDER BY invoice_date) AS next_invoice_date
    FROM retail_sales
    WHERE customer_id IS NOT NULL
) sub
WHERE next_invoice_date IS NOT NULL
ORDER BY days_to_next_invoice DESC;