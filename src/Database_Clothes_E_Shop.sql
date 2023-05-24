/* First part of assignment */

-- Creating tables

create table Category(
    category_id number(15) NOT NULL PRIMARY KEY,
    category_name varchar(15) NOT NULL
);


create table Customer_address(
    address_id number(15) NOT NULL PRIMARY KEY,
    street varchar(20) NOT NULL,
    postal_code varchar(20) NOT NULL,
    city varchar(20) NOT NULL,
    country varchar(20) NOT NULL
);


create table Customer(
    customer_id number(15) NOT NULL PRIMARY KEY,
    first_name varchar(20) NOT NULL,
    last_name varchar(20) NOT NULL,
    email varchar(40) NOT NULL UNIQUE,
    phone_number varchar(15),
    preffered_payment_method varchar(20),
    address_id number(15) NOT NULL
);


create table Order_info(
   order_id number(15) NOT NULL PRIMARY KEY,
   order_date date NOT NULL,
   customer_id number(15) NOT NULL
);


create table Payment(
    payment_id number(15) NOT NULL PRIMARY KEY,
    payment_method varchar(20) NOT NULL,
    amount number(8,2) NOT NULL,
    order_id number(15) NOT NULL
);


create table Product(
    product_id number(15) NOT NULL PRIMARY KEY,
    order_quantity number(2) NOT NULL,
    product_price number(8,2) NOT NULL,
    product_size varchar(2) NOT NULL,
    product_name varchar(30) NOT NULL,
    product_description varchar(500) NOT NULL,
    discount number(2),
    order_id number(15) NOT NULL
);


-- M:N third table between Product and Category tables
create table Product_category(
    product_id number(15) NOT NULL REFERENCES Product(product_id),
    category_id number(15) NOT NULL REFERENCES Category(category_id),
    PRIMARY KEY (product_id, category_id)
);


create table Review(
    review_id number(15) NOT NULL PRIMARY KEY,
    amount_of_stars number NOT NULL,
    product_id number(15) NOT NULL,
    customer_id number(15) NOT NULL
);


create table Order_history(
    order_history_id number(15) NOT NULL PRIMARY KEY,
    order_price number(8,2) NOT NULL,
    order_date date NOT NULL,
    payment_method varchar(20) NOT NULL,
    customer_id number(15) NOT NULL,
    order_id number(15) NOT NULL
);



-- Connecting tables
ALTER TABLE Review
ADD FOREIGN KEY (product_id) REFERENCES Product(product_id);

ALTER TABLE Review
ADD FOREIGN KEY (customer_id) REFERENCES Customer(customer_id);

ALTER TABLE Customer
ADD FOREIGN KEY (address_id) REFERENCES Customer_address(address_id);

ALTER TABLE Order_history
ADD FOREIGN KEY (customer_id) REFERENCES Customer(customer_id);

ALTER TABLE Order_history
ADD FOREIGN KEY (order_id) REFERENCES Order_info(order_id);

ALTER TABLE Order_info
ADD FOREIGN KEY (customer_id) REFERENCES Customer(customer_id);

ALTER TABLE Payment
ADD FOREIGN KEY (order_id) REFERENCES Order_info(order_id);

ALTER TABLE Product
ADD FOREIGN KEY (order_id) REFERENCES Order_info(order_id);


-- Filling tables
INSERT ALL 
    INTO Category (category_id, category_name) VALUES ('123456789012345', 'T-Shirts')
    INTO Category (category_id, category_name) VALUES ('123456789012346', 'Pants')

    INTO Customer_address (address_id, street, postal_code, city, country) VALUES ('123456789012345', 'Street 5', '123 02', 'Moscow', 'Russia')
    INTO Customer_address (address_id, street, postal_code, city, country) VALUES ('123456789012346', 'Main street 10', '123 01', 'Beijing', 'China')

    INTO Customer (customer_id, first_name, last_name, email, phone_number, preffered_payment_method, address_id) VALUES ('123456789012345', 'Person1', 'LastName2', 'person1.lastname@protonmail.com', '+393955190555', 'ApplePay', '123456789012345')
    INTO Customer (customer_id, first_name, last_name, email, phone_number, preffered_payment_method, address_id) VALUES ('123456789012346', 'Person2', 'LastName2', 'person2.lastname@protonmail.com', '+419955190666', 'PayPal', '123456789012346')

    INTO Order_info (order_id, order_date, customer_id) VALUES ('123456789012345', TO_DATE('25-12-2022', 'DD-MM-YYYY'), '123456789012345')
    INTO Order_info (order_id, order_date, customer_id) VALUES ('123456789012346', TO_DATE('30-1-2023', 'DD-MM-YYYY'), '123456789012346')

    INTO Payment (payment_id, payment_method, amount, order_id) VALUES ('123456789012345', 'ApplePay', '200', '123456789012345')
    INTO Payment (payment_id, payment_method, amount, order_id) VALUES ('123456789012346', 'ApplePay', '100', '123456789012346')

    INTO Product (product_id, order_quantity, product_price, product_size, product_name, product_description, discount, order_id) VALUES ('123456789012345', '2', '15', 'L', 'Black Penguin T-Shirt', 'Beautiful black T-Shirt with a cute penguin on it!', '10', '123456789012345')
    INTO Product (product_id, order_quantity, product_price, product_size, product_name, product_description, discount, order_id) VALUES ('123456789012346', '1', '13', 'M', 'White Penguin T-Shirt', 'Beautiful white T-Shirt with a cute penguin on it!', '10', '123456789012346')

    INTO Product_category (product_id, category_id) VALUES ('123456789012345', '123456789012345')
    INTO Product_category (product_id, category_id) VALUES ('123456789012346', '123456789012346')

    INTO Review (review_id, amount_of_stars, product_id, customer_id) VALUES ('123456789012345', '3','123456789012345', '123456789012345')
    INTO Review (review_id, amount_of_stars, product_id, customer_id) VALUES ('123456789012346', '5','123456789012346', '123456789012346')

    INTO Order_history (order_history_id, order_price, order_date, payment_method, customer_id, order_id) VALUES ('123456789012345', '200', TO_DATE('25-12-2022', 'DD-MM-YYYY'), 'ApplePay', '123456789012345', '123456789012345')
    INTO Order_history (order_history_id, order_price, order_date, payment_method, customer_id, order_id) VALUES ('123456789012346', '100', TO_DATE('30-1-2023', 'DD-MM-YYYY'), 'GooglePay', '123456789012346', '123456789012346')

SELECT * FROM Dual;



/* Second part of assignment */

-- 2 Views with select on one table

/**
 * Nontrivial select - Builtin function
 * This view shows name of the most expensive product and its price from table Product 
 */
CREATE OR REPLACE VIEW most_expensive_product AS
SELECT product_name, product_price FROM Product
WHERE product_price = (SELECT MAX(product_price) FROM Product);

SELECT * FROM most_expensive_product;


/**
 * Nontrivial select - Builtin function
 * This view shows date of the oldest (first) order from table Order_history
 */
CREATE OR REPLACE VIEW oldest_order AS
SELECT MIN(order_date) AS oldest_order_date FROM Order_history;

SELECT * FROM oldest_order;






-- 3 Views with joining tables 

/**
 * Outer join
 * This view shows names of customers and their addresses
 */
CREATE OR REPLACE VIEW names_and_addresses AS
SELECT c.first_name, c.last_name, ca.street, ca.postal_code, ca.city, ca.country FROM customer c
LEFT OUTER JOIN customer_address ca ON c.address_id = ca.address_id;

SELECT * FROM names_and_addresses;


/**
 * Joining 2 tables
 * This view shows names of customers, order ID, and dates of orders, which they have done
 */
CREATE OR REPLACE VIEW customers_and_orders AS
SELECT c.first_name, c.last_name, o.order_id, o.order_date FROM customer c
JOIN order_info o ON c.customer_id = o.customer_id;

SELECT * FROM customers_and_orders;





-- 2 Views using aggregative functions or group by

/**
 * Aggregative function and Group by
 * This view shows product IDs, product names and average of reviews from customers
 */
CREATE OR REPLACE VIEW average_product_rating AS
SELECT p.product_id, p.product_name, AVG(r.amount_of_stars) AS avg_rating FROM Product p
LEFT JOIN review r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name;

SELECT * FROM average_product_rating;

/**
 * Aggregative function and Group by
 * This view shows date of latest (newest) order
 */
CREATE OR REPLACE VIEW newest_order AS
SELECT MAX(order_date) AS newest_order_date FROM Order_history;

SELECT * FROM newest_order;






-- 2 Views using nested selects

/**
 * Nested select
 * This view shows customer IDs, their names and emails if they made an order
 */
CREATE OR REPLACE VIEW customers_that_made_order AS
SELECT customer_id, first_name, last_name, email FROM Customer
WHERE customer_id IN (SELECT customer_id FROM Order_history);

SELECT * FROM customers_that_made_order;
