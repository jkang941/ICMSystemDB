-- orderitems

SET @testperson = (SELECT order_id FROM ORDERS WHERE customer_id = 9); -- variable
INSERT INTO OrderItems(order_id, product_id, quantity, price, total_price)
VALUES ( @testperson, 2, 1,
		(SELECT price FROM Products WHERE product_id = 2), 
        quantity * price),
		( @testperson, 4, 4,
		(SELECT price FROM Products WHERE product_id = 4),
        quantity * price),
		( @testperson, 6, 2,
        (SELECT price FROM Products WHERE product_id = 6),
        quantity * price);

UPDATE Inventory SET current_quantity = current_quantity -1 WHERE product_id = 2 AND current_quantity >0;
UPDATE Inventory SET current_quantity = current_quantity -4 WHERE product_id = 4 AND current_quantity >0;
UPDATE Inventory SET current_quantity = current_quantity -2 WHERE product_id = 6 AND current_quantity >0;


UPDATE OrderItems
SET quantity = quantity + 100
WHERE order_id = 6 AND product_id = 2;


DELETE FROM OrderItems WHERE order_id = 6 AND product_id = 2;

SELECT SUM(total_price) AS total_order_price
FROM OrderItems
WHERE order_id = 6
GROUP BY order_id;