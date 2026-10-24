with hodnotna_polozka as (
SELECT
    invoice_no,
    stock_code,
    description,
    quantity,
    unit_price,
    (quantity*unit_price) as amount,
    ROW_NUMBER() over(
        PARTITION BY invoice_no
        ORDER BY (quantity * unit_price) DESC
    ) as row_num
FROM retail_sales
)
SELECT *
FROM hodnotna_polozka
where row_num BETWEEN 1 AND 3