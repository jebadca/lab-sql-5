USE sakila;

#1.Drop column picture from staff.
ALTER TABLE staff DROP COLUMN picture;

#2.A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
INSERT INTO staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update)
VALUES (3, 'Tammy', 'Sanders', 79, 'tammy.sanders@sakilastaff.com', 2, 1, 'Tammy',  NULL, CURRENT_TIMESTAMP);

SELECT * FROM staff;

#3.Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
SELECT * FROM rental
ORDER BY rental_id DESC;

SELECT customer_id FROM customer
WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER';

SELECT * FROM film
WHERE title LIKE "Academy Dinosaur";

SELECT * FROM inventory
WHERE film_id = 1;

SELECT * FROM staff
WHERE first_name LIKE 'Mike';

INSERT INTO rental (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES (16050, CURRENT_TIMESTAMP, 1, 130, NULL, 1, CURRENT_TIMESTAMP);

SELECT * FROM rental
WHERE rental_id = 16050;

#4.Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
	#Check if there are any non-active users
    #Create a table backup table as suggested
    #Insert the non active users in the table backup table
    #Delete the non active users from the table customer

SELECT * FROM customer
WHERE active = 0; 

CREATE TABLE deleted_users(
	customer_id int(11) default null,
    store_id int(11) default null,
    first_name VARCHAR(50) default null,
    last_name VARCHAR(50) default null,
    email VARCHAR(50) default null,
    address_id int(11) default null,
    active int(1) default null,
    create_date DATE default null,
    date_deleted DATE default CURRENT_TIMESTAMP
);

INSERT INTO deleted_users values (16,2,'SANDRA','MARTIN','SANDRA.MARTIN@sakilacustomer.org',20,0,"2006-02-14 22:04:36","2023-02-25 12:45:36"), 
(64,2,'JUDITH','COX','JUDITH.COX@sakilacustomer.org',68,0,"2006-02-14 22:04:36","2023-02-25 12:45:36"),
(124,1,'SHEILA','WELLS','SHEILA.WELLS@sakilacustomer.org',128,0,"2006-02-14 22:04:36","2023-02-25 12:45:36"),
(169,2,'ERICA','MATTHEWS','ERICA.MATTHEWS@sakilacustomer.org',173,0,"2006-02-14 22:04:36","2023-02-25 12:45:36"),
(241,2,'HEIDI','LARSON','HEIDI.LARSON@sakilacustomer.org',245,0,"2006-02-14 22:04:36","2023-02-25 12:45:36"),
(271,1,'PENNY','NEAL','PENNY.NEAL@sakilacustomer.org',276,0,"2006-02-14 22:04:36","2023-02-25 12:45:36"),
(315,2,'KENNETH','GOODEN','KENNETH.GOODEN@sakilacustomer.org',320,0,"2006-02-14 22:04:37","2023-02-25 12:45:36"),
(368,1,'HARRY','ARCE','HARRY.ARCE@sakilacustomer.org',373,0,"2006-02-14 22:04:37","2023-02-25 12:45:36"),
(406,1,'NATHAN','RUNYON','NATHAN.RUNYON@sakilacustomer.org',411,0,"2006-02-14 22:04:37","2023-02-25 12:45:36"),
(446,2,'THEODORE','CULP','THEODORE.CULP@sakilacustomer.org',451,0,"2006-02-14 22:04:37","2023-02-25 12:45:36"),
(482,1,'MAURICE','CRAWLEY','MAURICE.CRAWLEY@sakilacustomer.org',487,0,"2006-02-14 22:04:37","2023-02-25 12:45:36"),
(510,2,'BEN','EASTER','BEN.EASTER@sakilacustomer.org',515,0,"2006-02-14 22:04:37","2023-02-25 12:45:36"),
(534,1,'CHRISTIAN','JUNG','CHRISTIAN.JUNG@sakilacustomer.org',540,0,"2006-02-14 22:04:37","2023-02-25 12:45:36"),
(558,1,'JIMMIE','EGGLESTON','JIMMIE.EGGLESTON@sakilacustomer.org',564,0,"2006-02-14 22:04:37","2023-02-25 12:45:36"),
(592,1,'TERRANCE','ROUSH','TERRANCE.ROUSH@sakilacustomer.org',598,0,"2006-02-14 22:04:37","2023-02-25 12:45:36"
);

SELECT * FROM deleted_users;

DELETE FROM customer WHERE active = 0; #Here we get an error, due to referential integrity. Other tables beyond customer use customer_id as a foreign key, so if we delete this data without deleting all references to customer id across other tables, we will have a problem of referential integrity. In this case, we won't do it to protect the integrity of the database for future use. 