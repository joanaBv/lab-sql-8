-- lab-sql-8 solution

-- Write a query to display for each store its store ID, city, and country.
SELECT s.store_id , ci.city, co.country
FROM sakila.store s
JOIN sakila.address a
USING (address_id)
JOIN sakila.city ci
USING (city_id)
JOIN sakila.country co
USING (country_id);

-- Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(p.amount)
FROM sakila.store s
JOIN sakila.staff st
USING (store_id)
JOIN sakila.payment p
USING (staff_id)
GROUP BY s.store_id;

-- Which film categories are longest?
SELECT c.name, AVG(f.length)
FROM sakila.category c
JOIN sakila.film_category fc
USING (category_id)
JOIN sakila.film f
USING (film_id)
GROUP BY fc.category_id
ORDER BY AVG(f.length) DESC
LIMIT 5;

-- Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(i.film_id)
FROM sakila.film f
JOIN sakila.inventory i
USING (film_id)
JOIN sakila.rental r
USING (inventory_id)
GROUP BY f.title
ORDER BY COUNT(i.film_id) DESC
LIMIT 5;

-- List the top five genres in gross revenue in descending order.
SELECT c.name, SUM(p.amount) AS GrossRevenue
FROM sakila.payment p
JOIN sakila.rental r
USING (rental_id)
JOIN sakila.inventory i
USING (inventory_id)
JOIN sakila.film_category fc
USING (film_id)
JOIN sakila.category c
USING (category_id)
GROUP BY c.name
ORDER BY GrossRevenue DESC
LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT s.store_id, f.title,
CASE
WHEN COUNT(i.store_id) > 0 THEN 'YES'
ELSE 'NO'
END AS available_to_rent, COUNT(i.store_id) AS inventory
FROM sakila.store s
JOIN sakila.inventory i USING (store_id)
JOIN sakila.film f USING (film_id)
JOIN sakila.rental r USING (inventory_id)
WHERE (s.store_id = '1') AND (r.return_date IS NOT NULL) AND (f.title = 'Academy Dinosaur');

-- Get all pairs of actors that worked together.
SELECT  a.first_name, a.last_name, f.title AS MovieTheyCoStarredIn
FROM sakila.actor a
RIGHT JOIN sakila.film_actor fa
USING(actor_id)
LEFT JOIN sakila.film f
USING(film_id);

-- Get all pairs of customers that have rented the same film more than 3 times.
-- SELECT c1.customer_id AS Client1, c2.customer_id AS Client2, c1.first_name AS Client1_FirstName, c1.last_name AS Client1_LastName, c2.first_name AS Client2_FirstName, c2.last_name AS Client2_LastName, i.film_id, COUNT(i.film_id) AS times_rented
-- FROM sakila.rental  r
-- LEFT JOIN sakila.inventory i
-- USING (inventory_id)
-- LEFT JOIN sakila.customer c1
-- USING (customer_id)
-- INNER JOIN sakila.customer c2
-- ON (c1.customer_id <> c2.customer_id);

-- SELECT r.customer_id AS client_1,r1.customer_id AS client_2, f.title, COUNT(i.film_id) AS times_rented_by_customer
-- FROM sakila.rental r
-- INNER JOIN sakila.inventory i
-- ON r.inventory_id = i.inventory_id
-- INNER JOIN sakila.rental r1
-- ON (r.customer_id <> r1.customer_id)
-- INNER JOIN sakila.inventory i1
-- ON r1.inventory_id = i1.inventory_id
-- INNER JOIN sakila.film f
-- ON i.film_id = f.film_id
-- WHERE i.film_id = i1.film_id
-- GROUP BY r.customer_id,r1.customer_id,f.title
-- HAVING COUNT(i.film_id) >= 3 AND COUNT(i1.film_id) >= 3
-- ORDER BY r.customer_id ASC;

-- For each film, list actor that has acted in more films.
