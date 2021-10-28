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
SELECT s.store_id, f.title, COUNT(i.inventory_id) AS items
FROM sakila.store s
JOIN sakila.inventory i USING (store_id)
JOIN sakila.film f USING (film_id)
JOIN sakila.rental r USING (inventory_id)
GROUP BY s.store_id
HAVING f.title = 'Academy Dinosaur'
ORDER BY s.store_id ASC
LIMIT 1;

-- Get all pairs of actors that worked together.


-- Get all pairs of customers that have rented the same film more than 3 times.


-- For each film, list actor that has acted in more films.