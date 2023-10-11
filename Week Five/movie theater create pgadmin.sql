-- Customer Table Creation
CREATE TABLE IF NOT EXISTS customer(
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email_address VARCHAR(100),
    address VARCHAR (150)
);

-- Movie Table Creation
CREATE TABLE IF NOT EXISTS movie(
    movie_id SERIAL PRIMARY KEY,
    movie_name VARCHAR (500)
);

-- Ticket Table Creation
CREATE TABLE IF NOT EXISTS ticket(
    ticket_id SERIAL PRIMARY KEY,
    price NUMERIC(8,2),
    customer_id INTEGER,
    movie_id INTEGER,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY(movie_id) REFERENCES movie(movie_id)
);

-- Concession Table Creation
CREATE TABLE IF NOT EXISTS concession(
    transaction_id SERIAL PRIMARY KEY,
    price NUMERIC (8,2),
    customer_id INTEGER,
    item_id INTEGER, 
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id) 
);

-- Inventory Table Creation
CREATE TABLE IF NOT EXISTS inventory(
    inventory_id SERIAL PRIMARY KEY,
    ticket_id INTEGER,
    item_id INTEGER,
    FOREIGN KEY(ticket_id) REFERENCES ticket(ticket_id)
);


