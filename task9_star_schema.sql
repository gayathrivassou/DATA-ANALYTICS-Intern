
-- TASK 9: STAR SCHEMA SQL

CREATE TABLE dim_customer (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50)
);

CREATE TABLE dim_product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(50),
    sub_category VARCHAR(50)
);

CREATE TABLE dim_date (
    date_id SERIAL PRIMARY KEY,
    order_date DATE,
    year INT,
    month INT,
    month_name VARCHAR(20),
    quarter INT
);

CREATE TABLE dim_region (
    region_id SERIAL PRIMARY KEY,
    country VARCHAR(50),
    region VARCHAR(50),
    state VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE fact_sales (
    sales_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES dim_customer(customer_id),
    product_id INT REFERENCES dim_product(product_id),
    date_id INT REFERENCES dim_date(date_id),
    region_id INT REFERENCES dim_region(region_id),
    sales_amount NUMERIC(10,2),
    quantity INT,
    discount NUMERIC(5,2),
    profit NUMERIC(10,2)
);
