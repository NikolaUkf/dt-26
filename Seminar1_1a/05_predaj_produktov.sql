select p.product_name, sum(o.sales) as hodnota_predaja
from products p
left join orders o ON p.product_id = o.product_id
group by p.product_id