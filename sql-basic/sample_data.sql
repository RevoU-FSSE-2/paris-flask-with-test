-- RevoU Auto Garage Sample Data
-- This file contains sample data for testing and demonstration

-- Make sure to run schema.sql first to create the tables

-- Sample outlets
INSERT INTO outlets (name, address, phone)
VALUES 
    ('RevoU Auto Garage - Central', '123 Main Street, Jakarta', '+6221555123'),
    ('RevoU Auto Garage - North', '45 North Avenue, Jakarta', '+6221555456');

-- Sample services
INSERT INTO services (name, description, base_price)
VALUES 
    ('Tire Change', 'Removal and installation of tires', 150000.00),
    ('Car Wash', 'Exterior and interior cleaning', 85000.00),
    ('Tire Spooring', 'Wheel alignment service', 250000.00),
    ('Tire Balancing', 'Balancing of wheels for smooth ride', 200000.00);

-- Sample customers
INSERT INTO customers (name, phone, email, address)
VALUES 
    ('John Doe', '+628123456789', 'john.doe@email.com', 'Jl. Sudirman No. 123, Jakarta'),
    ('Jane Smith', '+628987654321', 'jane.smith@email.com', 'Jl. Thamrin No. 45, Jakarta'),
    ('Ahmad Rizki', '+628567891234', 'ahmad.r@email.com', 'Jl. Gatot Subroto No. 67, Jakarta');

-- Sample transactions
INSERT INTO transactions (customer_id, outlet_id, transaction_date, total_amount, payment_method, notes)
VALUES 
    (1, 1, '2023-07-15 10:30:00', 235000.00, 'Credit Card', 'Regular customer'),
    (2, 2, '2023-07-16 14:45:00', 450000.00, 'Cash', 'New customer'),
    (3, 1, '2023-07-17 09:15:00', 200000.00, 'Debit Card', 'Requested quick service'),
    (1, 2, '2023-07-20 13:00:00', 335000.00, 'Credit Card', 'Follow-up service');

-- Sample transaction details
INSERT INTO transaction_details (transaction_id, service_id, quantity, unit_price, subtotal)
VALUES 
    (1, 1, 1, 150000.00, 150000.00),
    (1, 2, 1, 85000.00, 85000.00),
    (2, 3, 1, 250000.00, 250000.00),
    (2, 4, 1, 200000.00, 200000.00),
    (3, 2, 1, 85000.00, 85000.00),
    (3, 4, 1, 115000.00, 115000.00),
    (4, 1, 2, 150000.00, 300000.00),
    (4, 2, 1, 35000.00, 35000.00);
