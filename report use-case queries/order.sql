-- orders

INSERT INTO Orders (order_date, order_status, shipping_address, customer_id)	
VALUES ( '2024-05-01',
	3, 				-- order status
    (SELECT address
    FROM Customers
    WHERE customer_id = 9),
	(SELECT customer_id
	FROM Customers
	WHERE customer_id = 9));
	
UPDATE Orders
SET order_status = 'Canceled'
WHERE order_id = 5;

 DELETE FROM Orders WHERE order_id = 5;
 
 
 SELECT COUNT(order_id) AS number_of_orders
FROM Orders;