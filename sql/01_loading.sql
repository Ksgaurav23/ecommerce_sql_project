CREATE TABLE raw_ecommerce 
(
    invoice_no VARCHAR(100),
    stock_code VARCHAR(100),
    description VARCHAR(100),
    quantity INT,
    invoice_date TIMESTAMP,
    unit_price DECIMAL,
    customer_id INT,
    country VARCHAR(100)

);

SET datestyle = 'ISO, DMY';

COPY raw_ecommerce
FROM 'D:\Programming\ecommerce_sql_project\data\ecommerce.csv'
WITH (
       FORMAT csv,
       HEADER
      );

SELECT
       COUNT(*) 
       FROM raw_ecommerce
    ;