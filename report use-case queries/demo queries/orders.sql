SELECT * FROM ICMSystemDB.Orders;

-- INSERT INTO Customers (customer_name, address, contact_number, payment_detail, employee_id)
-- VALUES ('TEST CUSTOMER', '123 CUSTOMER St, Houton, Tx', '7135437853', 'Visa', 
-- 		(SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1)); 

-- INSERT INTO Orders (order_date, order_status, shipping_address, customer_id)	
-- VALUES ( '2024-05-01',
-- 	3, 				-- order status
--     (SELECT address
--     FROM Customers
--     WHERE customer_id = 9),
-- 	(SELECT customer_id
-- 	FROM Customers
-- 	WHERE customer_id = 9));


-- UPDATE Orders
-- SET order_status = 'Canceled'
-- WHERE order_id = 5;
 
 -- DELETE FROM Orders WHERE order_id = 6;

SELECT COUNT(order_id) AS number_of_orders
FROM Orders;
 
 -- SELECT * FROM ICMSystemDB.Orders;
    