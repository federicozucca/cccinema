SELECT c.name as customer_name, f.title as film_title FROM customers c
INNER JOIN tickets t
ON c.id = t.customer_id
INNER JOIN film f 
ON f.id = t.film_id;