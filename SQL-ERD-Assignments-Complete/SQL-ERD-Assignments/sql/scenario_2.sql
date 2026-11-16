-- SCENARIO 2 | SQLite | 6 tasks
-- Read-only scripts use the clean SalesDB.sqlite file.
-- Modification tasks use SalesDB_Practice.sqlite ONLY.

-- 2.1: October order register
SELECT OrderID,CustomerID,OrderDate,ShipDate,OrderStatus FROM Orders WHERE OrderDate BETWEEN '2026-10-01' AND '2026-10-31' ORDER BY OrderDate,OrderID;

-- 2.2: Pending oldest first
SELECT * FROM Orders WHERE OrderStatus='Pending' ORDER BY OrderDate,OrderID;

-- 2.3: Dispatch more than 7 days after placement
SELECT o.OrderID,c.FirstName || ' ' || c.LastName AS CustomerName,o.OrderDate,o.ShipDate FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID WHERE o.ShipDate IS NOT NULL AND julianday(o.ShipDate)-julianday(o.OrderDate)>7 ORDER BY o.OrderID;

-- 2.4: Customers associated with delayed orders
SELECT DISTINCT c.CustomerID,c.FirstName || ' ' || c.LastName AS CustomerName,c.Country FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID WHERE o.ShipDate IS NOT NULL AND julianday(o.ShipDate)-julianday(o.OrderDate)>7 ORDER BY c.CustomerID;

-- 2.8: Count orders in each status
SELECT OrderStatus,COUNT(*) AS OrderCount FROM Orders GROUP BY OrderStatus ORDER BY OrderStatus;

-- 2.9: Unshipped orders including cancelled and inconsistent records
SELECT o.OrderID,c.FirstName || ' ' || c.LastName AS CustomerName,o.OrderDate,o.OrderStatus FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID WHERE o.ShipDate IS NULL ORDER BY o.OrderDate,o.OrderID;
