with neviem as (SELECT
    customer_id,
    invoice_no,
    invoice_date,
    stock_code,
    description,
    quantity,
    unit_price,
    row_number() over(
        PARTITION BY customer_id
        ORDER BY invoice_date asc
    )as poradie
FROM retail_sales
WHERE customer_id is not null
)
SELECT *
FROM neviem
WHERE poradie = 1
ORDER BY customer_id asc
