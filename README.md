# E-commerce Sales Analysis using PostgreSQL

## Project Overview

This project analyzes an e-commerce transaction dataset using **PostgreSQL** to understand sales performance, product demand, customer value, geographic performance, and order outcomes.

The project focuses on transforming raw transaction data into meaningful business metrics through SQL-based data cleaning, analysis, and aggregation.

## Business Objective

The objective of this project is to understand:

- Overall sales performance
- Product demand and sales contribution
- Customer purchasing behavior and value
- Geographic sales performance
- Order cancellations and successful orders
- Key business metrics derived from transaction data

## Dataset

The dataset contains **541,909 transaction records** with the following fields:

- Invoice Number
- Stock Code
- Description
- Quantity
- Invoice Date
- Unit Price
- Customer ID
- Country

The raw dataset is preserved in its original form, while data preparation and derived fields are handled in PostgreSQL.

## Tools & Technologies

- **PostgreSQL**
- **SQL**
- **VS Code**
- **SQLTools**
- **Git & GitHub**

## Data Preparation

The project uses a two-table approach:

- `raw_ecommerce` — stores the original imported dataset without modifications.
- `clean_ecommerce` — contains the data used for analysis and includes derived fields.

Data preparation included:

- Loading the original CSV into PostgreSQL
- Checking missing values
- Reviewing duplicate records
- Checking negative quantities and unusual unit prices
- Creating an `order_status` field
- Creating a `sales_amount` field

The `sales_amount` field was calculated as:

```sql
quantity * unit_price
```

Order status was derived from the invoice number to identify canceled and delivered orders.

## SQL Analysis

The analysis is organized into separate SQL files:

### 1. Sales Performance

Analyzes:

- Overall sales
- Total quantity
- Average unit price
- Top products by sales
- Monthly sales performance

### 2. Product Performance

Analyzes:

- Total number of products
- Top products by quantity sold
- Average unit price of high-volume products
- Monthly demand for the highest-volume product

### 3. Geographic Performance

Analyzes:

- Total countries served
- Top countries by sales
- Top countries by quantity
- Sales and quantity comparison by country

### 4. Customer Value

Analyzes:

- Total unique customers
- Top customers by sales
- Top customers by number of orders
- Average order value by customer

### 5. Overall Business Highlights

Combines major business metrics including:

- Total orders
- Total customers
- Total products
- Geographic reach
- Total quantity
- Average unit price
- Total sales amount
- Cancellation percentage
- Successful order percentage

## Key SQL Concepts Used

The project uses several PostgreSQL concepts, including:

- `SELECT`
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- `LIMIT`
- `COUNT()`
- `COUNT(DISTINCT ...)`
- `SUM()`
- `AVG()`
- `CASE WHEN`
- Subqueries
- `DATE_TRUNC()`
- `TO_CHAR()`
- Aggregate functions
- Conditional aggregation

## Project Structure

```text
E-Commerce-SQL-Analysis/
│
├── data/
│   └── ecommerce.csv
│
├── output/
│
├── sql/
│   ├── 01_loading.sql
│   ├── 02_cleaning.sql
│   ├── 03_sales_analysis.sql
│   ├── 04_product_analysis.sql
│   ├── 05_region_analysis.sql
│   ├── 06_customer_analysis.sql
│   └── 07_key_data_insights.sql
│
└── README.md
```

## How to Run

1. Create a PostgreSQL database.
2. Import the raw CSV dataset into the `raw_ecommerce` table.
3. Run `01_loading.sql`.
4. Run `02_cleaning.sql`.
5. Execute the analysis files in the `sql` folder.
6. Review the query results in PostgreSQL/VS Code.

## Project Purpose

This project was created as a practical SQL learning and portfolio project, with a focus on writing queries, analyzing real-world transaction data, and applying SQL concepts to business questions.
