 CREATE TABLE IF NOT EXISTS car(
 car_serial_number INT NOT NULL,
 make VARCHAR(50),
 model VARCHAR(50),
 used BOOLEAN,
 price NUMERIC(8,2),
 CONSTRAINT pri_key_car PRIMARY KEY (car_serial_number)
 );
 
CREATE TABLE IF NOT EXISTS customer(
customer_id INT NOT NULL,
car_serial_number INT NOT NULL,
first_name VARCHAR(100),
last_name VARCHAR(100),
address VARCHAR(150),
CONSTRAINT pri_key_customer PRIMARY KEY (customer_id),
FOREIGN KEY (car_serial_number) REFERENCES car(car_serial_number)
);

CREATE TABLE IF NOT EXISTS salesperson(
salesperson_id INT NOT NULL,
first_name VARCHAR(100),
last_name VARCHAR(100),
CONSTRAINT pri_key_salesperson PRIMARY KEY (salesperson_id)
);

CREATE TABLE IF NOT EXISTS sales(
invoice_id INT NOT NULL,
salesperson_id INT NOT NULL,
car_serial_number INT NOT NULL,
customer_id INT NOT NULL,
total_sales NUMERIC(8,2),
CONSTRAINT pri_key_sales PRIMARY KEY (invoice_id),
FOREIGN KEY (salesperson_id) REFERENCES salesperson(salesperson_id),
FOREIGN KEY (car_serial_number) REFERENCES car(car_serial_number),
FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE IF NOT EXISTS service(
service_ticket_id INT NOT NULL,
car_serial_number INT NOT NULL,
customer_id INT NOT NULL,
mechanic_id INT NOT NULL,
part_id INT NOT NULL,
maintenance BOOLEAN,
CONSTRAINT pri_key_service PRIMARY KEY (service_ticket_id),
FOREIGN KEY (car_serial_number) REFERENCES car(car_serial_number),
FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

DELIMITER //
CREATE PROCEDURE add_data(
IN car_serial_number INT,
IN make VARCHAR(50),
IN model VARCHAR(50),
IN used BOOLEAN,
IN price NUMERIC(8,2)
)

BEGIN
INSERT INTO car
VALUES(car_serial_number, make, model, used, price);
END //

CALL add_data(1, 'Toyota', 'Rav4', 1, 2000);
CALL add_data(2, 'Ford', 'Fusion', 0, 5000);

SELECT *
FROM car

DELIMITER //
CREATE PROCEDURE add_data1(
IN customer_id INT,
IN car_serial_number INT,
IN first_name VARCHAR(100),
IN last_name VARCHAR(100),
IN address VARCHAR(150)
)

BEGIN
INSERT INTO customer
VALUES(customer_id, car_serial_number, first_name, last_name, address);
END //

CALL add_data1(1, 1, 'Andrew', 'Doroh', '123 Surf Street');
CALL add_data1(2, 2, 'Laura', 'Rivera', '124 Oakdale Drive');

SELECT *
FROM customer

DELIMITER //
CREATE PROCEDURE add_data2(
IN salesperson_id INT,
IN first_name VARCHAR(100),
IN last_name VARCHAR(100)
)

BEGIN
INSERT INTO salesperson
VALUES(salesperson_id, first_name, last_name);
END //

CALL add_data2(1, 'George', 'Lincoln');
CALL add_data2(2, 'Sarah', 'Smith');

SELECT *
FROM salesperson


DELIMITER //
CREATE PROCEDURE add_data3(
IN invoice_id INT,
IN salesperson_id INT,
IN car_serial_number INT,
IN customer_id INT,
IN total_sales NUMERIC(8,2)
)

BEGIN
INSERT INTO sales
VALUES(invoice_id, salesperson_id, car_serial_number, customer_id, total_sales);
END //

CALL add_data3(101, 1, 1, 1, 20000);
CALL add_data3(102, 2, 2, 2, 40000);

SELECT *
FROM sales


DELIMITER //
CREATE PROCEDURE add_data4(
IN service_ticket_id INT,
IN car_serial_number INT,
IN customer_id INT,
IN mechanic_id INT,
IN part_id INT,
IN maintenance BOOLEAN
)

BEGIN
INSERT INTO service
VALUES(service_ticket_id, car_serial_number, customer_id, mechanic_id, part_id, maintenance);
END //

CALL add_data4(1001, 1, 1, 1919, 0, 1);
CALL add_data4(1002, 2, 2, 2020, 78964, 0);

SELECT *
FROM service

