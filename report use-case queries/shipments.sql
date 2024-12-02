-- shipments

SET @testperson = (SELECT order_id FROM ORDERS WHERE customer_id = 9);

INSERT INTO Shipments (shipment_date, carrier, estimated_delivery_date, order_id)
VALUES ((SELECT DATE_ADD(
		(SELECT order_date
		FROM Orders
		WHERE order_id = @testperson), INTERVAL 1 DAY)),
        'UPS',
        (SELECT DATE_ADD(
        (SELECT order_date
		FROM Orders
		WHERE order_id = @testperson), INTERVAL 5 DAY)),
        @testperson);
        
UPDATE Shipments
SET carrier = 'Fedex'
WHERE shipment_id = 5; 


DELETE FROM Shipments WHERE shipment_id = 5;