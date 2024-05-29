INSERT INTO waitlist (first_name, last_name, email, phone_number) VALUES
('John', 'Doe', 'john.doe@example.com', 5551234567),
('Jane', 'Smith', 'jane.smith@example.com', 5552345678),
('Alice', 'Johnson', 'alice.j@example.com', 5553456789),
('Bob', 'Brown', 'bob.brown@example.com', 5554567890),
('Carol', 'Davis', 'carol.davis@example.com', 5555678901),
('Dave', 'Wilson', 'dave.wilson@example.com', 5556789012),
('Eve', 'Moore', 'eve.moore@example.com', 5557890123),
('Frank', 'Taylor', 'frank.t@example.com', 5558901234),
('Grace', 'Anderson', 'grace.a@example.com', 5559012345),
('Henry', 'Thomas', 'henry.thomas@example.com', 5550123456);

SELECT * FROM waitlist;
SELECT * FROM customers WHERE first_name = 'Alice';
SELECT * FROM payment_method

INSERT INTO payment_method (type) VALUES
('Cash'),
('American Express'),
('Visa'),
('Mastercard');