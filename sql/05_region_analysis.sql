-- ============================================================
-- BUSINESS QUERY 05: GEOGRAPHIC PERFORMANCE
-- ============================================================

-- Business Question:
-- Which countries contribute the most sales and sales volume,
-- and how widely does the business reach geographically?


-- 1. Total Country Count
-- How many distinct countries does the business reach?

SELECT
       COUNT(DISTINCT country) AS total_country_count
FROM clean_ecommerce;


-- 2. Top 10 Countries by Sales
-- Which countries generate the highest sales amount?

SELECT
       country,
       SUM(sales_amount) AS total_sales_amount
FROM clean_ecommerce
GROUP BY country
ORDER BY total_sales_amount DESC
LIMIT 10;


-- 3. Top 10 Countries by Quantity
-- Which countries have the highest sales volume?

SELECT
       country,
       SUM(quantity) AS total_quantity
FROM clean_ecommerce
GROUP BY country
ORDER BY total_quantity DESC
LIMIT 10;


-- 4. Top 10 Countries by Sales with Quantity
-- How do sales amount and sales volume compare across the
-- highest-performing countries?

SELECT
       country,
       SUM(quantity) AS total_quantity,
       SUM(sales_amount) AS total_sales_amount
FROM clean_ecommerce
GROUP BY country
ORDER BY total_sales_amount DESC
LIMIT 10;