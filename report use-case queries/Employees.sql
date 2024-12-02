-- EMPLOYEE


INSERT INTO Employees (name, role, contact_number, address, salary)
VALUES ('TEST EMPLOYEE', 'staff', '2811011010', '123 NEW EMPLOYEE St, Houston, Tx', 45000);

UPDATE Employees
SET salary = salary + 5000
WHERE employee_id = 11;

DELETE FROM Employees WHERE employee_id = 11;

SELECT role, ROUND(AVG(salary), 2) As average_salary_by_roll
FROM Employees
GROUP BY role;

