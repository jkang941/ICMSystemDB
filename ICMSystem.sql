DROP DATABASE IF EXISTS ICMSystemDB;

CREATE DATABASE IF NOT EXISTS ICMSystemDB;

USE ICMSystemDB;

CREATE TABLE IF NOT EXISTS Suppliers (
	 supplier_id INT NOT NULL AUTO_INCREMENT,
	 supplier_name VARCHAR(100),
	 contact_number VARCHAR(15),
	 address VARCHAR(255),
	 PRIMARY KEY (supplier_id)
);

CREATE TABLE IF NOT EXISTS Products (
	 product_id INT NOT NULL AUTO_INCREMENT,
	 product_name VARCHAR(100) NOT NULL,
	 batch_number VARCHAR(50) NOT NULL,
	 category VARCHAR(100) NOT NULL,
	 unit_price DECIMAL(10,2) NOT NULL,
	 date_of_manufacture DATE NOT NULL,
	 initial_quantity INT NOT NULL,
	 price DECIMAL(10,2) NOT NULL DEFAULT '0',
     supplier_id INT NOT NULL,
	 PRIMARY KEY (product_id),
	 CONSTRAINT fk_products_suppliers FOREIGN KEY (supplier_id) REFERENCES Suppliers (supplier_id)
);



CREATE TABLE IF NOT EXISTS Employees (
	 employee_id INT NOT NULL AUTO_INCREMENT,
	 name VARCHAR(255),
	 role ENUM('staff', 'manager') NOT NULL,
     contact_number VARCHAR(15),
     address VARCHAR(255),
     salary INT NOT NULL,
	  PRIMARY KEY (employee_id)
);


CREATE TABLE IF NOT EXISTS Customers (
	 customer_id INT NOT NULL AUTO_INCREMENT,
	 customer_name VARCHAR(100),
	 address VARCHAR(255),
	 contact_number VARCHAR(100),
	 payment_detail VARCHAR(100),
     employee_id INT,
	  PRIMARY KEY (customer_id),
	 CONSTRAINT fk_customer_employees FOREIGN KEY (employee_id) REFERENCES Employees (employee_id)
);



CREATE TABLE IF NOT EXISTS Inventory (
	 inventory_id INT NOT NULL AUTO_INCREMENT,
	 -- location VARCHAR(255),
	 current_quantity INT NOT NULL,
	 -- inventory_turnover DECIMAL(10,2),
	 last_update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
     product_id INT,
     employee_id INT,
	 PRIMARY KEY (inventory_id),
	 CONSTRAINT fk_inventory_products FOREIGN KEY (product_id) REFERENCES Products (product_id) ON DELETE CASCADE,
	 CONSTRAINT fk_inventory_employees FOREIGN KEY (employee_id) REFERENCES Employees (employee_id)
     
);


CREATE TABLE IF NOT EXISTS Orders (
	 order_id INT NOT NULL AUTO_INCREMENT,
	 order_date DATE,
	 order_status ENUM('Order is bring prepared', 'Shipped', 'Delivered', 'Canceled') NOT NULL,
	 shipping_address VARCHAR(50),
	 -- amount DECIMAL,
     -- product_id INT,
     -- employee_id INT,
     customer_id INT, 
     -- total_price DECIMAL(10,2) NOT NULL,
	  PRIMARY KEY (order_id),
	 -- CONSTRAINT fk_orders_products FOREIGN KEY (product_id) REFERENCES Products (product_id),
	 -- CONSTRAINT fk_orders_employees FOREIGN KEY (employee_id) REFERENCES Employees (employee_id),
	 CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES Customers (customer_id)
     ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS OrderItems (
	order_items_id INT NOT NULL AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity DECIMAL NOT NULL,
    price DECIMAL(10,2) DEFAULT 0.00,
    total_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_items_id),
    CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES Orders (order_id) ON DELETE CASCADE,
    CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES Products (product_id)
);


CREATE TABLE IF NOT EXISTS Shipments (
	 shipment_id INT NOT NULL AUTO_INCREMENT,
	 shipment_date DATE,
	 carrier ENUM('Fedex', 'UPS', 'DHL', 'USPS') NOT NULL,
	 estimated_delivery_date DATE,
     order_id INT,
	 PRIMARY KEY (shipment_id),
	 CONSTRAINT fk_shipment_orders FOREIGN KEY (order_id) REFERENCES Orders (order_id)
     ON DELETE CASCADE
);



-- POPULATE TABLES 

INSERT INTO Suppliers (supplier_name, contact_number,address)
VALUES ('ABC Electronics', '7131111001', '123 Main St, Houston, Tx'),
('XYZ Clothing', '7132221002', '123 32th St, Houston, Tx'),
('Good Foods Co', '7133331003', '123 32th St, Houston, Tx'),
('Home Stuff Co', '7135551005', '101 Industrial Rd, Houston,Tx');

INSERT INTO Products (product_name, batch_number, category, unit_price, date_of_manufacture, initial_quantity, price, supplier_id)
VALUES ('Laptop', 'BN123', 'Electronics', 500.00, '2024-10-01', 100, 600.00,
	(SELECT supplier_id 
    FROM Suppliers 
    WHERE supplier_name = 'ABC Electronics')),
('TV', 'BN234', 'Electronics', 700.00, '2024-11-19', 200, 800.00,
	(SELECT supplier_id 
    FROM Suppliers 
    WHERE supplier_name = 'ABC Electronics')),
('T-Shirt', 'BN345', 'Clothing', 5.00, '2024-05-21', 100, 10.00,
	(SELECT supplier_id 
    FROM Suppliers 
    WHERE supplier_name = 'XYZ Clothing')),
('Apple', 'BN456', 'Grocery', .50, '2024-11-01', 100, 1.00,
	(SELECT supplier_id 
    FROM Suppliers 
    WHERE supplier_name = 'Good Foods Co')),
('Jeans', 'BN567', 'Clothing', 15.00, '2024-07-13', 100, 25.00,
	(SELECT supplier_id 
    FROM Suppliers 
    WHERE supplier_name = 'XYZ Clothing')),
('M&Ms', 'BN678', 'Grocery', 3.00, '2024-11-06', 40, 5.00,
	(SELECT supplier_id 
    FROM Suppliers 
    WHERE supplier_name = 'Good Foods Co')),
('Pillow', 'BN789', 'Home Goods', 4.00, '2024-08-20', 100, 7.00,
	(SELECT supplier_id 
    FROM Suppliers 
    WHERE supplier_name = 'Home Stuff Co'));

INSERT INTO Employees (name, role, contact_number, address, salary)
VALUES ('John Doe', 'manager', '7121231111', '123 Houston St, Houston, Tx', 120000),
	('Jane Smith', 'staff', '7121232222', '234 Katy St, Katy, Tx', 42000),
	('Alice Johnson', 'staff', '7121233333', '3453 Sugarland St, Sugarland, Tx', 48000),
	('Bob Brown', 'manager', '7121234444', '123 Woodlands St, Woodlands, Tx', 135000),
	('Charlies Davis', 'staff', '7121235555', '123 Spring St, Spring, Tx', 36000),
	('Jack Bauer', 'staff', '7121236666', '123 Humble St, Humble, Tx', 39000),
    ('Mickey Haller', 'manager', '7137777777', '9710 Katy Fwy, Houston, Tx', 150000),
    ('Gregory House', 'staff', '7138888888', '1 Main St, Houston, Tx', 42000),
    ('Steve Rogers', 'staff', '7139999999', '2 Main St, Houston, Tx', 43000),
    ('Huge Jackedman', 'staff', '7130000000', '5 Xman St, Houston, Tx', 49500);



INSERT INTO Inventory (product_id, current_quantity, employee_id)
VALUES ((SELECT product_id FROM Products WHERE product_name = 'Laptop'), 
        (SELECT initial_quantity FROM Products WHERE product_name = 'Laptop'),
		(SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1)),
        
        ((SELECT product_id FROM Products WHERE product_name = 'Jeans'), 
        (SELECT initial_quantity FROM Products WHERE product_name = 'Jeans'),
        (SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1)),
        
        ((SELECT product_id FROM Products WHERE product_name = 'M&Ms'), 
        (SELECT initial_quantity FROM Products WHERE product_name = 'M&Ms'),
        (SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1)),
        
        ((SELECT product_id FROM Products WHERE product_name = 'T-Shirt'), 
        (SELECT initial_quantity FROM Products WHERE product_name = 'T-Shirt'),
        (SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1)),
        
        ((SELECT product_id FROM Products WHERE product_name = 'TV'), 
        (SELECT initial_quantity FROM Products WHERE product_name = 'TV'),
        (SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1)),
        
        ((SELECT product_id FROM Products WHERE product_name = 'Apple'), 
        (SELECT initial_quantity FROM Products WHERE product_name = 'Apple'),
        (SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1)),
        
        ((SELECT product_id FROM Products WHERE product_name = 'Pillow'), 
        (SELECT initial_quantity FROM Products WHERE product_name = 'Pillow'),
        (SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1))
        ;
        
        



INSERT INTO Customers (customer_name, address, contact_number, payment_detail, employee_id)
VALUES ('Jack Smith', '123 Qwerty St, Houton, Tx', '7131111111', 'Visa', 
		(SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1)),
	('Dana White', '234 UFC Rd, Houston, Tx', '7132222222', 'AMEX', 
    (SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1)),
	('Deadpool', '345 Marvel Ln, Houston, Tx', '7133333333', 'VISA', 
    (SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1)),
	('Georgia Blue', '202 Birch St, Houston, Tx', '7134444444', 'VISA', 
    (SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1)),
	('Ethan Green', '303 Cedar St, Houston, Tx', '7135555555', 'VISA', 
    (SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1)),
	('Fiona Black', '3404 Spruce St, Houston, Tx', '7136666666', 'VISA', 
    (SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1)),
	('Hannah Gray', '707 Aspen St, Houston, Tx', '7137777777', 'MASTERCARD', 
    (SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1)),
	('Alice Johnson', '789 Pine St, Houston, Tx', '7138888888', 'VISA', 
    (SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1))
	;
    


INSERT INTO Orders (order_date, order_status, shipping_address, customer_id)	
VALUES ( '2024-11-07',
	1, 				-- order status
    (SELECT address
    FROM Customers
    WHERE customer_name = "Jack Smith"),
	(SELECT customer_id
	FROM Customers
	WHERE customer_name = "Jack Smith")),
    
    ('2024-07-08',
    2,				-- order status
	(SELECT address
    FROM Customers
    WHERE customer_name = "Dana White"),
    (SELECT customer_id
	FROM Customers
	WHERE customer_name = "Dana White"));
    
    
    
-- Customer Order Items
-- Jack Smith   
SET @jacksmith = (SELECT order_id FROM ORDERS WHERE customer_id = 1);
INSERT INTO OrderItems(order_id, product_id, quantity, price, total_price)
VALUES ( @jacksmith, 1, 1,
		(SELECT price FROM Products WHERE product_id = 1), 
        quantity * price),
		( @jacksmith, 3, 1,
		(SELECT price FROM Products WHERE product_id = 3),
        quantity * price),
		( @jacksmith, 5, 2,
        (SELECT price FROM Products WHERE product_id = 5),
        quantity * price);

UPDATE Inventory SET current_quantity = current_quantity -1 WHERE product_id = 1 AND current_quantity >0;
UPDATE Inventory SET current_quantity = current_quantity -1 WHERE product_id = 3 AND current_quantity >0;
UPDATE Inventory SET current_quantity = current_quantity -2 WHERE product_id = 5 AND current_quantity >0;


INSERT INTO Shipments (shipment_date, carrier, estimated_delivery_date, order_id)
VALUES ((SELECT DATE_ADD(
		(SELECT order_date
		FROM Orders
		WHERE order_id = @jacksmith), INTERVAL 1 DAY)),
        'Fedex',
        (SELECT DATE_ADD(
        (SELECT order_date
		FROM Orders
		WHERE order_id = @jacksmith), INTERVAL 5 DAY)),
        @jacksmith);
        




-- Customer Order Items
-- Dana White  
SET @danawhite = (SELECT order_id FROM ORDERS WHERE customer_id = 2);
INSERT INTO OrderItems(order_id, product_id, quantity, price, total_price)
VALUES ( @danawhite, 2, 1,
		(SELECT price FROM Products WHERE product_id = 2),
        quantity * price),
		( @danawhite, 6, 5,
        (SELECT price FROM Products WHERE product_id = 6),
        quantity * price),
		( @danawhite, 7, 4,
		(SELECT price FROM Products WHERE product_id = 7),
        quantity * price);

UPDATE Inventory SET current_quantity = current_quantity -1 WHERE product_id = 2 AND current_quantity >0;
UPDATE Inventory SET current_quantity = current_quantity -5 WHERE product_id = 6 AND current_quantity >0;
UPDATE Inventory SET current_quantity = current_quantity -4 WHERE product_id = 7 AND current_quantity >0;

INSERT INTO Shipments (shipment_date, carrier, estimated_delivery_date, order_id)
VALUES ((SELECT DATE_ADD(
		(SELECT order_date
		FROM Orders
		WHERE order_id = @danawhite), INTERVAL 1 DAY)),
        'UPS',
        (SELECT DATE_ADD(
        (SELECT order_date
		FROM Orders
		WHERE order_id = @danawhite), INTERVAL 5 DAY)),
        @danawhite);



    
    
    




    


