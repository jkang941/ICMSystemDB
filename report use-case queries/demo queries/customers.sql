SELECT * FROM ICMSystemDB.Customers;

-- INSERT INTO Customers (customer_name, address, contact_number, payment_detail, employee_id)
-- VALUES ('TEST CUSTOMER', '123 CUSTOMER St, Houton, Tx', '7135437853', 'Visa', 
-- 		(SELECT employee_id FROM employees WHERE role = 'staff' ORDER BY RAND() LIMIT 1)); 

-- UPDATE Customers
-- SET customer_name = 'TEST CUSTOMER UPDATE'
-- WHERE customer_id = 9;

 -- DELETE FROM Customers WHERE customer_id = 9;

SELECT COUNT(customer_id) AS number_of_customers
FROM Customers;

-- SELECT * FROM ICMSystemDB.Customers;