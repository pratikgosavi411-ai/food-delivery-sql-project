-- ============================================================
--   ONLINE FOOD DELIVERY DATABASE — COMPLETE SQL PROJECT
--   Phases 1–9 + Dashboard Queries
--   Tool: MySQL 8.0
-- ============================================================


-- ============================================================
-- PHASE 1: DATABASE & TABLE CREATION
-- ============================================================

CREATE DATABASE IF NOT EXISTS food_delivery_db;
USE food_delivery_db;

-- Table 1: Customers
CREATE TABLE IF NOT EXISTS customers (
    customer_id   INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(150) UNIQUE NOT NULL,
    phone         VARCHAR(15),
    city          VARCHAR(50),
    created_at    DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Table 2: Restaurants
CREATE TABLE IF NOT EXISTS restaurants (
    restaurant_id  INT AUTO_INCREMENT PRIMARY KEY,
    name           VARCHAR(150) NOT NULL,
    city           VARCHAR(50),
    cuisine_type   VARCHAR(50),
    rating         DECIMAL(3,1),
    created_at     DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Table 3: Menu Items
CREATE TABLE IF NOT EXISTS menu_items (
    item_id        INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id  INT NOT NULL,
    item_name      VARCHAR(150) NOT NULL,
    price          DECIMAL(10,2) NOT NULL,
    category       VARCHAR(50),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- Table 4: Delivery Agents
CREATE TABLE IF NOT EXISTS delivery_agents (
    agent_id      INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    phone         VARCHAR(15),
    vehicle_type  VARCHAR(30),
    rating        DECIMAL(3,1),
    city          VARCHAR(50)
);

-- Table 5: Orders
CREATE TABLE IF NOT EXISTS orders (
    order_id               INT AUTO_INCREMENT PRIMARY KEY,
    customer_id            INT NOT NULL,
    restaurant_id          INT NOT NULL,
    agent_id               INT,
    order_date             DATETIME DEFAULT CURRENT_TIMESTAMP,
    order_amount           DECIMAL(10,2) NOT NULL,
    discount               DECIMAL(10,2) DEFAULT 0,
    payment_method         VARCHAR(20),
    delivery_time_minutes  INT,
    status                 VARCHAR(30) DEFAULT 'Delivered',
    FOREIGN KEY (customer_id)   REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
    FOREIGN KEY (agent_id)      REFERENCES delivery_agents(agent_id)
);

-- Table 6: Order Items
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id  INT AUTO_INCREMENT PRIMARY KEY,
    order_id       INT NOT NULL,
    item_id        INT NOT NULL,
    quantity       INT NOT NULL DEFAULT 1,
    unit_price     DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id)  REFERENCES menu_items(item_id)
);


-- ============================================================
-- PHASE 2: SAMPLE DATA INSERTION
-- ============================================================

-- Customers
INSERT INTO customers (name, email, phone, city) VALUES
('Aarav Sharma',    'aarav@email.com',    '9876543210', 'Mumbai'),
('Priya Patel',     'priya@email.com',    '9876543211', 'Pune'),
('Rohan Mehta',     'rohan@email.com',    '9876543212', 'Delhi'),
('Sneha Iyer',      'sneha@email.com',    '9876543213', 'Bangalore'),
('Karan Singh',     'karan@email.com',    '9876543214', 'Mumbai'),
('Divya Nair',      'divya@email.com',    '9876543215', 'Pune'),
('Arjun Gupta',     'arjun@email.com',    '9876543216', 'Delhi'),
('Meera Reddy',     'meera@email.com',    '9876543217', 'Hyderabad'),
('Vikram Joshi',    'vikram@email.com',   '9876543218', 'Bangalore'),
('Ananya Desai',    'ananya@email.com',   '9876543219', 'Mumbai');

-- Restaurants
INSERT INTO restaurants (name, city, cuisine_type, rating) VALUES
('Spice Garden',       'Mumbai',    'Indian',    4.5),
('Pizza Palace',       'Pune',      'Italian',   4.2),
('Dragon Wok',         'Delhi',     'Chinese',   4.0),
('Burger Barn',        'Mumbai',    'Fast Food', 3.8),
('Dosa Delight',       'Bangalore', 'South Indian', 4.7),
('Tandoor Nights',     'Delhi',     'Indian',    4.3),
('Sushi Central',      'Pune',      'Japanese',  4.6),
('Pasta Pronto',       'Hyderabad', 'Italian',   4.1),
('Wok & Roll',         'Bangalore', 'Chinese',   3.9),
('The Grill House',    'Mumbai',    'Fast Food', 4.4);

-- Menu Items
INSERT INTO menu_items (restaurant_id, item_name, price, category) VALUES
(1, 'Butter Chicken',    320.00, 'Main Course'),
(1, 'Paneer Tikka',      280.00, 'Starter'),
(2, 'Margherita Pizza',  350.00, 'Main Course'),
(2, 'Garlic Bread',      120.00, 'Starter'),
(3, 'Veg Fried Rice',    220.00, 'Main Course'),
(3, 'Chicken Manchurian',260.00, 'Main Course'),
(4, 'Classic Burger',    199.00, 'Main Course'),
(4, 'Cheese Fries',      149.00, 'Sides'),
(5, 'Masala Dosa',       180.00, 'Main Course'),
(5, 'Filter Coffee',      60.00, 'Beverage'),
(6, 'Dal Makhani',       250.00, 'Main Course'),
(6, 'Tandoori Roti',      40.00, 'Bread'),
(7, 'Salmon Sushi',      480.00, 'Main Course'),
(8, 'Spaghetti Aglio',   320.00, 'Main Course'),
(9, 'Hakka Noodles',     210.00, 'Main Course'),
(10,'BBQ Chicken',       380.00, 'Main Course');

-- Delivery Agents
INSERT INTO delivery_agents (name, phone, vehicle_type, rating, city) VALUES
('Ravi Kumar',   '9001001001', 'Bike',    4.6, 'Mumbai'),
('Suresh Das',   '9001001002', 'Scooter', 4.3, 'Pune'),
('Amit Yadav',   '9001001003', 'Bike',    4.8, 'Delhi'),
('Pradeep Nair', '9001001004', 'Bicycle', 4.1, 'Bangalore'),
('Mohan Lal',    '9001001005', 'Scooter', 4.5, 'Hyderabad');

-- Orders
INSERT INTO orders (customer_id, restaurant_id, agent_id, order_date, order_amount, discount, payment_method, delivery_time_minutes, status) VALUES
(1,  1, 1, '2024-01-05 12:30:00',  950.00,  50.00, 'UPI',   35, 'Delivered'),
(2,  2, 2, '2024-01-10 13:00:00',  470.00,  20.00, 'Card',  50, 'Delivered'),
(3,  3, 3, '2024-01-15 14:00:00',  480.00,   0.00, 'Cash',  40, 'Delivered'),
(4,  5, 4, '2024-02-01 11:00:00',  240.00,  10.00, 'UPI',   25, 'Delivered'),
(5,  4, 1, '2024-02-10 19:00:00',  348.00,  00.00, 'Card',  60, 'Delivered'),
(6,  6, 3, '2024-02-20 20:00:00',  580.00,  30.00, 'UPI',   55, 'Delivered'),
(7,  7, 2, '2024-03-03 18:30:00', 1440.00, 100.00, 'Card',  30, 'Delivered'),
(8,  8, 5, '2024-03-12 12:00:00',  640.00,   0.00, 'Cash',  45, 'Delivered'),
(9,  9, 4, '2024-03-20 21:00:00',  420.00,  15.00, 'UPI',   70, 'Delivered'),
(10,10, 1, '2024-04-01 13:30:00',  760.00,  40.00, 'Card',  38, 'Delivered'),
(1,  6, 3, '2024-04-15 14:00:00',  500.00,  25.00, 'UPI',   48, 'Delivered'),
(2,  1, 2, '2024-05-01 12:00:00',  640.00,   0.00, 'Card',  32, 'Delivered'),
(3,  4, 1, '2024-05-15 20:00:00',  199.00,   0.00, 'Cash',  28, 'Delivered'),
(4,  3, 3, '2024-06-01 13:00:00',  480.00,  20.00, 'UPI',   42, 'Delivered'),
(5,  2, 2, '2024-06-20 19:30:00', 1050.00,  50.00, 'Card',  55, 'Delivered'),
(6,  5, 4, '2024-07-04 11:00:00',  360.00,   0.00, 'UPI',   22, 'Delivered'),
(7, 10, 1, '2024-08-08 13:00:00',  380.00,  10.00, 'Cash',  33, 'Delivered'),
(8,  7, 2, '2024-09-09 18:00:00', 1920.00, 200.00, 'Card',  40, 'Delivered'),
(9,  1, 3, '2024-10-10 20:00:00',  600.00,  30.00, 'UPI',   65, 'Delivered'),
(10, 6, 5, '2024-12-25 12:30:00',  830.00,  50.00, 'Card',  29, 'Delivered');

-- Order Items
INSERT INTO order_items (order_id, item_id, quantity, unit_price) VALUES
(1,  1, 2, 320.00),
(1,  2, 1, 280.00),
(2,  3, 1, 350.00),
(2,  4, 1, 120.00),
(3,  5, 1, 220.00),
(3,  6, 1, 260.00),
(4,  9, 1, 180.00),
(4, 10, 1,  60.00),
(5,  7, 1, 199.00),
(5,  8, 1, 149.00),
(6, 11, 1, 250.00),
(6, 12, 2,  40.00),
(7, 13, 3, 480.00),
(8, 14, 2, 320.00),
(9, 15, 2, 210.00),
(10,16, 2, 380.00),
(11,11, 2, 250.00),
(12, 1, 2, 320.00),
(13, 7, 1, 199.00),
(14, 5, 2, 220.00),
(15, 3, 3, 350.00),
(16, 9, 2, 180.00),
(17,16, 1, 380.00),
(18,13, 4, 480.00),
(19, 1, 1, 320.00),
(19, 2, 1, 280.00),
(20,11, 2, 250.00),
(20,12, 5,  40.00);


-- ============================================================
-- PHASE 3: BASIC DATA EXPLORATION
-- ============================================================

-- Total number of orders
SELECT COUNT(*) AS total_orders FROM orders;

-- Total revenue generated
SELECT SUM(order_amount) AS total_revenue FROM orders;

-- Net revenue after discounts
SELECT 
    SUM(order_amount)           AS gross_revenue,
    SUM(discount)               AS total_discounts,
    SUM(order_amount - discount) AS net_revenue
FROM orders;

-- Orders by payment method
SELECT 
    payment_method,
    COUNT(*)         AS order_count,
    SUM(order_amount) AS revenue
FROM orders
GROUP BY payment_method
ORDER BY revenue DESC;

-- List all restaurants
SELECT restaurant_id, name, city, cuisine_type, rating
FROM restaurants
ORDER BY rating DESC;

-- Orders per status
SELECT status, COUNT(*) AS count FROM orders GROUP BY status;


-- ============================================================
-- PHASE 4: CUSTOMER ANALYSIS
-- ============================================================

-- Top 5 customers by total spending
SELECT 
    c.customer_id,
    c.name,
    c.city,
    COUNT(o.order_id)        AS total_orders,
    SUM(o.order_amount)      AS total_spent,
    AVG(o.order_amount)      AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_spent DESC
LIMIT 5;

-- Order frequency per customer
SELECT 
    c.name,
    COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY order_count DESC;

-- City-wise customer count
SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;

-- City-wise revenue from customers
SELECT 
    c.city,
    COUNT(o.order_id)    AS total_orders,
    SUM(o.order_amount)  AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- Customers who ordered more than once
SELECT 
    c.name,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING order_count > 1
ORDER BY order_count DESC;


-- ============================================================
-- PHASE 5: RESTAURANT & REVENUE ANALYSIS
-- ============================================================

-- Top 10 restaurants by total revenue
SELECT 
    r.restaurant_id,
    r.name,
    r.city,
    r.cuisine_type,
    COUNT(o.order_id)    AS total_orders,
    SUM(o.order_amount)  AS total_revenue
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name, r.city, r.cuisine_type
ORDER BY total_revenue DESC
LIMIT 10;

-- Cuisine-wise revenue breakdown
SELECT 
    r.cuisine_type,
    COUNT(o.order_id)    AS total_orders,
    SUM(o.order_amount)  AS total_revenue,
    AVG(o.order_amount)  AS avg_order_value
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.cuisine_type
ORDER BY total_revenue DESC;

-- City-wise restaurant performance
SELECT 
    r.city,
    COUNT(DISTINCT r.restaurant_id) AS restaurant_count,
    COUNT(o.order_id)               AS total_orders,
    SUM(o.order_amount)             AS total_revenue
FROM restaurants r
LEFT JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.city
ORDER BY total_revenue DESC;

-- Average order value per restaurant
SELECT 
    r.name,
    ROUND(AVG(o.order_amount), 2) AS avg_order_value
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name
ORDER BY avg_order_value DESC;

-- Most ordered menu items
SELECT 
    m.item_name,
    r.name          AS restaurant,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.unit_price) AS item_revenue
FROM order_items oi
JOIN menu_items m  ON oi.item_id = m.item_id
JOIN restaurants r ON m.restaurant_id = r.restaurant_id
GROUP BY m.item_id, m.item_name, r.name
ORDER BY total_quantity_sold DESC
LIMIT 10;


-- ============================================================
-- PHASE 6: DELIVERY PERFORMANCE ANALYSIS
-- ============================================================

-- Average delivery time per agent
SELECT 
    da.agent_id,
    da.name,
    da.vehicle_type,
    da.rating,
    COUNT(o.order_id)                       AS deliveries_completed,
    ROUND(AVG(o.delivery_time_minutes), 1)  AS avg_delivery_time
FROM delivery_agents da
JOIN orders o ON da.agent_id = o.agent_id
GROUP BY da.agent_id, da.name, da.vehicle_type, da.rating
ORDER BY avg_delivery_time;

-- Delayed orders (delivery time > 45 minutes)
SELECT 
    o.order_id,
    c.name              AS customer,
    r.name              AS restaurant,
    da.name             AS agent,
    o.delivery_time_minutes,
    o.order_date
FROM orders o
JOIN customers       c  ON o.customer_id   = c.customer_id
JOIN restaurants     r  ON o.restaurant_id = r.restaurant_id
JOIN delivery_agents da ON o.agent_id      = da.agent_id
WHERE o.delivery_time_minutes > 45
ORDER BY o.delivery_time_minutes DESC;

-- Percentage of delayed orders
SELECT 
    COUNT(*)                                              AS total_orders,
    SUM(CASE WHEN delivery_time_minutes > 45 THEN 1 ELSE 0 END) AS delayed_orders,
    ROUND(
        SUM(CASE WHEN delivery_time_minutes > 45 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1
    )                                                     AS delay_percentage
FROM orders;

-- City-wise average delivery time
SELECT 
    r.city,
    ROUND(AVG(o.delivery_time_minutes), 1) AS avg_delivery_time,
    COUNT(o.order_id)                      AS total_orders
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.city
ORDER BY avg_delivery_time;

-- Top-rated delivery agents
SELECT name, vehicle_type, rating, city
FROM delivery_agents
ORDER BY rating DESC;


-- ============================================================
-- PHASE 7: ADVANCED QUERIES
-- ============================================================

-- Monthly order trends
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(order_id)                  AS total_orders,
    SUM(order_amount)                AS monthly_revenue,
    ROUND(AVG(order_amount), 2)      AS avg_order_value
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- High-value orders (above $500)
SELECT 
    o.order_id,
    c.name          AS customer,
    r.name          AS restaurant,
    o.order_amount,
    o.order_date,
    o.payment_method
FROM orders o
JOIN customers   c ON o.customer_id   = c.customer_id
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE o.order_amount > 500
ORDER BY o.order_amount DESC;

-- Discount impact analysis
SELECT 
    payment_method,
    COUNT(*)                   AS orders,
    SUM(discount)              AS total_discount_given,
    SUM(order_amount)          AS gross_revenue,
    SUM(order_amount-discount) AS net_revenue,
    ROUND(AVG(discount), 2)    AS avg_discount
FROM orders
GROUP BY payment_method;

-- Revenue by quarter
SELECT 
    YEAR(order_date)    AS year,
    QUARTER(order_date) AS quarter,
    COUNT(order_id)     AS total_orders,
    SUM(order_amount)   AS quarterly_revenue
FROM orders
GROUP BY YEAR(order_date), QUARTER(order_date)
ORDER BY year, quarter;

-- Customers ranked by spending using window function
SELECT 
    c.name,
    SUM(o.order_amount)                                       AS total_spent,
    RANK() OVER (ORDER BY SUM(o.order_amount) DESC)           AS spending_rank
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- Running total revenue (cumulative) by date
SELECT 
    DATE(order_date)  AS order_day,
    SUM(order_amount) AS daily_revenue,
    SUM(SUM(order_amount)) OVER (ORDER BY DATE(order_date)) AS cumulative_revenue
FROM orders
GROUP BY DATE(order_date)
ORDER BY order_day;

-- Restaurants with above-average revenue
SELECT 
    r.name,
    SUM(o.order_amount) AS revenue
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name
HAVING revenue > (
    SELECT AVG(total) FROM (
        SELECT SUM(order_amount) AS total
        FROM orders
        GROUP BY restaurant_id
    ) sub
)
ORDER BY revenue DESC;


-- ============================================================
-- PHASE 8: PERFORMANCE OPTIMIZATION — INDEXES
-- ============================================================

-- Create indexes on frequently queried columns
-- (Skip customer_id, restaurant_id — already indexed as PKs)

CREATE INDEX idx_order_date       ON orders(order_date);
CREATE INDEX idx_customer_name    ON customers(name);
CREATE INDEX idx_restaurant_name  ON restaurants(name);
CREATE INDEX idx_delivery_time    ON orders(delivery_time_minutes);
CREATE INDEX idx_order_amount     ON orders(order_amount);

-- Verify index usage with EXPLAIN
EXPLAIN SELECT * FROM orders WHERE order_date BETWEEN '2024-01-01' AND '2024-06-30';
EXPLAIN SELECT * FROM customers WHERE name = 'Aarav Sharma';
EXPLAIN SELECT * FROM restaurants WHERE name = 'Spice Garden';
EXPLAIN SELECT * FROM orders WHERE delivery_time_minutes > 45;
EXPLAIN SELECT * FROM orders WHERE order_amount > 500;

-- List all indexes on the orders table
SHOW INDEX FROM orders;


-- ============================================================
-- PHASE 9: TRIGGERS
-- ============================================================

-- Log tables for triggers
CREATE TABLE IF NOT EXISTS high_value_orders_log (
    log_id      INT AUTO_INCREMENT PRIMARY KEY,
    order_id    INT NOT NULL,
    order_amount DECIMAL(10,2),
    logged_at   DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS delivery_delay_log (
    log_id                 INT AUTO_INCREMENT PRIMARY KEY,
    order_id               INT NOT NULL,
    delivery_time_minutes  INT,
    logged_at              DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Trigger 1: Log high-value orders (> $1,000)
DROP TRIGGER IF EXISTS trg_high_value_order;

CREATE TRIGGER trg_high_value_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    IF NEW.order_amount > 1000 THEN
        INSERT INTO high_value_orders_log (order_id, order_amount)
        VALUES (NEW.order_id, NEW.order_amount);
    END IF;
END;

-- Trigger 2: Prevent negative discounts (set to 0)
DROP TRIGGER IF EXISTS trg_prevent_negative_discount;

CREATE TRIGGER trg_prevent_negative_discount
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    IF NEW.discount < 0 THEN
        SET NEW.discount = 0;
    END IF;
END;

-- Trigger 3: Log delayed deliveries (> 45 minutes)
DROP TRIGGER IF EXISTS trg_delivery_delay_log;

CREATE TRIGGER trg_delivery_delay_log
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    IF NEW.delivery_time_minutes > 45 THEN
        INSERT INTO delivery_delay_log (order_id, delivery_time_minutes)
        VALUES (NEW.order_id, NEW.delivery_time_minutes);
    END IF;
END;

-- ── TRIGGER TESTS ──

-- Test Trigger 1: Should appear in high_value_orders_log
INSERT INTO orders (customer_id, restaurant_id, agent_id, order_date, order_amount, discount, payment_method, delivery_time_minutes)
VALUES (1, 1, 1, NOW(), 1500.00, 0, 'UPI', 30);

SELECT * FROM high_value_orders_log;

-- Test Trigger 2: Negative discount should be auto-corrected to 0
INSERT INTO orders (customer_id, restaurant_id, agent_id, order_date, order_amount, discount, payment_method, delivery_time_minutes)
VALUES (2, 2, 2, NOW(), 400.00, -50, 'Card', 25);

SELECT order_id, order_amount, discount FROM orders ORDER BY order_id DESC LIMIT 1;

-- Test Trigger 3: Should appear in delivery_delay_log
INSERT INTO orders (customer_id, restaurant_id, agent_id, order_date, order_amount, discount, payment_method, delivery_time_minutes)
VALUES (3, 3, 3, NOW(), 300.00, 0, 'Cash', 70);

SELECT * FROM delivery_delay_log;


-- ============================================================
-- DASHBOARD EXPORT QUERIES
-- (Export each result as CSV → import into Google Sheets)
-- ============================================================

-- Query 1: Total Revenue (Scorecard)
SELECT 
    COUNT(order_id)            AS total_orders,
    SUM(order_amount)          AS gross_revenue,
    SUM(discount)              AS total_discounts,
    SUM(order_amount-discount) AS net_revenue
FROM orders;

-- Query 2: City-wise Total Orders (Pie Chart)
SELECT 
    r.city,
    COUNT(o.order_id)    AS total_orders,
    SUM(o.order_amount)  AS total_revenue
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.city
ORDER BY total_orders DESC;

-- Query 3: Top 10 Restaurants by Revenue (Bar Chart)
SELECT 
    r.name           AS restaurant_name,
    r.cuisine_type,
    SUM(o.order_amount) AS total_revenue
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_id, r.name, r.cuisine_type
ORDER BY total_revenue DESC
LIMIT 10;

-- Query 4: City-wise Average Delivery Time (3D Pie / Bar Chart)
SELECT 
    r.city,
    ROUND(AVG(o.delivery_time_minutes), 1) AS avg_delivery_time_minutes
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.city
ORDER BY avg_delivery_time_minutes;

-- Query 5: Monthly Order Trends (Line Chart)
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(order_id)                  AS total_orders,
    SUM(order_amount)                AS monthly_revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- ============================================================
-- END OF PROJECT
-- ============================================================
