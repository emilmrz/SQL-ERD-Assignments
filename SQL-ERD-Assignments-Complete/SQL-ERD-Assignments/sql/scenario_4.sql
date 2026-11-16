-- SCENARIO 4 | SQLite | 10 tasks
-- Read-only scripts use the clean SalesDB.sqlite file.
-- Modification tasks use SalesDB_Practice.sqlite ONLY.

-- 4.1: October target-country qualifying sales full register
SELECT o.OrderID,o.OrderDate,c.CustomerID,c.FirstName || ' ' || c.LastName AS CustomerName,c.Country,p.Product,p.Category,e.FirstName || ' ' || e.LastName AS EmployeeName,o.Quantity,o.Sales FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID JOIN Products p ON p.ProductID=o.ProductID JOIN Employees e ON e.EmployeeID=o.SalesPersonID WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' AND c.Country IN ('Germany','France','USA') ORDER BY c.Country,o.OrderDate,o.OrderID;

-- 4.2: Electronics + target country, score OR order amount correctly grouped
SELECT o.OrderID,c.CustomerID,c.FirstName || ' ' || c.LastName AS CustomerName,c.Country,c.Score,p.Product,o.Sales FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID JOIN Products p ON p.ProductID=o.ProductID WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' AND c.Country IN ('Germany','France','USA') AND p.Category='Electronics' AND (c.Score>=500 OR o.Sales>=1000) ORDER BY o.OrderID;

-- 4.3: Catalogue-only affordable Wireless/USB electronics
SELECT ProductID,Product,Category,Price FROM Products WHERE Category='Electronics' AND Price BETWEEN 40 AND 100 AND (Product LIKE '%Wireless%' OR Product LIKE '%USB%') ORDER BY Price,ProductID;

-- 4.4: Unique recipient list
SELECT DISTINCT c.CustomerID,c.FirstName,c.LastName,c.Country,c.Score FROM Customers c JOIN Orders o ON o.CustomerID=c.CustomerID JOIN Products p ON p.ProductID=o.ProductID WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' AND c.Country IN ('Germany','France','USA') AND c.Score>=500 AND p.Category='Electronics' ORDER BY c.CustomerID;

-- 4.5: Target accounts: >=2 qualifying orders and >=1000 stored Sales
SELECT c.CustomerID,c.FirstName || ' ' || c.LastName AS CustomerName,COUNT(o.OrderID) AS OrderCount,SUM(o.Quantity) AS TotalQuantity,SUM(o.Sales) AS TotalSales FROM Customers c JOIN Orders o ON o.CustomerID=c.CustomerID WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' AND c.Country IN ('Germany','France','USA') GROUP BY c.CustomerID,c.FirstName,c.LastName HAVING COUNT(o.OrderID)>=2 AND SUM(o.Sales)>=1000 ORDER BY TotalSales DESC,c.CustomerID;

-- 4.6: Qualifying October country/category groups over 500
SELECT c.Country,p.Category,COUNT(o.OrderID) AS OrderCount,SUM(o.Quantity) AS TotalQuantity,SUM(o.Sales) AS TotalSales FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID JOIN Products p ON p.ProductID=o.ProductID WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' AND c.Country IN ('Germany','France','USA') GROUP BY c.Country,p.Category HAVING SUM(o.Sales)>500 ORDER BY c.Country,p.Category;

-- 4.7: Target-country customers without qualifying October activity
SELECT c.CustomerID,c.FirstName || ' ' || c.LastName AS CustomerName,c.Country,c.Score FROM Customers c LEFT JOIN Orders o ON o.CustomerID=c.CustomerID AND o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' WHERE c.Country IN ('Germany','France','USA') AND o.OrderID IS NULL ORDER BY c.CustomerID;

-- 4.8: Customers in electronics and furniture audiences
SELECT c.CustomerID AS CustomerID FROM Customers c JOIN Orders o ON o.CustomerID=c.CustomerID JOIN Products p ON p.ProductID=o.ProductID WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' AND p.Category='Electronics' AND c.Country IN ('Germany','France','USA') INTERSECT SELECT c.CustomerID AS CustomerID FROM Customers c JOIN Orders o ON o.CustomerID=c.CustomerID JOIN Products p ON p.ProductID=o.ProductID WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' AND p.Category='Furniture' AND c.Country IN ('Germany','France','USA') ORDER BY CustomerID;

-- 4.9: Combined unique electronics/furniture audiences
SELECT c.CustomerID AS CustomerID FROM Customers c JOIN Orders o ON o.CustomerID=c.CustomerID JOIN Products p ON p.ProductID=o.ProductID WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' AND p.Category='Electronics' AND c.Country IN ('Germany','France','USA') UNION SELECT c.CustomerID AS CustomerID FROM Customers c JOIN Orders o ON o.CustomerID=c.CustomerID JOIN Products p ON p.ProductID=o.ProductID WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' AND p.Category='Furniture' AND c.Country IN ('Germany','France','USA') ORDER BY CustomerID;

-- 4.10: Electronics customers without furniture activity
SELECT c.CustomerID AS CustomerID FROM Customers c JOIN Orders o ON o.CustomerID=c.CustomerID JOIN Products p ON p.ProductID=o.ProductID WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' AND p.Category='Electronics' AND c.Country IN ('Germany','France','USA') EXCEPT SELECT c.CustomerID AS CustomerID FROM Customers c JOIN Orders o ON o.CustomerID=c.CustomerID JOIN Products p ON p.ProductID=o.ProductID WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' AND p.Category='Furniture' AND c.Country IN ('Germany','France','USA') ORDER BY CustomerID;
