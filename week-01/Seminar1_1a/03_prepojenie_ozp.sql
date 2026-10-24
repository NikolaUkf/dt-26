SELECT o.order_id, c.customer_name, p.sub_category, o.profit
from orders o
inner join customers c on o.customer_id = c.customer_id
inner join products p on o.product_id = p.product_id  