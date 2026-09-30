-- ============================================================
-- BUSINESS QUERY 03: SALES PERFORMANCE
-- ============================================================

-- Business Question:
-- How does sales revenue perform overall, by product,
-- and over time?


-- 1. Overall Sales Performance
-- What are the overall sales, quantity sold, and average unit price?

SELECT
       SUM(quantity) AS total_quantity,
       AVG(unit_price) AS average_unit_price,
       SUM(sales_amount) AS total_sales_amount
FROM clean_ecommerce;


-- 2. Top 10 Products by Sales
-- Which products generate the highest sales amount?

SELECT
       description,
       SUM(quantity) AS total_quantity,
       AVG(unit_price) AS average_unit_price,
       SUM(sales_amount) AS total_sales_amount
FROM clean_ecommerce
GROUP BY description
ORDER BY total_sales_amount DESC
LIMIT 10;


-- 3. Monthly Sales Performance
-- How do sales, quantity, and average unit price change over time?

SELECT
       TO_CHAR(DATE_TRUNC('month', invoice_date), 'Mon YY') AS sales_month,
       SUM(quantity) AS total_quantity,
       AVG(unit_price) AS average_unit_price,
       SUM(sales_amount) AS total_sales_amount
FROM clean_ecommerce
GROUP BY DATE_TRUNC('month', invoice_date)
ORDER BY DATE_TRUNC('month', invoice_date) ASC;