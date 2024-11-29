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
	 quantity INT NOT NULL,
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
	 location VARCHAR(255),
	 production_quantity INT,
	 inventory_turnover DECIMAL(10,2),
	 last_update_date DATE,
     product_id INT,
     employee_id INT,
	 PRIMARY KEY (inventory_id),
	 CONSTRAINT fk_inventory_products FOREIGN KEY (product_id) REFERENCES Products (product_id),
	 CONSTRAINT fk_inventory_employees FOREIGN KEY (employee_id) REFERENCES Employees (employee_id)
);


CREATE TABLE IF NOT EXISTS Orders (
	 order_id INT NOT NULL AUTO_INCREMENT,
	 order_date DATE,
	 status VARCHAR(50) NOT NULL,
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
);

CREATE TABLE IF NOT EXISTS OrderItems (
	order_items_id INT NOT NULL AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity DECIMAL NOT NULL,
    price DECIMAL(10,2) DEFAULT 0.00,
    PRIMARY KEY (order_items_id),
    CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES Orders (order_id),
    CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES Products (product_id)
);

CREATE TABLE IF NOT EXISTS OrderStatus(
	status_id INT NOT NULL AUTO_INCREMENT,
    status_value VARCHAR(255),
	PRIMARY KEY (status_id)
);

INSERT INTO OrderStatus (status_value)
VALUES ('Order is bring prepared'), -- 1
('Shipped'), -- 2
('Delivered'), -- 3
('Canceled'); -- 4

CREATE TABLE IF NOT EXISTS Warehouse (
	 warehouse_id INT NOT NULL AUTO_INCREMENT,
	 location VARCHAR(255),
	 capacity INT,
	 inventory_stored INT,
     employee_id INT,
		PRIMARY KEY (warehouse_id),
	 CONSTRAINT fk_warehouse_employees FOREIGN KEY (employee_id) REFERENCES Employees (employee_id)
);


CREATE TABLE IF NOT EXISTS Shipment (
	 shipment_id INT NOT NULL AUTO_INCREMENT,
	 shipment_date DATE,
	 status VARCHAR(50),
	 carrier VARCHAR(100),
	 deliver_date DATE,
     order_id INT,
	 PRIMARY KEY (shipment_id),
	 CONSTRAINT fk_shipment_orders FOREIGN KEY (order_id) REFERENCES Orders (order_id)
);

INSERT INTO Suppliers (supplier_name, contact_number,address)
VALUES ('ABC Electronics', 7131111001, '123 Main St, Houston, Tx'),
('XYZ Clothing', 7132221002, '123 32th St, Houston, Tx'),
('Good Foods Co', 7133331003, '123 32th St, Houston, Tx'),
('Home Stuff Co', 7135551005, '101 Industrial Rd, Houston,Tx');

INSERT INTO Products (product_name, batch_number, category, unit_price, date_of_manufacture, quantity, price, supplier_id)
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


INSERT INTO Employees (name, role, contact_number, address)
VALUES ('John Doe', 'manager', '7121231111', '123 Houston St, Houston, Tx'),
	('Jane Smith', 'staff', '7121232222', '234 Katy St, Katy, Tx'),
	('Alice Johnson', 'staff', '7121233333', '3453 Sugarland St, Sugarland, Tx'),
	('Bob Brown', 'manager', '7121234444', '123 Woodlands St, Woodlands, Tx'),
	('Charlies Davis', 'staff', '7121235555', '123 Spring St, Spring, Tx'),
	('Jack Bauer', 'staff', '7121236666', '123 Humble St, Humble, Tx');

INSERT INTO Customers (customer_name, address, contact_number, payment_detail, employee_id)
VALUES ('Jack Smith', '123 Qwerty St, Houton, Tx', '7131111111', 'Visa',
	(SELECT employee_id
    FROM employees
    WHERE role = 'staff'
    ORDER BY RAND()
    LIMIT 1)),
('Dana White', '234 UFC Rd, Houston, Tx', '7132222222', 'AMEX',
	(SELECT employee_id
    FROM employees
    WHERE role = 'staff'
    ORDER BY RAND()
    LIMIT 1)),
('Deadpool', '345 Marvel Ln, Houston, Tx', '7133333333', 'VISA',
	(SELECT employee_id
    FROM employees
    WHERE role = 'staff'
    ORDER BY RAND()
    LIMIT 1)),
('Georgia Blue', '202 Birch St, Houston, Tx', '7134444444', 'VISA',
	(SELECT employee_id
    FROM employees
    WHERE role = 'staff'
    ORDER BY RAND()
    LIMIT 1)),
('Ethan Green', '303 Cedar St, Houston, Tx', '7135555555', 'VISA',
	(SELECT employee_id
    FROM employees
    WHERE role = 'staff'
    ORDER BY RAND()
    LIMIT 1)),
('Fiona Black', '3404 Spruce St, Houston, Tx', '7136666666', 'VISA',
	(SELECT employee_id
    FROM employees
    WHERE role = 'staff'
    ORDER BY RAND()
    LIMIT 1)),
('Hannah Gray', '707 Aspen St, Houston, Tx', '7137777777', 'MASTERCARD',
	(SELECT employee_id
    FROM employees
    WHERE role = 'staff'
    ORDER BY RAND()
    LIMIT 1)),
('Alice Johnson', '789 Pine St, Houston, Tx', '7138888888', 'VISA',
	(SELECT employee_id
    FROM employees
    WHERE role = 'staff'
    ORDER BY RAND()
    LIMIT 1))
;
    


INSERT INTO Orders (order_date, status, shipping_address, customer_id)	
VALUES (CURDATE(), 
	(SELECT status_value
    FROM OrderStatus
    WHERE status_id = 1), 
    (SELECT address
    FROM Customers
    WHERE customer_name = "Jack Smith"),
	(SELECT customer_id
	FROM Customers
	WHERE customer_name = "Jack Smith")),
    
    (CURDATE(),
    (SELECT status_value
    FROM OrderStatus
    WHERE status_id = 1),
	(SELECT address
    FROM Customers
    WHERE customer_name = "Dana White"),
    (SELECT customer_id
	FROM Customers
	WHERE customer_name = "Dana White"));
    
-- Customer Order Items
-- Jack Smith   
SET @jacksmith = (SELECT order_id FROM ORDERS WHERE customer_id = 1);
INSERT INTO OrderItems(order_id, product_id, quantity, price)
VALUES ( @jacksmith, 1, 1,
		(SELECT price FROM Products WHERE product_id = 1)),
		( @jacksmith, 3, 1,
		(SELECT price FROM Products WHERE product_id = 3)),
		( @jacksmith, 5, 2,
        (SELECT price FROM Products WHERE product_id = 5));

UPDATE Products SET quantity = quantity -1 WHERE product_id = 1 AND quantity >0;
UPDATE Products SET quantity = quantity -1 WHERE product_id = 3 AND quantity >0;
UPDATE Products SET quantity = quantity -2 WHERE product_id = 5 AND quantity >0;

-- Customer Order Items
-- Dana White  
SET @danawhite = (SELECT order_id FROM ORDERS WHERE customer_id = 2);
INSERT INTO OrderItems(order_id, product_id, quantity, price)
VALUES ( @danawhite, 2, 1,
		(SELECT price FROM Products WHERE product_id = 2)),
		( @danawhite, 6, 5,
        (SELECT price FROM Products WHERE product_id = 6)),
		( @danawhite, 7, 4,
		(SELECT price FROM Products WHERE product_id = 7));

UPDATE Products SET quantity = quantity -1 WHERE product_id = 2 AND quantity >0;
UPDATE Products SET quantity = quantity -5 WHERE product_id = 6 AND quantity >0;
UPDATE Products SET quantity = quantity -4 WHERE product_id = 7 AND quantity >0;




INSERT INTO Warehouse(location, capacity, inventory_stored, employee_id)
VALUES('Warehouse A, Springfield, IL', 10000, 5000, 1),
('Warehouse B, Springfield, IL', 8000, 3000, 4),
('Warehouse C, Springfield, IL', 12000, 6000, 4),
('Warehouse D, Springfield, IL', 15000, 7000, 1),
('Warehouse E, Springfield, IL', 9000, 45000, 4),
('Warehouse F, Springfield, IL', 11000, 55000, 1),
('Warehouse G, Springfield, IL', 14000, 6800, 1);



    
    
    




    


