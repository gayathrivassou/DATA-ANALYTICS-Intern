
-- =============================================
-- Task 8: SQL Window Functions – Ranking & Running Totals
-- Database: PostgreSQL
-- =============================================

-- Base aggregation: Total sales per customer
SELECT customer_name, SUM(sales) AS total_sales
FROM sales
GROUP BY customer_name;

-- ROW_NUMBER(): Rank customers by sales per region
SELECT 
    customer_name,
    region,
    SUM(sales) AS total_sales,
    ROW_NUMBER() OVER (
        PARTITION BY region 
        ORDER BY SUM(sales) DESC
    ) AS row_number_rank
FROM sales
GROUP BY customer_name, region;

-- RANK(): Ranking with gaps in ties
SELECT 
    customer_name,
    region,
    SUM(sales) AS total_sales,
    RANK() OVER (
        PARTITION BY region 
        ORDER BY SUM(sales) DESC
    ) AS rank_with_gaps
FROM sales
GROUP BY customer_name, region;

-- DENSE_RANK(): Ranking without gaps in ties
SELECT 
    customer_name,
    region,
    SUM(sales) AS total_sales,
    DENSE_RANK() OVER (
        PARTITION BY region 
        ORDER BY SUM(sales) DESC
    ) AS dense_rank_no_gaps
FROM sales
GROUP BY customer_name, region;

-- Running total of sales over time
SELECT 
    order_date,
    sales,
    SUM(sales) OVER (
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_sales
FROM sales;

-- Monthly totals using CTE + LAG for MoM growth
WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date) AS month,
        SUM(sales) AS monthly_total
    FROM sales
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT 
    month,
    monthly_total,
    LAG(monthly_total) OVER (ORDER BY month) AS previous_month_sales,
    monthly_total - LAG(monthly_total) OVER (ORDER BY month) AS mom_growth
FROM monthly_sales;

-- Top 3 products per category using DENSE_RANK
WITH product_sales AS (
    SELECT 
        category,
        product_name,
        SUM(sales) AS total_sales
    FROM sales
    GROUP BY category, product_name
),
ranked_products AS (
    SELECT 
        category,
        product_name,
        total_sales,
        DENSE_RANK() OVER (
            PARTITION BY category 
            ORDER BY total_sales DESC
        ) AS product_rank
    FROM product_sales
)
SELECT *
FROM ranked_products
WHERE product_rank <= 3;
