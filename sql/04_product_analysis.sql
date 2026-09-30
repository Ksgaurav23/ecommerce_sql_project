-- ============================================================
-- BUSINESS QUERY 04: PRODUCT PERFORMANCE
-- ============================================================

-- Business Question:
-- Which products have the highest demand, what are their
-- average prices, and how does product demand change over time?


-- 1. Total Product Count
-- How many distinct products are available?

SELECT
       COUNT(DISTINCT description) AS total_product_count
FROM clean_ecommerce;


-- 2. Top 10 Products by Quantity Sold
-- Which products have the highest sales volume?

SELECT
       description,
       SUM(quantity) AS total_quantity
FROM clean_ecommerce
GROUP BY description
ORDER BY total_quantity DESC
LIMIT 10;


-- 3. Top 10 Products with Average Unit Price
-- What is the average unit price of the highest-volume products?

SELECT
       description,
       SUM(quantity) AS total_quantity,
       AVG(unit_price) AS average_unit_price
FROM clean_ecommerce
GROUP BY description
ORDER BY total_quantity DESC
LIMIT 10;


-- 4. Monthly Demand for the Top-Selling Product
-- How does the demand for WORLD WAR 2 GLIDERS ASSTD DESIGNS
-- change month by month?

SELECT
       TO_CHAR(DATE_TRUNC('month', invoice_date), 'Mon YY') AS sales_month,
       SUM(quantity) AS total_quantity
FROM clean_ecommerce
WHERE description = 'WORLD WAR 2 GLIDERS ASSTD DESIGNS'
GROUP BY DATE_TRUNC('month', invoice_date)
ORDER BY DATE_TRUNC('month', invoice_date) ASC;