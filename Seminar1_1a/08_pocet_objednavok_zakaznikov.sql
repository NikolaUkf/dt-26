SELECT c.customer_id, count(o.order_id) as pocet_objednavok
from orders o
inner join customers c on o.customer_id = c.customer_id
GROUP BY c.customer_id