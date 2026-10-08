with RECURSIVE den_predaja as(
    SELECT 
        min(sale_date) as prvy,
        max(sale_date) as posledny
    FROM flourmills_sales
    UNION ALL

    SELECT prvy + 1, posledny
    from den_predaja
    where prvy < posledny
)
SELECT *
from den_predaja