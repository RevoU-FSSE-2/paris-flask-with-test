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

-- 7. UNION Examples

-- 7.1 Combined contact list of customers and outlet locations
SELECT 
    'Customer' AS contact_type,
    name,
    phone,
    address
FROM 
    customers
UNION
SELECT 
    'Outlet' AS contact_type,
    name,
    phone,
    address
FROM 
    outlets
ORDER BY 
    contact_type, name;

-- 7.2 Unifying transactions above 500k from different months
SELECT 
    transaction_id,
    transaction_date,
    'July 2023' AS period,
    total_amount
FROM 
    transactions
WHERE 
    total_amount > 500000 AND EXTRACT(MONTH FROM transaction_date) = 7
UNION
SELECT 
    transaction_id,
    transaction_date,
    'August 2023' AS period,
    total_amount
FROM 
    transactions
WHERE 
    total_amount > 500000 AND EXTRACT(MONTH FROM transaction_date) = 8
ORDER BY 
    total_amount DESC;

-- 7.3 Comprehensive service statistics combining different metrics
SELECT 
    service_id,
    name AS service_name,
    'High Price' AS category,
    base_price AS value
FROM 
    services
WHERE 
    base_price > 300000
UNION
SELECT 
    s.service_id,
    s.name AS service_name,
    'High Demand' AS category,
    COUNT(td.service_id) AS value
FROM 
    services s
JOIN 
    transaction_details td ON s.service_id = td.service_id
GROUP BY 
    s.service_id, s.name
HAVING 
    COUNT(td.service_id) >= 3
ORDER BY 
    service_id;

-- 7.4 Payment method distribution across outlets
SELECT 
    o.name AS outlet_name,
    'Credit Card' AS payment_method,
    COUNT(*) AS transaction_count
FROM 
    transactions t
JOIN 
    outlets o ON t.outlet_id = o.outlet_id
WHERE 
    t.payment_method = 'Credit Card'
GROUP BY 
    o.name
UNION
SELECT 
    o.name AS outlet_name,
    'Cash' AS payment_method,
    COUNT(*) AS transaction_count
FROM 
    transactions t
JOIN 
    outlets o ON t.outlet_id = o.outlet_id
WHERE 
    t.payment_method = 'Cash'
GROUP BY 
    o.name
UNION
SELECT 
    o.name AS outlet_name,
    'Debit Card' AS payment_method,
    COUNT(*) AS transaction_count
FROM 
    transactions t
JOIN 
    outlets o ON t.outlet_id = o.outlet_id
WHERE 
    t.payment_method = 'Debit Card'
GROUP BY 
    o.name
ORDER BY 
    outlet_name, payment_method;

-- 7.5 Combining recent customers with high-value transactions for special promotion
SELECT 
    c.customer_id,
    c.name,
    'Recent Customer' AS category
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    t.transaction_date > (CURRENT_DATE - INTERVAL '30 days')
UNION
SELECT 
    c.customer_id,
    c.name,
    'VIP Customer' AS category
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
GROUP BY 
    c.customer_id, c.name
HAVING 
    SUM(t.total_amount) > 800000
ORDER BY 
    customer_id;
