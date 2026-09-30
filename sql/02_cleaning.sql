```sql
-- ============================================================
-- 02. DATA CLEANING & TRANSFORMATION
-- ============================================================
-- Purpose:
-- This file documents the data-quality investigation performed
-- on the raw Online Retail dataset and creates a working
-- clean_ecommerce table for further analysis.
--
-- The raw_ecommerce table is kept unchanged.
-- Data is investigated first, and cleaning/transformation
-- decisions are applied only to the working table.
--
-- Key areas investigated:
-- 1. Duplicate records
-- 2. Missing values
-- 3. Negative and zero quantities
-- 4. Negative and zero unit prices
-- 5. Missing invoice numbers
--
-- Transformations applied:
-- 1. Create clean_ecommerce from raw_ecommerce
-- 2. Add order_status
-- 3. Add sales_amount
-- ============================================================


-- ============================================================
-- SECTION 1: DUPLICATE RECORD INVESTIGATION
-- ============================================================

-- Identify exact duplicate rows by comparing all columns.
-- Records are not removed automatically because duplicate rows
-- may represent part of the original dataset structure.

SELECT
    invoice_date,
    invoice_no,
    customer_id,
    quantity,
    stock_code,
    description,
    unit_price,
    country,
    COUNT(*) AS count_duplicate
FROM raw_ecommerce
GROUP BY
    invoice_date,
    invoice_no,
    customer_id,
    quantity,
    stock_code,
    description,
    unit_price,
    country
HAVING COUNT(*) > 1;


-- Calculate the total number of rows belonging to
-- exact duplicate groups.

SELECT
    SUM(count_duplicate) AS total_duplicate
FROM (
    SELECT
        invoice_date,
        invoice_no,
        customer_id,
        quantity,
        stock_code,
        description,
        unit_price,
        country,
        COUNT(*) AS count_duplicate
    FROM raw_ecommerce
    GROUP BY
        invoice_date,
        invoice_no,
        customer_id,
        quantity,
        stock_code,
        description,
        unit_price,
        country
    HAVING COUNT(*) > 1
) AS duplicate;


-- Inspect a sample of exact duplicate groups.

SELECT *
FROM (
    SELECT
        invoice_date,
        invoice_no,
        customer_id,
        quantity,
        stock_code,
        description,
        unit_price,
        country,
        COUNT(*) AS count_duplicate
    FROM raw_ecommerce
    GROUP BY
        invoice_date,
        invoice_no,
        customer_id,
        quantity,
        stock_code,
        description,
        unit_price,
        country
    HAVING COUNT(*) > 1
) AS duplicate
LIMIT 10;


-- Analyze how many duplicate groups exist at each
-- duplicate frequency.

SELECT
    count_duplicate,
    COUNT(*) AS number_group
FROM (
    SELECT
        invoice_date,
        invoice_no,
        customer_id,
        quantity,
        stock_code,
        description,
        unit_price,
        country,
        COUNT(*) AS count_duplicate
    FROM raw_ecommerce
    GROUP BY
        invoice_date,
        invoice_no,
        customer_id,
        quantity,
        stock_code,
        description,
        unit_price,
        country
    HAVING COUNT(*) > 1
) AS duplicate
GROUP BY count_duplicate;


-- Check whether invoice number + stock code can be used
-- as a unique combination.
-- The result showed that this combination is not unique,
-- so it is not treated as a unique key.

SELECT
    invoice_no,
    stock_code,
    COUNT(*) AS duplicate_row
FROM raw_ecommerce
GROUP BY
    invoice_no,
    stock_code
HAVING COUNT(*) > 1;


-- ============================================================
-- SECTION 2: MISSING VALUE INVESTIGATION
-- ============================================================

-- Count rows where customer_id is missing.

SELECT
    COUNT(*)
FROM raw_ecommerce
WHERE customer_id IS NULL;


-- Count rows where customer_id is missing but description
-- is available.

SELECT
    COUNT(*)
FROM raw_ecommerce
WHERE customer_id IS NULL
  AND description IS NOT NULL;


-- Compare customer_id and description missing-value patterns
-- in a single query.

SELECT
    COUNT(*) FILTER (
        WHERE customer_id IS NULL
    ) AS null_customer,

    COUNT(*) FILTER (
        WHERE customer_id IS NULL
          AND description IS NULL
    ) AS both_null,

    COUNT(*) FILTER (
        WHERE customer_id IS NULL
          AND description IS NOT NULL
    ) AS customer_null_description_present
FROM raw_ecommerce;


-- ============================================================
-- SECTION 3: QUANTITY INVESTIGATION
-- ============================================================

-- Identify rows with negative quantities.
-- Negative quantities may represent returns or cancellations,
-- so they are not removed automatically.

SELECT
    COUNT(*)
FROM raw_ecommerce
WHERE quantity < 0;


-- Check whether any rows contain zero quantity.

SELECT
    COUNT(*)
FROM raw_ecommerce
WHERE quantity = 0;


-- ============================================================
-- SECTION 4: UNIT PRICE INVESTIGATION
-- ============================================================

-- Check for negative unit prices.

SELECT
    COUNT(*)
FROM raw_ecommerce
WHERE unit_price < 0;


-- Check for zero unit prices.

SELECT
    COUNT(*)
FROM raw_ecommerce
WHERE unit_price = 0;


-- ============================================================
-- SECTION 5: INVOICE NUMBER VALIDATION
-- ============================================================

-- Check for missing invoice numbers.
-- Invoice number is important for identifying transactions.

SELECT
    COUNT(*)
FROM raw_ecommerce
WHERE invoice_no IS NULL;


-- ============================================================
-- SECTION 6: CREATE CLEAN TABLE
-- ============================================================

-- Create a working copy of the raw dataset.
-- The raw_ecommerce table remains unchanged.

CREATE TABLE clean_ecommerce AS
SELECT *
FROM raw_ecommerce;


-- ============================================================
-- SECTION 7: CREATE ORDER STATUS
-- ============================================================

-- Add a derived order status column.
-- Invoice numbers beginning with 'C' are classified as
-- cancelled transactions. All other invoices are classified
-- as delivered transactions.

ALTER TABLE clean_ecommerce
ADD COLUMN order_status VARCHAR(100);


UPDATE clean_ecommerce
SET order_status =
    CASE
        WHEN invoice_no LIKE 'C%' THEN 'CANCELED'
        ELSE 'DELIVERED'
    END;


-- Preview the newly created order status column.

SELECT
    order_status
FROM clean_ecommerce
LIMIT 10;


-- Validate the distribution of order statuses.

SELECT
    order_status,
    COUNT(*)
FROM clean_ecommerce
GROUP BY order_status;


-- ============================================================
-- SECTION 8: CREATE SALES AMOUNT
-- ============================================================

-- Add a transaction-level sales amount column.
-- Sales amount is calculated as:
-- Quantity × Unit Price

ALTER TABLE clean_ecommerce
ADD COLUMN sales_amount DECIMAL;


UPDATE clean_ecommerce
SET sales_amount = quantity * unit_price;


-- Verify the calculated sales amount using sample records.
-- Results are ordered from highest to lowest sales amount.

SELECT
    sales_amount,
    quantity,
    unit_price
FROM clean_ecommerce
ORDER BY sales_amount DESC
LIMIT 10;


-- ============================================================
-- END OF DATA CLEANING & TRANSFORMATION
-- ============================================================
```