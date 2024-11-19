-- DROP DATABASE IF EXISTS ICMSystemDB;

CREATE DATABASE IF NOT EXISTS ICMSystemDB;

USE ICMSystemDB;

CREATE TABLE IF NOT EXISTS suppliers (
	 supplier_id INT NOT NULL AUTO_INCREMENT,
	 supplier_name VARCHAR(100),
	 contact_number VARCHAR(15),
	 address VARCHAR(255),
	 PRIMARY KEY (supplier_id)
);

CREATE TABLE IF NOT EXISTS products (
	 product_id INT NOT NULL AUTO_INCREMENT,
	 product_name VARCHAR(100) NOT NULL,
	 batch_number VARCHAR(50) NOT NULL,
	 category VARCHAR(100) NOT NULL,
	 unit_price DECIMAL(10,2) NOT NULL,
	 date_of_manufacture DATE NOT NULL,
	 quantity INT NOT NULL,
	 price DECIMAL(10,2) NOT NULL DEFAULT '0',
     supplier_id INT,
	 PRIMARY KEY (product_id),
	 CONSTRAINT fk_products_suppliers FOREIGN KEY (supplier_id) REFERENCES suppliers (supplier_id)
);



CREATE TABLE IF NOT EXISTS employees (
	 employee_id INT NOT NULL AUTO_INCREMENT,
	 name VARCHAR(255),
	 role ENUM('staff', 'manager') NOT NULL,
	  PRIMARY KEY (employee_id)
);


CREATE TABLE IF NOT EXISTS customers (
	 customer_id INT NOT NULL AUTO_INCREMENT,
	 customer_name VARCHAR(100),
	 address VARCHAR(255),
	 contact_information VARCHAR(100),
	 payment_detail VARCHAR(100),
     employee_id INT,
	  PRIMARY KEY (customer_id),
	 CONSTRAINT fk_customer_employees FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);



CREATE TABLE IF NOT EXISTS inventory (
	 inventory_id INT NOT NULL AUTO_INCREMENT,
	 location VARCHAR(255),
	 production_quantity INT,
	 inventory_turnover DECIMAL(10,2),
	 last_update_date DATE,
     product_id INT,
     employee_id INT,
	 PRIMARY KEY (inventory_id),
	 CONSTRAINT fk_inventory_products FOREIGN KEY (product_id) REFERENCES products (product_id),
	 CONSTRAINT fk_inventory_employees FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);


CREATE TABLE IF NOT EXISTS orders (
	 order_id INT NOT NULL AUTO_INCREMENT,
	 order_date DATE,
	 status VARCHAR(50),
	 shipping_address VARCHAR(50),
	 amount DECIMAL,
     product_id INT,
     employee_id INT,
     customer_id INT, 
	  PRIMARY KEY (order_id),
	 CONSTRAINT fk_orders_products FOREIGN KEY (product_id) REFERENCES products (product_id),
	 CONSTRAINT fk_orders_employees FOREIGN KEY (employee_id) REFERENCES employees (employee_id),
	 CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);


CREATE TABLE IF NOT EXISTS warehouse (
	 warehouse_id INT NOT NULL AUTO_INCREMENT,
	 location’ VARCHAR(255),
	 capacity’ INT,
	 inventory_stored’ INT,
     employee_id INT,
		PRIMARY KEY (warehouse_id),
	 CONSTRAINT fk_warehouse_employees FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);


CREATE TABLE IF NOT EXISTS shipment (
	 shipment_id INT NOT NULL AUTO_INCREMENT,
	 shipment_date DATE,
	 status VARCHAR(50),
	 carrier VARCHAR(100),
	 deliver_date DATE,
     order_id INT,
	 PRIMARY KEY (shipment_id),
	 CONSTRAINT fk_shipment_orders FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

INSERT INTO Products (product_name, batch_number, category, unit_price, date_of_manufacture, quantity, price)
VALUES ('Laptop', 'BN123', 'Electronics', 500, '2024-10-01', 100, 600);


