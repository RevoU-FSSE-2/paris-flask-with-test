-- RevoU Auto Garage Sample Data
-- This file contains sample data for testing and demonstration

-- Make sure to run schema.sql first to create the tables

-- Sample outlets
INSERT INTO outlets (name, address, phone)
VALUES 
    ('RevoU Auto Garage - Central', '123 Main Street, Jakarta', '+6221555123'),
    ('RevoU Auto Garage - North', '45 North Avenue, Jakarta', '+6221555456'),
    ('RevoU Auto Garage - South', '78 South Boulevard, Jakarta', '+6221555789'),
    ('RevoU Auto Garage - East', '32 East Road, Jakarta', '+6221555321'),
    ('RevoU Auto Garage - West', '91 West Lane, Jakarta', '+6221555654');

-- Sample services
INSERT INTO services (name, description, base_price)
VALUES 
    ('Tire Change', 'Removal and installation of tires', 150000.00),
    ('Car Wash', 'Exterior and interior cleaning', 85000.00),
    ('Tire Spooring', 'Wheel alignment service', 250000.00),
    ('Tire Balancing', 'Balancing of wheels for smooth ride', 200000.00),
    ('Oil Change', 'Complete oil change with filter replacement', 300000.00),
    ('Brake Service', 'Inspection and replacement of brake pads', 450000.00),
    ('Engine Tune-up', 'Comprehensive engine maintenance', 750000.00),
    ('AC Service', 'Air conditioning system check and recharge', 350000.00),
    ('Battery Replacement', 'Testing and replacement of car battery', 500000.00);

-- Sample customers
INSERT INTO customers (name, phone, email, address)
VALUES 
    ('John Doe', '+628123456789', 'john.doe@email.com', 'Jl. Sudirman No. 123, Jakarta'),
    ('Jane Smith', '+628987654321', 'jane.smith@email.com', 'Jl. Thamrin No. 45, Jakarta'),
    ('Ahmad Rizki', '+628567891234', 'ahmad.r@email.com', 'Jl. Gatot Subroto No. 67, Jakarta'),
    ('Siti Rahayu', '+628765432109', 'siti.r@email.com', 'Jl. Kebon Sirih No. 89, Jakarta'),
    ('Budi Santoso', '+628234567890', 'budi.s@email.com', 'Jl. Hayam Wuruk No. 54, Jakarta'),
    ('Maria Chen', '+628876543210', 'maria.c@email.com', 'Jl. Pluit No. 23, Jakarta'),
    ('Rini Wijaya', '+628345678901', 'rini.w@email.com', 'Jl. Senopati No. 12, Jakarta'),
    ('David Wilson', '+628901234567', 'david.w@email.com', 'Jl. Kemang No. 78, Jakarta');

-- Sample transactions
INSERT INTO transactions (customer_id, outlet_id, transaction_date, total_amount, payment_method, notes)
VALUES 
    (1, 1, '2023-07-15 10:30:00', 235000.00, 'Credit Card', 'Regular customer'),
    (2, 2, '2023-07-16 14:45:00', 450000.00, 'Cash', 'New customer'),
    (3, 1, '2023-07-17 09:15:00', 200000.00, 'Debit Card', 'Requested quick service'),
    (1, 2, '2023-07-20 13:00:00', 335000.00, 'Credit Card', 'Follow-up service'),
    (4, 3, '2023-08-01 11:20:00', 550000.00, 'Cash', 'First-time customer'),
    (5, 4, '2023-08-03 15:30:00', 800000.00, 'Credit Card', 'Premium service package'),
    (6, 5, '2023-08-05 09:45:00', 435000.00, 'Debit Card', 'Emergency service'),
    (7, 3, '2023-08-10 14:15:00', 950000.00, 'Credit Card', 'Complete maintenance'),
    (8, 2, '2023-08-12 10:00:00', 500000.00, 'Cash', 'Express service'),
    (2, 1, '2023-08-15 13:30:00', 600000.00, 'Credit Card', 'Returning customer'),
    (3, 4, '2023-08-18 16:45:00', 700000.00, 'Debit Card', 'Weekend service');

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
    (4, 2, 1, 35000.00, 35000.00),
    (5, 5, 1, 300000.00, 300000.00),
    (5, 2, 1, 85000.00, 85000.00),
    (5, 8, 1, 165000.00, 165000.00),
    (6, 6, 1, 450000.00, 450000.00),
    (6, 7, 1, 350000.00, 350000.00),
    (7, 1, 1, 150000.00, 150000.00),
    (7, 8, 1, 285000.00, 285000.00),
    (8, 5, 1, 300000.00, 300000.00),
    (8, 6, 1, 450000.00, 450000.00),
    (8, 2, 1, 85000.00, 85000.00),
    (8, 9, 1, 115000.00, 115000.00),
    (9, 9, 1, 500000.00, 500000.00),
    (10, 7, 1, 600000.00, 600000.00),
    (11, 3, 1, 250000.00, 250000.00),
    (11, 4, 1, 200000.00, 200000.00),
    (11, 2, 1, 85000.00, 85000.00),
    (11, 8, 1, 165000.00, 165000.00);
