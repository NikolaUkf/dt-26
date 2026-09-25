SELECT c.region, sum(o.sales) as hodnota_predaja, avg(o.discount) as priemerna_zlava, COUNT(o.order_id) as pocet_objednavok
from orders o
inner JOIN customers c on o.customer_id = c.customer_id 
GROUP BY c.region