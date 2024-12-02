SELECT * FROM ICMSystemDB.Suppliers;

-- INSERT INTO Suppliers (supplier_name, contact_number,address)
-- VALUES ('TEST SUPPLIER', '7131234567', 'Test Supplier St, Houston, Tx');

-- UPDATE Suppliers
-- SET contact_number = '2813333333'
-- WHERE supplier_id = 5; 

-- DELETE FROM Suppliers WHERE supplier_id = 5;

SELECT supplier_name, COUNT(product_id) AS total_products 
FROM Suppliers 
JOIN Products ON Suppliers.supplier_id = Products.supplier_id 
GROUP BY supplier_name;


-- SELECT * FROM ICMSystemDB.Suppliers;