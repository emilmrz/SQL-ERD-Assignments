-- SCENARIO 1 | SQLite | 7 tasks
-- Read-only scripts use the clean SalesDB.sqlite file.
-- Modification tasks use SalesDB_Practice.sqlite ONLY.

-- 1.1: Score above 500 sorted descending
SELECT FirstName,LastName,Country,Score FROM Customers WHERE Score>500 ORDER BY Score DESC,CustomerID;

-- 1.2: Target countries with score >=300
SELECT FirstName,LastName,Country,Score FROM Customers WHERE Country IN ('Germany','France','USA') AND Score>=300 ORDER BY CustomerID;

-- 1.3: Each existing order with customer name
SELECT c.FirstName || ' ' || c.LastName AS CustomerName,o.OrderID,o.OrderDate,o.Sales FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID ORDER BY o.OrderID;

-- 1.4: Customers who have never ordered
SELECT c.CustomerID,c.FirstName,c.LastName,c.Country FROM Customers c LEFT JOIN Orders o ON o.CustomerID=c.CustomerID WHERE o.OrderID IS NULL ORDER BY c.CustomerID;

-- 1.5: Total spending per customer with orders
SELECT c.CustomerID,c.FirstName || ' ' || c.LastName AS CustomerName,SUM(o.Sales) AS TotalSales FROM Customers c JOIN Orders o ON o.CustomerID=c.CustomerID GROUP BY c.CustomerID,c.FirstName,c.LastName ORDER BY TotalSales DESC,c.CustomerID;

-- 1.6: Customers with stored Sales totals above 1000
SELECT c.CustomerID,c.FirstName || ' ' || c.LastName AS CustomerName,SUM(o.Sales) AS TotalSales FROM Customers c JOIN Orders o ON o.CustomerID=c.CustomerID GROUP BY c.CustomerID,c.FirstName,c.LastName HAVING SUM(o.Sales)>1000 ORDER BY TotalSales DESC,c.CustomerID;

-- 1.7: Top five customers by stored Sales
SELECT c.CustomerID,c.FirstName || ' ' || c.LastName AS CustomerName,c.Country,SUM(o.Sales) AS TotalSales FROM Customers c JOIN Orders o ON o.CustomerID=c.CustomerID GROUP BY c.CustomerID,c.FirstName,c.LastName,c.Country ORDER BY TotalSales DESC,c.CustomerID LIMIT 5;
