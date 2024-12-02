SELECT * FROM ICMSystemDB.Inventory;

-- INSERT INTO Products (product_name, batch_number, category, unit_price, 
-- 			date_of_manufacture, initial_quantity, price, supplier_id)
-- VALUES('TEST PRODUCT', 'BN12345', 'Home Goods', 34.00, '2024-11-15', 2000, 56.00, 1);

-- SELECT * FROM ICMSystemDB.Inventory;

-- INSERT INTO Inventory (product_id, current_quantity, employee_id)
-- VALUES (8, 
--         (SELECT initial_quantity FROM Products WHERE product_id = 8),
-- 		(SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1));

-- UPDATE Inventory
-- SET current_quantity = current_quantity - 4 WHERE product_id = 8 AND current_quantity>0;

-- DELETE FROM Inventory WHERE inventory_id = 8;

SELECT SUM(current_quantity) AS total_inventory_items
FROM Inventory;



-- SELECT * FROM ICMSystemDB.Inventory;