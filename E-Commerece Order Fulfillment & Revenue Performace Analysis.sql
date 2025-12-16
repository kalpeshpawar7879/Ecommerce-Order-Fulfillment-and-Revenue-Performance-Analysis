create database Ecommerce_db;
use Ecommerce_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10 , 2 )
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(50),
    payment_method VARCHAR(50),
    FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    item_price DECIMAL(10 , 2 ),
    FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    FOREIGN KEY (product_id)
        REFERENCES products (product_id)
);

CREATE TABLE deliveries (
    order_id INT PRIMARY KEY,
    promised_date DATE,
    delivery_date DATE,
    delivery_status VARCHAR(50),
    FOREIGN KEY (order_id)
        REFERENCES orders (order_id)
); 

INSERT INTO customers VALUES
(1,'Amit Sharma','Pune','Maharashtra','2023-01-10'),
(2,'Neha Patil','Mumbai','Maharashtra','2023-02-05'),
(3,'Rahul Verma','Delhi','Delhi','2023-02-20'),
(4,'Sneha Iyer','Bengaluru','Karnataka','2023-03-15'),
(5,'Arjun Singh','Jaipur','Rajasthan','2023-04-01');

INSERT INTO products VALUES
(101,'Wireless Mouse','Electronics',799),
(102,'Bluetooth Headphones','Electronics',1999),
(103,'Office Chair','Furniture',5999),
(104,'Notebook Pack','Stationery',299),
(105,'Water Bottle','Accessories',499);

INSERT INTO orders VALUES
(1001,1,'2023-04-10','Delivered','UPI'),
(1002,2,'2023-04-12','Cancelled','COD'),
(1003,3,'2023-04-15','Delivered','Card'),
(1004,4,'2023-04-18','Delivered','UPI'),
(1005,1,'2023-04-20','Delivered','Card');

INSERT INTO order_items VALUES
(1,1001,101,1,799),
(2,1001,105,2,499),
(3,1003,102,1,1999),
(4,1004,103,1,5999),
(5,1005,104,3,299);

INSERT INTO deliveries VALUES
(1001,'2023-04-13','2023-04-13','On-time'),
(1003,'2023-04-18','2023-04-19','Delayed'),
(1004,'2023-04-21','2023-04-21','On-time'),
(1005,'2023-04-23','2023-04-22','On-time');

-- Row count in each table
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM deliveries;

-- Check Distinct values
select distinct order_status from orders;
select distinct payment_method from orders;
select distinct category from products;

-- Date Range
SELECT 
    MIN(order_date), MAX(order_date)
FROM
    orders;
    
-- Null Check
SELECT 
    *
FROM
    orders o
        LEFT JOIN
    customers c ON o.customer_id = c.customer_id
WHERE
    c.customer_id IS NULL;
    
-- Revenue check
SELECT 
    SUM(quantity * item_price) AS Revenue
FROM
    order_items;

-- Business Insight:- Shows how much revenue the company actually earned from successful orders.
SELECT 
    SUM(oi.quantity * oi.item_price)
FROM
    order_items oi
        JOIN
    orders o ON oi.order_id = o.order_id
WHERE
    o.order_status = 'Delivered';
    
-- Monthly Revenue Trend
SELECT 
    DATE_FORMAT(o.order_date, '%y-%m') AS month,
    SUM(oi.quantity * oi.item_price) AS revenue
FROM
    orders o
        JOIN
    order_items oi ON o.order_id = oi.order_id
WHERE
    o.order_status = 'Delivered'
GROUP BY month
ORDER BY month;

-- Helps to understand customer spending behaviour (AOV)
SELECT 
    SUM(oi.quantity * oi.item_price) / COUNT(DISTINCT oi.order_id) AS Average_Order_Value
FROM
    order_items oi
        JOIN
    orders o ON oi.order_id = o.order_id
WHERE
    o.order_status = 'Delivered';

-- Business Insight:- Efficiency of operations & logistics.
SELECT 
    SUM(order_status = 'Delivered') * 100 / COUNT(*) AS Order_Fulfilment_Rate
FROM
    orders;
    
-- Business Insight:- Orders that reached on-time
SELECT 
    COUNT(CASE
        WHEN delivery_status = 'on-time' THEN 1
    END) * 100 / COUNT(*) AS Order_Fulfillment_Rate
FROM
    deliveries;
    
-- Business Insight:- The perecentage of total orders that are cancelled.
SELECT 
    COUNT(CASE
        WHEN order_status = 'Cancelled' THEN 1
    END) * 100.0 / COUNT(*) AS Cancellation_Rate
FROM
    orders;
    
-- Business Insight = Revenue for each category which are succesfully delivered
SELECT 
    p.category AS Category,
    SUM(oi.quantity * oi.item_price) AS Category_Revenue
FROM
    order_items oi
        JOIN
    products p ON p.product_id = oi.product_id
        JOIN
    orders o ON o.order_id = oi.order_id
WHERE
    o.order_status = 'Delivered'
GROUP BY p.category
ORDER BY Category_Revenue DESC;

-- Business Insight:- Top 5 revenue generating products
SELECT 
    p.product_name AS Product_Name,
    SUM(oi.quantity * oi.item_price) AS Product_Revenue
FROM
    order_items oi
        JOIN
    products p ON p.product_id = oi.product_id
        JOIN
    orders o ON o.order_id = oi.order_id
WHERE
    o.order_status = 'Delivered'
GROUP BY p.product_name
ORDER BY Product_Revenue DESC limit 5;

-- Business Insight:- Information about repeting customers
SELECT 
    customer_id, count(order_id) AS Total_orders
FROM
    orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;

-- Business Insight:- Top customers by revenue
SELECT 
    c.customer_name AS Customer_Name,
    SUM(oi.quantity * oi.item_price) AS Revenue
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
        JOIN
    order_items oi ON o.order_id = oi.order_id
GROUP BY Customer_Name
ORDER BY Revenue
LIMIT 10;

-- Business Insight:- Percentage of total orders that are delayed
SELECT 
    COUNT(CASE
        WHEN delivery_status = 'Delayed' THEN 1
    END) * 100 / COUNT(*) AS Delay_Rate
FROM
    deliveries;