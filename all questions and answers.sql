USE sakila;
#1a. Display the first and last names of all actors from the table actor.
SELECT first_name, last_name
FROM actor;

#1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
SELECT first_name, last_name, Actor_Name
FROM actor; 
ALTER TABLE actor 
ADD COLUMN Actor_Name VARCHAR (20) NOT NULL;
SELECT CONCAT(first_name, last_name) as Actor_Name
FROM actor; 

#2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe' ;

#2b. Find all actors whose last name contain the letters GEN:
SELECT * FROM actor
WHERE last_name LIKE '%GEN%';

#2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
SELECT first_name, last_name
FROM actor 
WHERE last_name LIKE '%LI%'
ORDER BY last_name;

#2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type.
ALTER TABLE actor 
ADD COLUMN middle_name VARCHAR (20) NOT NULL
AFTER first_name;

#3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.
ALTER TABLE actor 
CHANGE COLUMN middle_name middle_name BLOB NOT NULL ;

#3c. Now delete the middle_name column.
ALTER TABLE actor 
DROP COLUMN middle_name; 

#4a. List the last names of actors, as well as how many actors have that last name.
SELECT last_name, COUNT(*)  AS COUNT 
FROM actor
GROUP BY last_name 
ORDER BY COUNT DESC;

#4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT  last_name ,COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2 ;

#4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.
UPDATE actor
SET first_name = 'HARPO' #actor_id = 172
WHERE actor_id = 172; 

/*4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, 
change it to GROUCHO. Otherwise, change the #first name to MUCHO GROUCHO, as that is exactly what the actor will be with the grievous error. 
BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO MUCHO GROUCHO, HOWEVER! (Hint: update the record using a unique identifier.)
*/

UPDATE actor 
SET first_name = IF(first_name = 'HARPO', 'GROUCHO', 'MUCHO GROUCHO')
WHERE actor_id = 172;

#5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW CREATE TABLE address; 

#6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
SELECT address.address_id, address.address, staff.first_name, staff.last_name
FROM address JOIN staff
ON address.address_id = staff.address_id;  

#6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
SELECT staff.first_name, staff.last_name, sum(payment.amount)
FROM staff JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id; 

#6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT film.title, count(film_actor.actor_id)
FROM film INNER JOIN film_actor
ON film.film_id = film_actor.film_id
GROUP BY film.title
ORDER BY COUNT(film_actor.actor_id )DESC; 

#6d. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT film.title, COUNT(inventory.inventory_id)
FROM film JOIN inventory
ON film.film_id = inventory.film_id
WHERE film.title = 'Hunchback Impossible'; 

#6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
SELECT customer.first_name, customer.last_name, sum(payment.amount)
FROM customer JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY customer.last_name ASC;

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

#8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. 
CREATE VIEW executive_view AS
SELECT category.name, SUM(payment.amount) AS Gross_Revenue FROM film
JOIN inventory ON inventory.film_id =  film.film_id
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON category.category_id = film_category.category_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name 
ORDER BY (Gross_Revenue) DESC 
LIMIT 10;

#8b. How would you display the view that you created in 8a?
SELECT * FROM executive_view;

#8c. You find that you no longer need the view you just created. Write a query to delete it.
DROP VIEW executive_view; #ACTION #108 SHOWS DROPPED TABLE IN SCREENSHOT