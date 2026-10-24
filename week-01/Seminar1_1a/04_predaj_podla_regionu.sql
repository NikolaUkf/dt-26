SELECT c.region, sum(o.sales) as celkovy_predaj
from orders o 
RIGHT JOIN customers c on o.customer_id = c.customer_id  
GROUP BY c.region
