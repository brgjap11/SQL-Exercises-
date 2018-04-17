/*7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. 
Use subqueries to display the titles of movies starting with the letters K and Q whose language is English. */

SELECT title, language_id
FROM film 
WHERE (title LIKE 'K%' OR title LIKE 'Q%') AND language_id =1;

#7b. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
  SELECT actor_id
  FROM film_actor
  WHERE film_id IN
  (
   SELECT film_id
   FROM film
   WHERE title = 'ALONE TRIP'
  )
);

#7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
SELECT customer.first_name, customer.last_name, customer.email, country.country FROM customer
JOIN address ON customer.address_id= address.address_id
JOIN city ON city.city_id = address.city_id
JOIN country ON country.country_id = city.country_id
WHERE country.country= 'Canada';  

 #7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
SELECT film.title, category.name, film.description FROM film_category
JOIN film ON film_category.film_id = film.film_id
JOIN category ON category.category_id = film_category.category_id
WHERE category.name = 'family' ;

#7e. Display the most frequently rented movies in descending order.
SELECT film.title, COUNT(rental.rental_id) AS Times_Rented FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
GROUP BY film.title 
ORDER BY (Times_Rented) DESC;

#7f. Write a query to display how much business, in dollars, each store brought in.
SELECT  address.address, SUM(payment.amount) AS Total_Revenue FROM staff
JOIN payment ON payment.staff_id = staff.staff_id
JOIN address ON address.address_id = staff.store_id
GROUP BY address.address
ORDER BY(Total_Revenue) DESC;


#7g. Write a query to display for each store its store ID, city, and country.
select store.store_id, city.city, country.country from store
JOIN address ON address.address_id = store.address_id
JOIN city ON city.city_id = address.city_id
JOIN country ON country.country_id = city.country_id;



#7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

SELECT category.name, SUM(payment.amount) AS Gross_Revenue FROM film
JOIN inventory ON inventory.film_id =  film.film_id
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON category.category_id = film_category.category_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name 
ORDER BY (Gross_Revenue) DESC 
LIMIT 5;