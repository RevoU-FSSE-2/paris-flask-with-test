-- RevoU Auto Garage Example Queries
-- This file contains example queries for common use cases

-- 1. Get all transactions with customer details
SELECT 
    t.transaction_id, 
    t.transaction_date, 
    c.name AS customer_name, 
    c.phone AS customer_phone,
    o.name AS outlet_name, 
    t.total_amount, 
    t.payment_method
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
JOIN 
    outlets o ON t.outlet_id = o.outlet_id
ORDER BY 
    t.transaction_date DESC;

-- 2. Get detailed transaction report with services
SELECT 
    t.transaction_id, 
    t.transaction_date, 
    c.name AS customer_name,
    o.name AS outlet_name,
    s.name AS service_name,
    td.quantity,
    td.unit_price,
    td.subtotal
FROM 
    transactions t
JOIN 
    customers c ON t.customer_id = c.customer_id
JOIN 
    outlets o ON t.outlet_id = o.outlet_id
JOIN 
    transaction_details td ON t.transaction_id = td.transaction_id
JOIN 
    services s ON td.service_id = s.service_id
ORDER BY 
    t.transaction_date DESC, t.transaction_id;

-- 3. Get total revenue by outlet
SELECT 
    o.name AS outlet_name,
    SUM(t.total_amount) AS total_revenue
FROM 
    transactions t
JOIN 
    outlets o ON t.outlet_id = o.outlet_id
GROUP BY 
    o.name
ORDER BY 
    total_revenue DESC;

-- 4. Get most popular services
SELECT 
    s.name AS service_name,
    SUM(td.quantity) AS total_quantity,
    SUM(td.subtotal) AS total_revenue
FROM 
    transaction_details td
JOIN 
    services s ON td.service_id = s.service_id
GROUP BY 
    s.name
ORDER BY 
    total_quantity DESC;

-- 5. Get customer service history for CRM purposes
SELECT 
    c.customer_id,
    c.name AS customer_name,
    c.phone,
    c.email,
    COUNT(t.transaction_id) AS visit_count,
    MAX(t.transaction_date) AS last_visit,
    SUM(t.total_amount) AS total_spent
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
GROUP BY 
    c.customer_id, c.name, c.phone, c.email
ORDER BY 
    total_spent DESC;

-- 6. Get daily revenue report
SELECT 
    DATE(t.transaction_date) AS date,
    COUNT(t.transaction_id) AS transaction_count,
    SUM(t.total_amount) AS daily_revenue
FROM 
    transactions t
GROUP BY 
    DATE(t.transaction_date)
ORDER BY 
    date DESC;
