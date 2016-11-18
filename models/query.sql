SELECT c.name as customer_name, f.title as film_title FROM customers c
INNER JOIN tickets t
ON c.id = t.customer_id
INNER JOIN films f 
ON f.id = t.film_id;