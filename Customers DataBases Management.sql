USE nexora_retail;
#creation of table

create table customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(120) UNIQUE,
    phone VARCHAR(15),
    signup_date DATE,
    city VARCHAR(60),
    state VARCHAR(60),
    pincode VARCHAR(10),
    customer_segment VARCHAR(20),
    date_of_birth DATE,
    status VARCHAR(10)
);

USE nexora_retail;
#Total rows in the table
SELECT COUNT(*) AS total_customers
FROM customers;

#Top 10 customers Data
SELECT * FROM customers
LIMIT 10;

#Citywise Count of Total customers
SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

#Total customer base
SELECT
    COUNT(*) AS total_customers,
    COUNT(DISTINCT city) AS cities_covered,
    COUNT(DISTINCT customer_segment) AS customer_segments
FROM customers;

#Customer segmentation analysis
SELECT
    customer_segment,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers),
        2
    ) AS percentage
FROM customers
GROUP BY customer_segment
ORDER BY total_customers DESC;

#Monthly customer acquisition
SELECT
    DATE_FORMAT(signup_date, '%Y-%m') AS signup_month,
    COUNT(*) AS new_customers
FROM customers
GROUP BY signup_month
ORDER BY signup_month;

#Top 5 cities by customer concentration
SELECT
    city,
    state,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city, state
ORDER BY total_customers DESC
LIMIT 5;

#Customers who joined in the last 12 months
SELECT
    customer_id,
    CONCAT(first_name, ' ', last_name) AS customer_name,
    city,
    customer_segment,
    signup_date
FROM customers
WHERE signup_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
ORDER BY signup_date DESC;
