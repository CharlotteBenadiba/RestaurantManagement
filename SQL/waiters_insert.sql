INSERT INTO waiters (first_name, last_name) VALUES
('John', 'Smith'),
('Emma', 'Johnson'),
('Liam', 'Williams'),
('Olivia', 'Brown'),
('Noah', 'Jones'),
('Ava', 'Garcia'),
('Ethan', 'Martinez'),
('Sophia', 'Rodriguez'),
('Lucas', 'Davis'),
('Mia', 'Lopez'),
('Mason', 'Wilson'),
('Isabella', 'Anderson'),
('Logan', 'Thomas'),
('Amelia', 'Hernandez'),
('James', 'Moore'),
('Charlotte', 'Martin'),
('Benjamin', 'Lee'),
('Harper', 'Perez'),
('Alexander', 'White'),
('Evelyn', 'Harris');


SELECT * FROM waiters ORDER BY waiter_id ASC;
SELECT * FROM orders ORDER BY modified DESC;

ALTER TABLE waiters
ADD active BOOLEAN DEFAULT TRUE


ALTER TABLE Orders
DROP COLUMN food_unavailable;

DELETE FROM Orders WHERE order_id = 'OR115'

UPDATE Orders
SET amount_paid = total_price
WHERE order_id = 'OR108'

UPDATE Orders
SET payment_method_id = 4
WHERE order_id = 'OR112'