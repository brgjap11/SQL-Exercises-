USE sakila;
#1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
SELECT first_name, last_name, Actor_Name
FROM actor; 
ALTER TABLE actor 
ADD COLUMN Actor_Name VARCHAR (20) NOT NULL;
SELECT CONCAT(first_name, last_name) as Actor_Name
FROM actor; 
