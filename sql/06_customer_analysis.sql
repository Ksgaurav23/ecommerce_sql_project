-- ============================================================
-- BUSINESS QUERY 06: CUSTOMER VALUE
-- ============================================================

-- Business Question:
-- How many customers does the business have, which customers
-- generate the most sales, and which customers place the
-- most orders and have the highest average order value?


-- 1. Total Customer Count
-- How many unique customers are in the dataset?

SELECT
       COUNT(DISTINCT customer_id) AS total_customer
FROM clean_ecommerce;


-- 2. Top 10 Customers by Sales
-- Which customers generate the highest sales amount?

SELECT
       customer_id,
       SUM(sales_amount) AS total_sales_amount
FROM clean_ecommerce
WHERE customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY total_sales_amount DESC
LIMIT 10;


-- 3. Top 10 Customers by Number of Orders
-- Which customers place the highest number of orders?

SELECT
       customer_id,
       COUNT(DISTINCT invoice_no) AS total_order
FROM clean_ecommerce
WHERE customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY total_order DESC
LIMIT 10;


-- 4. Top 10 Customers by Average Order Value
-- Which customers have the highest average order value?

SELECT
       customer_id,
       total_sales_amount / total_order AS average_order_value
FROM (
       SELECT
              customer_id,
              COUNT(DISTINCT invoice_no) AS total_order,
              SUM(sales_amount) AS total_sales_amount
       FROM clean_ecommerce
       WHERE customer_id IS NOT NULL
       GROUP BY customer_id
     )
ORDER BY average_order_value DESC
LIMIT 10;