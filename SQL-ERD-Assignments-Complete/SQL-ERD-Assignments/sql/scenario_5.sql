-- SCENARIO 5 | SQLite | 10 tasks
-- Read-only scripts use the clean SalesDB.sqlite file.
-- Modification tasks use SalesDB_Practice.sqlite ONLY.

-- 5.1: Complete pending queue as at November 7
SELECT o.OrderID,o.OrderDate,c.FirstName || ' ' || c.LastName AS CustomerName,c.Country,p.Product,o.Quantity,o.Sales,e.FirstName || ' ' || e.LastName AS EmployeeName,o.ShipAddress FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID JOIN Products p ON p.ProductID=o.ProductID JOIN Employees e ON e.EmployeeID=o.SalesPersonID WHERE o.OrderStatus='Pending' AND o.OrderDate<='2026-11-07' ORDER BY o.OrderDate,o.OrderID;

-- 5.2: Pending unshipped orders more than 7 days old
SELECT o.OrderID,c.FirstName || ' ' || c.LastName AS CustomerName,o.OrderDate,p.Product,e.FirstName || ' ' || e.LastName AS EmployeeName,o.Sales FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID JOIN Products p ON p.ProductID=o.ProductID JOIN Employees e ON e.EmployeeID=o.SalesPersonID WHERE o.OrderStatus='Pending' AND o.ShipDate IS NULL AND o.OrderDate<'2026-10-31' ORDER BY o.OrderDate,o.OrderID;

-- 5.3: Pending shipments without usable shipping address
SELECT o.OrderID,c.CustomerID,c.FirstName || ' ' || c.LastName AS CustomerName,e.FirstName || ' ' || e.LastName AS EmployeeName,o.ShipAddress FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID JOIN Employees e ON e.EmployeeID=o.SalesPersonID WHERE o.OrderStatus='Pending' AND o.OrderDate<='2026-11-07' AND (o.ShipAddress IS NULL OR o.ShipAddress='') ORDER BY o.OrderID;

-- 5.4: Different filled ship/bill addresses, not automatically an error
SELECT o.OrderID,c.FirstName || ' ' || c.LastName AS CustomerName,o.ShipAddress,o.BillAddress,o.OrderStatus FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID WHERE o.OrderStatus<>'Cancelled' AND o.OrderDate<='2026-11-07' AND o.ShipAddress IS NOT NULL AND o.ShipAddress<>'' AND o.BillAddress IS NOT NULL AND o.BillAddress<>'' AND o.ShipAddress<>o.BillAddress ORDER BY o.OrderID;

-- 5.5: Shipment inconsistency: early date OR shipped/delivered missing date
SELECT o.OrderID,o.OrderStatus,o.OrderDate,o.ShipDate,c.FirstName || ' ' || c.LastName AS CustomerName,e.FirstName || ' ' || e.LastName AS EmployeeName FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID JOIN Employees e ON e.EmployeeID=o.SalesPersonID WHERE o.OrderDate<='2026-11-07' AND ((o.ShipDate<o.OrderDate) OR (o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NULL)) ORDER BY o.OrderID;

-- 5.6: Noncancelled dispatch delays above 7 days
SELECT o.OrderID,c.FirstName || ' ' || c.LastName AS CustomerName,p.Product,o.OrderDate,o.ShipDate,CAST(julianday(o.ShipDate)-julianday(o.OrderDate) AS INTEGER) AS DaysToShip FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID JOIN Products p ON p.ProductID=o.ProductID WHERE o.OrderStatus<>'Cancelled' AND o.OrderDate<='2026-11-07' AND o.ShipDate>=o.OrderDate AND julianday(o.ShipDate)-julianday(o.OrderDate)>7 ORDER BY DaysToShip DESC,o.OrderID;

-- 5.7: All Sales employees and pending unshipped workload
SELECT e.EmployeeID,e.FirstName || ' ' || e.LastName AS EmployeeName,COUNT(o.OrderID) AS PendingOrderCount,COALESCE(SUM(o.Sales),0) AS PendingSales FROM Employees e LEFT JOIN Orders o ON o.SalesPersonID=e.EmployeeID AND o.OrderStatus='Pending' AND o.ShipDate IS NULL AND o.OrderDate<='2026-11-07' WHERE e.Department='Sales' GROUP BY e.EmployeeID,e.FirstName,e.LastName ORDER BY e.EmployeeID;

-- 5.8: Customers with at least two pending unshipped orders
SELECT c.CustomerID,c.FirstName || ' ' || c.LastName AS CustomerName,COUNT(o.OrderID) AS PendingOrderCount,SUM(o.Sales) AS PendingSales FROM Customers c JOIN Orders o ON o.CustomerID=c.CustomerID WHERE o.OrderStatus='Pending' AND o.ShipDate IS NULL AND o.OrderDate<='2026-11-07' GROUP BY c.CustomerID,c.FirstName,c.LastName HAVING COUNT(o.OrderID)>=2 ORDER BY c.CustomerID;

-- 5.9: Priority DE/US cases: pending or valid >7-day delay
SELECT o.OrderID,c.FirstName || ' ' || c.LastName AS CustomerName,c.Country,p.Product,o.Sales,o.OrderStatus,o.OrderDate,o.ShipDate FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID JOIN Products p ON p.ProductID=o.ProductID WHERE o.OrderDate<='2026-11-07' AND c.Country IN ('Germany','USA') AND o.Sales>=500 AND o.OrderStatus<>'Cancelled' AND ((o.OrderStatus='Pending' AND o.ShipDate IS NULL) OR (o.ShipDate>=o.OrderDate AND julianday(o.ShipDate)-julianday(o.OrderDate)>7)) ORDER BY o.OrderID;

-- 5.10: Pending unshipped with known shipping addresses, including missing billing
SELECT o.OrderID,c.FirstName || ' ' || c.LastName AS CustomerName,c.Country,p.Product,o.Quantity,o.ShipAddress,e.FirstName || ' ' || e.LastName AS EmployeeName FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID JOIN Products p ON p.ProductID=o.ProductID JOIN Employees e ON e.EmployeeID=o.SalesPersonID WHERE o.OrderDate<='2026-11-07' AND o.OrderStatus='Pending' AND o.ShipDate IS NULL AND o.ShipAddress IS NOT NULL AND o.ShipAddress<>'' ORDER BY c.Country,o.OrderDate,o.OrderID;
