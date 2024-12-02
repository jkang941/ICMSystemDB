INSERT INTO Products (product_name, batch_number, category, unit_price, 
			date_of_manufacture, initial_quantity, price, supplier_id)
VALUES('TEST PRODUCT', 'BN12345', 'Home Goods', 34.00, '2024-11-15', 2000, 56.00, 1);

UPDATE Products
SET price = 700.00, product_name = 'Laptop 15"'
WHERE product_id = 8;


DELETE FROM Products WHERE product_id = 'TEST LAPTOP 15"';