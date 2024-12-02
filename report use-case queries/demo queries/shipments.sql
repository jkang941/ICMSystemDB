SELECT * FROM ICMSystemDB.Shipments;

SET @testperson = (SELECT order_id FROM ORDERS WHERE customer_id = 9); -- variable
-- INSERT INTO OrderItems(order_id, product_id, quantity, price, total_price)
-- VALUES ( @testperson, 2, 1,
-- 		(SELECT price FROM Products WHERE product_id = 2), 
--         quantity * price),
-- 		( @testperson, 4, 4,
-- 		(SELECT price FROM Products WHERE product_id = 4),
--         quantity * price),
-- 		( @testperson, 6, 2,
--         (SELECT price FROM Products WHERE product_id = 6),
--         quantity * price);

-- UPDATE Inventory SET current_quantity = current_quantity -1 WHERE product_id = 2 AND current_quantity >0;
-- UPDATE Inventory SET current_quantity = current_quantity -4 WHERE product_id = 4 AND current_quantity >0;
-- UPDATE Inventory SET current_quantity = current_quantity -2 WHERE product_id = 6 AND current_quantity >0;


-- INSERT INTO Shipments (shipment_date, carrier, estimated_delivery_date, order_id)
-- VALUES ((SELECT DATE_ADD(
-- 		(SELECT order_date
-- 		FROM Orders
-- 		WHERE order_id = @testperson), INTERVAL 1 DAY)),
--         'UPS',
--         (SELECT DATE_ADD(
--         (SELECT order_date
-- 		FROM Orders
-- 		WHERE order_id = @testperson), INTERVAL 5 DAY)),
--         @testperson);

-- UPDATE Shipments
-- SET carrier = 'Fedex'
-- WHERE shipment_id = 5;

-- DELETE FROM Shipments WHERE shipment_id = 5;

SELECT COUNT(shipment_id) AS total_shipment_orders
FROM Shipments;
       

        
 -- SELECT * FROM ICMSystemDB.Shipments;        