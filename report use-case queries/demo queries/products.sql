SELECT * FROM ICMSystemDB.Products;

-- INSERT INTO Products (product_name, batch_number, category, unit_price, 
-- 			date_of_manufacture, initial_quantity, price, supplier_id)
-- VALUES('TEST PRODUCT', 'BN12345', 'Home Goods', 34.00, '2024-11-15', 2000, 56.00, 1);

-- DELETE FROM Products WHERE product_id =8;
-- SELECT SUM( initial_quantity * unit_price) AS total_stock_value
-- FROM Products;

SELECT SUM( initial_quantity * unit_price) AS total_stock_value
FROM Products;

-- SELECT * FROM ICMSystemDB.Products;