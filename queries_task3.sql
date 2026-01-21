
-- Task 3: SQL Basics – Filtering, Sorting, Aggregations
-- Dataset: Chinook / Superstore / Retail Sales

-- 1. View sample data
SELECT * FROM sales LIMIT 10;

-- 2. Total records count
SELECT COUNT(*) AS total_records FROM sales;

-- 3. Filter by category and sort by sales
SELECT 
    product_name,
    category,
    sales
FROM sales
WHERE category = 'Technology'
ORDER BY sales DESC;

-- 4. Aggregation: Category-wise sales and profit
SELECT 
    category,
    SUM(sales) AS total_sales,
    AVG(profit) AS avg_profit,
    COUNT(*) AS order_count
FROM sales
GROUP BY category;

-- 5. HAVING clause: categories with high sales
SELECT 
    category,
    SUM(sales) AS total_sales
FROM sales
GROUP BY category
HAVING SUM(sales) > 100000;

-- 6. Date range filter (monthly sales)
SELECT 
    DATE(order_date) AS order_date,
    SUM(sales) AS daily_sales
FROM sales
WHERE order_date BETWEEN '2014-01-01' AND '2014-01-31'
GROUP BY DATE(order_date);

-- 7. LIKE pattern search (customer names)
SELECT 
    customer_name,
    sales
FROM sales
WHERE customer_name LIKE 'A%';
