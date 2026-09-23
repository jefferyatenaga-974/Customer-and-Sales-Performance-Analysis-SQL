-- ============================================================
-- Customer and Sales Performance Analysis
-- Database: Northwind (SQLite)
-- Author: Jeffery Dafinone Atenaga
-- ============================================================
-- Six business questions answered with SQL. Each query is
-- commented with what it does and why it matters.
-- ============================================================


-- ------------------------------------------------------------
-- DATA QUALITY CHECK
-- Two customer records named "IT" were found with every other
-- field blank (address, city, region, country, phone). These
-- were excluded from Question 1 as invalid/placeholder data.
-- ------------------------------------------------------------
SELECT * FROM Customers WHERE CompanyName = 'IT';


-- ------------------------------------------------------------
-- QUESTION 1: Who are our top 10 customers by spend?
-- Why it matters: protecting top spenders with better service
-- or loyalty offers matters more than chasing small customers.
-- ------------------------------------------------------------
SELECT
    Customers.CompanyName,
    SUM(("Order Details".UnitPrice * "Order Details".Quantity) * (1 - "Order Details".Discount)) AS TotalSpent
FROM Orders
JOIN "Order Details" ON Orders.OrderID = "Order Details".OrderID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.CompanyName != 'IT'
GROUP BY Customers.CompanyName
ORDER BY TotalSpent DESC
LIMIT 10;


-- ------------------------------------------------------------
-- QUESTION 2: Which employee has made the most sales?
-- Why it matters: shows management who's driving revenue and
-- who might need recognition, a bonus, or extra support.
-- ------------------------------------------------------------
SELECT
    Employees.FirstName || ' ' || Employees.LastName AS EmployeeName,
    SUM(("Order Details".UnitPrice * "Order Details".Quantity) * (1 - "Order Details".Discount)) AS TotalSales
FROM Orders
JOIN "Order Details" ON Orders.OrderID = "Order Details".OrderID
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY Employees.EmployeeID
ORDER BY TotalSales DESC;


-- ------------------------------------------------------------
-- QUESTION 3: What are the best- and worst-selling products?
-- Why it matters: shows what to restock/promote vs. what might
-- be losing money and worth discontinuing or bundling.
-- Ranked by QUANTITY SOLD (not revenue), since revenue is
-- skewed by price differences between products.
-- ------------------------------------------------------------

-- Best sellers by quantity
SELECT
    Products.ProductName,
    SUM("Order Details".Quantity) AS TotalQuantitySold,
    SUM(("Order Details".UnitPrice * "Order Details".Quantity) * (1 - "Order Details".Discount)) AS TotalRevenue
FROM "Order Details"
JOIN Products ON "Order Details".ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY TotalQuantitySold DESC
LIMIT 10;

-- Worst sellers by quantity
SELECT
    Products.ProductName,
    SUM("Order Details".Quantity) AS TotalQuantitySold,
    SUM(("Order Details".UnitPrice * "Order Details".Quantity) * (1 - "Order Details".Discount)) AS TotalRevenue
FROM "Order Details"
JOIN Products ON "Order Details".ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY TotalQuantitySold ASC
LIMIT 10;


-- ------------------------------------------------------------
-- QUESTION 4: Which shipping company is used most, and is it
-- the fastest?
-- Why it matters: slow delivery damages customer trust, so
-- knowing which courier performs best matters for repeat business.
-- ------------------------------------------------------------
SELECT
    Shippers.CompanyName AS ShippingCompany,
    COUNT(Orders.OrderID) AS NumberOfOrders,
    AVG(julianday(Orders.ShippedDate) - julianday(Orders.OrderDate)) AS AvgDaysToShip
FROM Orders
JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
WHERE Orders.ShippedDate IS NOT NULL
GROUP BY Shippers.CompanyName
ORDER BY NumberOfOrders DESC;


-- ------------------------------------------------------------
-- QUESTION 5: Are there seasonal patterns in order volume?
-- Why it matters: helps the business plan staffing and stock
-- levels ahead of busy or slow periods.
-- ------------------------------------------------------------
SELECT
    strftime('%m', OrderDate) AS MonthNumber,
    COUNT(OrderID) AS NumberOfOrders
FROM Orders
GROUP BY MonthNumber
ORDER BY NumberOfOrders DESC;


-- ------------------------------------------------------------
-- QUESTION 6: Do bigger discounts lead to bigger order quantities?
-- Why it matters: shows whether discounts are actually working,
-- or just cutting into profit with no real change in behavior.
-- Discount levels with only 1-3 line items were treated as
-- unreliable and excluded from the final interpretation.
-- ------------------------------------------------------------
SELECT
    Discount,
    AVG(Quantity) AS AvgQuantity,
    COUNT(*) AS NumberOfLineItems
FROM "Order Details"
GROUP BY Discount
ORDER BY Discount ASC;
