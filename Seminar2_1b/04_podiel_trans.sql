SELECT product_name, total_amount, total_amount / (
    SELECT sum(total_amount)
    FROM flourmills_sales
) as amount_share
FROM flourmills_sales