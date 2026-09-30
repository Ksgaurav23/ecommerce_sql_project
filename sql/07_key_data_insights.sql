-- ============================================================
-- BUSINESS QUERY 07: OVERALL BUSINESS HIGHLIGHTS
-- ============================================================

-- Business Question:
-- What are the key overall business metrics, including sales,
-- customers, products, geographic reach, and order outcomes?


SELECT
       -- Overall business metrics
       COUNT(DISTINCT invoice_no) AS total_order,
       COUNT(DISTINCT customer_id) AS total_customer,
       COUNT(DISTINCT description) AS total_product_count,
       COUNT(DISTINCT country) AS total_country,
       SUM(quantity) AS total_quantity,
       AVG(unit_price) AS average_unit_price,
       SUM(sales_amount) AS total_sales_amount,

       -- Order outcome metrics
       COUNT(DISTINCT CASE
           WHEN order_status = 'CANCELED' THEN invoice_no
       END) * 100.0
       / COUNT(DISTINCT invoice_no) AS cancellation_percent,

       COUNT(DISTINCT CASE
           WHEN order_status = 'DELIVERED' THEN invoice_no
       END) * 100.0
       / COUNT(DISTINCT invoice_no) AS successful_order_percent

FROM clean_ecommerce;