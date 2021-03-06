USE sakila;

# Question 1a

SELECT first_name, last_name FROM actor;

# Question 1b

SELECT CONCAT(first_name, " ", last_name) AS "Actor Name" FROM actor;

# Question 2a

SELECT actor_id, first_name, last_name 
FROM actor_info
WHERE first_name = "Joe";

# Question 2b

SELECT first_name, last_name 
FROM actor
WHERE last_name LIKE "%GEN%";

# Question 2c

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE "%LI%"
ORDER BY last_name, first_name;

# Question 2d

SELECT country_id, country
FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

# Question 3a

ALTER TABLE actor
ADD COLUMN middle_name TEXT AFTER first_name;

# Question 3b

ALTER TABLE actor
MODIFY COLUMN middle_name blob;

# Question 3c 

ALTER TABLE actor
DROP COLUMN middle_name;

# Question 4a

SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name;

# Question 4b

SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name
HAVING COUNT(*) > 1;

# Question 4c

UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

# Question 4d

UPDATE actor
SET first_name= CASE
	WHEN first_name = 'HARPO' THEN 'GROUCHO'
    ELSE 'MUCHO GROUCHO'
END
WHERE actor_id IN (
SELECT actor_id
FROM film_actor
WHERE (first_name = 'HARPO' OR first_name = 'GROUCHO')
AND last_name = 'WILLIAMS');

# Question 5a

SHOW CREATE TABLE address;

# Question 6a

SELECT staff.first_name AS 'First Name', staff.last_name AS 'Last Name', address.address AS 'Address'
FROM staff
JOIN address
ON staff.address_id = address.address_id;

# Question 6b

SELECT staff.first_name AS 'First Name', staff.last_name AS 'Last Name', SUM(payment.amount) AS 'Total'
FROM payment
JOIN staff
ON payment.staff_id = staff.staff_id
WHERE payment_date BETWEEN '2005-08-01 00:00:00' AND '2005-08-31 23:59:59'
GROUP BY staff.first_name, staff.last_name;

# Question 6c

SELECT film.title, COUNT(film_actor.actor_id) 
FROM film
INNER JOIN film_actor
ON film.film_id = film_actor.film_id
GROUP BY film.title;

# Question 6d

SELECT COUNT(inventory.film_id)
FROM inventory
JOIN film
ON inventory.film_id = film.film_id
WHERE film.title = "Hunchback Impossible";

# Question 6e

SELECT customer.first_name as 'First Name', customer.last_name AS 'Last Name', SUM(payment.amount) AS 'Total'
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.last_name, customer.first_name
ORDER BY customer.last_name;

# Question 7a

SELECT film.title
FROM film
WHERE (film.title LIKE 'K%' OR film.title LIKE 'Q%')
AND film.language_id IN (
SELECT language_id
FROM language
WHERE language.name = 'English');

# Question 7b

SELECT first_name, last_name
FROM actor_info
WHERE actor_id IN
(SELECT film_actor.actor_id
FROM film_actor
JOIN film
ON film_actor.film_id = film.film_id
WHERE film.title = 'Alone Trip');

# Question 7c

SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id
WHERE country.country = 'Canada';

# Question 7d

SELECT film.title 
FROM film
JOIN film_category
ON film.film_id = film_category.film_id
JOIN category
ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

# Question 7e

SELECT film.title, COUNT(rental.rental_id) AS 'Count'
FROM film
LEFT JOIN inventory
ON film.film_id = inventory.film_id
LEFT JOIN rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY Count DESC;

# Question 7f

SELECT inventory.store_id, SUM(payment.amount)
FROM payment
JOIN rental
ON payment.rental_id = rental.rental_id
JOIN inventory
ON rental.inventory_id = inventory.inventory_id
GROUP BY inventory.store_id;

# Question 7g

SELECT store.store_id, city.city, country.country
FROM store
JOIN address
ON store.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id;  

# Question 7h

SELECT category.name, SUM(payment.amount) AS 'Total'
FROM category
JOIN film_category
ON category.category_id = film_category.category_id
JOIN inventory
ON film_category.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id
JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY Total DESC
LIMIT 5;

# Question 8a

CREATE VIEW top_five_genres AS 
SELECT category.name, SUM(payment.amount) AS 'Total'
FROM category
JOIN film_category
ON category.category_id = film_category.category_id
JOIN inventory
ON film_category.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id
JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY Total DESC
LIMIT 5;

# Question 8b

SELECT * FROM top_five_genres;

# Question 8c

DROP VIEW top_five_genres;