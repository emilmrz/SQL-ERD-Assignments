-- BASIC | SQLite | 9 tasks
-- Read-only scripts use the clean SalesDB.sqlite file.
-- Modification tasks use SalesDB_Practice.sqlite ONLY.

-- B01: Explore all Customers columns and selected name/country columns
SELECT * FROM Customers;
SELECT FirstName, LastName, Country FROM Customers;

-- B02: Filter German customers
SELECT CustomerID, FirstName, LastName, Country FROM Customers WHERE Country='Germany';

-- B03: Score >=300 in Germany or France
SELECT CustomerID, FirstName, LastName, Country, Score FROM Customers WHERE Score >= 300 AND Country IN ('Germany','France');

-- B04: Sort products by descending price
SELECT ProductID, Product, Category, Price FROM Products ORDER BY Price DESC, ProductID;

-- B05: Inclusive product price range
SELECT Product, Price FROM Products WHERE Price BETWEEN 50 AND 300;

-- B06: Products with Phone in the name
SELECT Product, Category FROM Products WHERE Product LIKE '%Phone%';

-- B07: Unique categories sorted
SELECT DISTINCT Category FROM Products ORDER BY Category;

-- B08: Each order with the customer name
SELECT o.OrderID,c.FirstName,c.LastName FROM Orders o INNER JOIN Customers c ON c.CustomerID=o.CustomerID ORDER BY o.OrderID;

-- B09: Counts and stored Sales by order status
SELECT OrderStatus,COUNT(*) AS OrderCount,SUM(Sales) AS TotalSales FROM Orders GROUP BY OrderStatus ORDER BY TotalSales DESC;
