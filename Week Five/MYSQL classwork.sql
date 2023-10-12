-- Create a table in MYSQL feat. CHECK, CONSTRAINT, and PRIMARY/FOREIGN Keys

CREATE TABLE IF NOT EXISTS bank(
customer_id INT NOT NULL,
account_number INT NOT NULL,
balance NUMERIC(10,2),
age INT,
CONSTRAINT above_zero CHECK (balance >=0),
CONSTRAINT pri_key_bank PRIMARY KEY (customer_id, account_number)
);

SELECT *
FROM bank;

-- How do I drop a table?
DROP TABLE bank;

-- What happens if I try to violate my constraint?
INSERT INTO bank
VALUES(1, 0000001, 27, 97, 'Randall', 'Thomas');

/* 
I already have my bank table made up. But I forgot to add in any real customer details
I want to add in the first name and last name at least, so let's use the ALTER statement to do so
*/
ALTER TABLE bank
ADD first_name VARCHAR(255);

ALTER TABLE bank
ADD last_name INT;

ALTER TABLE bank
MODIFY COLUMN last_name VARCHAR(255);
-- View our work so far
SELECT *
FROM bank;

-- Insert in new customer data:
INSERT INTO bank
VALUES(2, 2, 5000, 25, 'James', 'Stratton');

-- DROP a constraint
ALTER TABLE bank
DROP CHECK above_zero;

-- Drop a column
ALTER TABLE bank
DROP COLUMN first_name;

-- Just want to remove all my data from my table
TRUNCATE TABLE bank;

-- Move columns
ALTER TABLE bank
MODIFY COLUMN last_name VARCHAR(255) AFTER first_name;

-- Update to tables and rows based on conditionals
SET SQL_SAFE_UPDATES = 0;
UPDATE bank
SET balance = 1000000.00
WHERE age = 25;

-- VIEW a subsection of a table that we can basically save and interact with on its own like a variable
CREATE VIEW high_rollers AS
SELECT customer_id, CONCAT(first_name, ' ', last_name) as full_name, balance
FROM bank
WHERE balance > 100000;

SELECT *
FROM high_rollers

/*
A stored procedure is much like a function. The difference between a function is that a function returns a value and cannot run DML queries.
BUT a procedure can run any form of query, however will not return values, but overwrite them or add them directly to the table
*/
USE bonfire_129
DELIMITER //
CREATE PROCEDURE latefee(
	-- Take in two input variables, they go here!
IN customer INT,
IN late_fee_amount DECIMAL(10,2)
)

-- This is where the procedure begins:
BEGIN
-- Update the payment table
UPDATE payment
-- Set the amount column equal to the new late fee amount
SET amount = amount + late_fee_amount
-- Conditional to ensure we don't update ALL records
WHERE customer_id = customer;

-- Commit any changes made by the procedure
COMMIT;
-- End the procedure
END //

SELECT *
FROM payment;

CALL latefee(343, 2.00);

SELECT * 
From bank

-- Adding an actor to the actor table
DELIMITER //
CREATE PROCEDURE add_actor(
IN a_id INT,
IN f_name VARCHAR(45),
IN l_name VARCHAR(45),
IN l_update TIMESTAMP
)

BEGIN
INSERT INTO actor
VALUES(a_id, f_name, l_name, l_update);
END //

CALL add_actor(201, 'Gabriel', 'Iglesias', NOW());

SELECT *
FROM actor


