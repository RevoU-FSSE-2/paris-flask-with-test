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

-- 8. Different JOIN Types Examples

-- 8.1 LEFT JOIN - Finding all customers and their transactions (includes customers with no transactions)
SELECT 
    c.customer_id,
    c.name AS customer_name,
    c.phone,
    t.transaction_id,
    t.transaction_date,
    t.total_amount
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
ORDER BY 
    c.customer_id, t.transaction_date;

-- 8.2 LEFT JOIN - Show all services and their usage statistics (includes unused services)
SELECT 
    s.service_id,
    s.name AS service_name,
    s.base_price,
    COUNT(td.service_id) AS times_used,
    COALESCE(SUM(td.quantity), 0) AS total_quantity,
    COALESCE(SUM(td.subtotal), 0) AS total_revenue
FROM 
    services s
LEFT JOIN 
    transaction_details td ON s.service_id = td.service_id
GROUP BY 
    s.service_id, s.name, s.base_price
ORDER BY 
    times_used DESC, s.service_id;

-- 8.3 RIGHT JOIN - Show all outlets and transactions (includes outlets with no transactions)
SELECT 
    o.outlet_id,
    o.name AS outlet_name,
    t.transaction_id,
    t.transaction_date,
    t.total_amount
FROM 
    transactions t
RIGHT JOIN 
    outlets o ON t.outlet_id = o.outlet_id
ORDER BY 
    o.outlet_id, t.transaction_date;

-- 8.4 RIGHT JOIN - Show all payment methods used by customers
SELECT 
    c.customer_id,
    c.name AS customer_name,
    t.payment_method,
    COUNT(t.transaction_id) AS transaction_count
FROM 
    customers c
RIGHT JOIN 
    transactions t ON c.customer_id = t.customer_id
WHERE 
    t.payment_method IS NOT NULL
GROUP BY 
    c.customer_id, c.name, t.payment_method
ORDER BY 
    c.customer_id, transaction_count DESC;

-- 8.5 FULL JOIN - Complete customer and outlet relationship matrix
SELECT 
    c.customer_id,
    c.name AS customer_name,
    o.outlet_id,
    o.name AS outlet_name,
    COUNT(t.transaction_id) AS transaction_count,
    COALESCE(SUM(t.total_amount), 0) AS total_spent
FROM 
    customers c
FULL JOIN 
    transactions t ON c.customer_id = t.customer_id
FULL JOIN 
    outlets o ON t.outlet_id = o.outlet_id
GROUP BY 
    c.customer_id, c.name, o.outlet_id, o.name
ORDER BY 
    c.customer_id, o.outlet_id;

-- 8.6 FULL JOIN - Complete services and transaction details relationship
SELECT 
    s.service_id,
    s.name AS service_name,
    td.transaction_id,
    td.detail_id,
    COALESCE(td.quantity, 0) AS quantity,
    COALESCE(td.subtotal, 0) AS subtotal
FROM 
    services s
FULL JOIN 
    transaction_details td ON s.service_id = td.service_id
ORDER BY 
    s.service_id, td.transaction_id;

-- 8.7 LEFT JOIN vs INNER JOIN comparison - Customer visit frequency
-- LEFT JOIN version (includes all customers)
SELECT 
    c.customer_id,
    c.name AS customer_name,
    COUNT(t.transaction_id) AS visit_count,
    CASE 
        WHEN COUNT(t.transaction_id) = 0 THEN 'Never visited'
        WHEN COUNT(t.transaction_id) = 1 THEN 'One-time customer'
        WHEN COUNT(t.transaction_id) > 1 THEN 'Returning customer'
    END AS customer_category
FROM 
    customers c
LEFT JOIN 
    transactions t ON c.customer_id = t.customer_id
GROUP BY 
    c.customer_id, c.name
ORDER BY 
    visit_count DESC, c.customer_id;

-- INNER JOIN version (only includes customers with transactions)
SELECT 
    c.customer_id,
    c.name AS customer_name,
    COUNT(t.transaction_id) AS visit_count,
    CASE 
        WHEN COUNT(t.transaction_id) = 1 THEN 'One-time customer'
        WHEN COUNT(t.transaction_id) > 1 THEN 'Returning customer'
    END AS customer_category
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
GROUP BY 
    c.customer_id, c.name
ORDER BY 
    visit_count DESC, c.customer_id;

-- 9. Customer Service Usage Statistics

-- 9.1 Show services used by each customer with usage count
SELECT 
    c.customer_id,
    c.name AS customer_name,
    s.service_id,
    s.name AS service_name,
    COUNT(*) AS times_used,
    SUM(td.quantity) AS total_quantity,
    SUM(td.subtotal) AS total_spent_on_service
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
JOIN 
    transaction_details td ON t.transaction_id = td.transaction_id
JOIN 
    services s ON td.service_id = s.service_id
GROUP BY 
    c.customer_id, c.name, s.service_id, s.name
ORDER BY 
    c.customer_id, times_used DESC;

-- 9.2 Summary of services used by each customer
SELECT 
    c.customer_id,
    c.name AS customer_name,
    COUNT(DISTINCT s.service_id) AS unique_services_used,
    STRING_AGG(DISTINCT s.name, ', ') AS services_list,
    SUM(td.quantity) AS total_services_quantity,
    SUM(td.subtotal) AS total_spent
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
JOIN 
    transaction_details td ON t.transaction_id = td.transaction_id
JOIN 
    services s ON td.service_id = s.service_id
GROUP BY 
    c.customer_id, c.name
ORDER BY 
    unique_services_used DESC, total_spent DESC;

-- 9.3 Customers who have never used certain popular services (using LEFT JOIN)
SELECT 
    c.customer_id,
    c.name AS customer_name,
    s.name AS unused_service_name
FROM 
    customers c
CROSS JOIN 
    services s
LEFT JOIN 
    (
        SELECT DISTINCT 
            t.customer_id, 
            td.service_id
        FROM 
            transactions t
        JOIN 
            transaction_details td ON t.transaction_id = td.transaction_id
    ) used ON c.customer_id = used.customer_id AND s.service_id = used.service_id
WHERE 
    used.customer_id IS NULL
    AND c.customer_id IN (SELECT DISTINCT customer_id FROM transactions)
    AND s.service_id IN (1, 2, 5) -- Tire Change, Car Wash, Oil Change (most common services)
ORDER BY 
    c.customer_id, s.service_id;

-- 9.4 Service usage patterns by customer with percentages
WITH customer_totals AS (
    SELECT 
        c.customer_id,
        SUM(td.subtotal) AS total_spent
    FROM 
        customers c
    JOIN 
        transactions t ON c.customer_id = t.customer_id
    JOIN 
        transaction_details td ON t.transaction_id = td.transaction_id
    GROUP BY 
        c.customer_id
)
SELECT 
    c.customer_id,
    c.name AS customer_name,
    s.name AS service_name,
    COUNT(*) AS service_count,
    SUM(td.subtotal) AS spent_on_service,
    ROUND((SUM(td.subtotal) / ct.total_spent) * 100, 2) AS percentage_of_total
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
JOIN 
    transaction_details td ON t.transaction_id = td.transaction_id
JOIN 
    services s ON td.service_id = s.service_id
JOIN 
    customer_totals ct ON c.customer_id = ct.customer_id
GROUP BY 
    c.customer_id, c.name, s.name, ct.total_spent
ORDER BY 
    c.customer_id, percentage_of_total DESC;
