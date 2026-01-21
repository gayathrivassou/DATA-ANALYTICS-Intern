
-- Task 4: SQL Intermediate – Joins (INNER, LEFT) + Business Questions
-- Dataset: Chinook (or similar E‑commerce schema)

-- 1. INNER JOIN: Orders with Customers
SELECT 
    c.CustomerId,
    c.FirstName || ' ' || c.LastName AS customer_name,
    i.InvoiceId,
    i.InvoiceDate,
    i.Total
FROM Customers c
INNER JOIN Invoices i
    ON c.CustomerId = i.CustomerId;

-- 2. LEFT JOIN: Customers who never placed any orders
SELECT 
    c.CustomerId,
    c.FirstName || ' ' || c.LastName AS customer_name
FROM Customers c
LEFT JOIN Invoices i
    ON c.CustomerId = i.CustomerId
WHERE i.InvoiceId IS NULL;

-- 3. Revenue per Product
SELECT 
    t.TrackId,
    t.Name AS product_name,
    SUM(il.UnitPrice * il.Quantity) AS total_revenue
FROM InvoiceLines il
INNER JOIN Tracks t
    ON il.TrackId = t.TrackId
GROUP BY t.TrackId, t.Name
ORDER BY total_revenue DESC;

-- 4. Category-wise Revenue
SELECT 
    g.Name AS category,
    SUM(il.UnitPrice * il.Quantity) AS category_revenue
FROM InvoiceLines il
INNER JOIN Tracks t ON il.TrackId = t.TrackId
INNER JOIN Genres g ON t.GenreId = g.GenreId
GROUP BY g.Name
ORDER BY category_revenue DESC;

-- 5. Business condition example: Sales between dates
SELECT 
    c.Country,
    SUM(i.Total) AS total_sales
FROM Customers c
INNER JOIN Invoices i
    ON c.CustomerId = i.CustomerId
WHERE i.InvoiceDate BETWEEN '2013-01-01' AND '2013-12-31'
GROUP BY c.Country
ORDER BY total_sales DESC;
