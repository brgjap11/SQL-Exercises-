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