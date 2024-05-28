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


SELECT * FROM waiters;
SELECT * FROM orders ORDER BY modified DESC;

UPDATE Orders 
SET cancelled = FALSE 
WHERE order_id = 'OR109'

ALTER TABLE Orders
DROP COLUMN food_unavailable;