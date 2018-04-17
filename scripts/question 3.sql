use sakila; 
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

SELECT * FROM actor; 




 