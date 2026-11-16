-- SCENARIO 6 | SQLite | 10 tasks
-- Read-only scripts use the clean SalesDB.sqlite file.
-- Modification tasks use SalesDB_Practice.sqlite ONLY.

-- 6.1: Self join employee reporting line including manager without manager
SELECT e.EmployeeID,e.FirstName||' '||e.LastName AS EmployeeName,e.Department,m.EmployeeID AS ManagerID,m.FirstName||' '||m.LastName AS ManagerName FROM Employees e LEFT JOIN Employees m ON m.EmployeeID=e.ManagerID ORDER BY e.EmployeeID;

-- 6.2: All Sales staff qualifying October scorecard including zero activity
SELECT e.EmployeeID,e.FirstName || ' ' || e.LastName AS EmployeeName,COUNT(o.OrderID) AS OrderCount,COALESCE(SUM(o.Quantity),0) AS TotalQuantity,COALESCE(SUM(o.Sales),0) AS TotalSales FROM Employees e LEFT JOIN Orders o ON o.SalesPersonID=e.EmployeeID AND o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' WHERE e.Department='Sales' GROUP BY e.EmployeeID,e.FirstName,e.LastName ORDER BY TotalSales DESC,e.EmployeeID;

-- 6.3: Managers of direct Sales staff; no manager own orders or indirect employees
SELECT m.EmployeeID AS ManagerID,m.FirstName||' '||m.LastName AS ManagerName,COUNT(DISTINCT e.EmployeeID) AS DirectSalesStaffCount,COUNT(o.OrderID) AS TeamOrderCount,COALESCE(SUM(o.Sales),0) AS TeamSales FROM Employees m JOIN Employees e ON e.ManagerID=m.EmployeeID AND e.Department='Sales' LEFT JOIN Orders o ON o.SalesPersonID=e.EmployeeID AND o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' GROUP BY m.EmployeeID,m.FirstName,m.LastName ORDER BY m.EmployeeID;

-- 6.4: Sales employees meeting both monthly qualifying targets
SELECT e.EmployeeID,e.FirstName || ' ' || e.LastName AS EmployeeName,COUNT(o.OrderID) AS OrderCount,SUM(o.Sales) AS TotalSales FROM Employees e JOIN Orders o ON o.SalesPersonID=e.EmployeeID AND o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' WHERE e.Department='Sales' GROUP BY e.EmployeeID,e.FirstName,e.LastName HAVING COUNT(o.OrderID)>=2 AND SUM(o.Sales)>=1000 ORDER BY TotalSales DESC,e.EmployeeID;

-- 6.5: Distinct customer and country coverage including zero-activity Sales staff
SELECT e.EmployeeID,e.FirstName || ' ' || e.LastName AS EmployeeName,COUNT(DISTINCT c.CustomerID) AS DistinctCustomers,COUNT(DISTINCT c.Country) AS DistinctCountries FROM Employees e LEFT JOIN Orders o ON o.SalesPersonID=e.EmployeeID AND o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' LEFT JOIN Customers c ON c.CustomerID=o.CustomerID WHERE e.Department='Sales' GROUP BY e.EmployeeID,e.FirstName,e.LastName ORDER BY e.EmployeeID;

-- 6.6: Sales employees with no qualifying October orders
SELECT e.EmployeeID,e.FirstName || ' ' || e.LastName AS EmployeeName,e.Department FROM Employees e LEFT JOIN Orders o ON o.SalesPersonID=e.EmployeeID AND o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' WHERE e.Department='Sales' AND o.OrderID IS NULL ORDER BY e.EmployeeID;

-- 6.7: Returning eligible customer IDs in both periods
SELECT o.CustomerID FROM Orders o WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' INTERSECT SELECT o.CustomerID FROM Orders o WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-11-01' AND '2026-11-07' ORDER BY CustomerID;

-- 6.8: October eligible customers with no qualifying return by November 7
SELECT o.CustomerID FROM Orders o WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' EXCEPT SELECT o.CustomerID FROM Orders o WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-11-01' AND '2026-11-07' ORDER BY CustomerID;

-- 6.9: New to comparison period, not necessarily first-ever buyers
SELECT o.CustomerID FROM Orders o WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-11-01' AND '2026-11-07' EXCEPT SELECT o.CustomerID FROM Orders o WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' ORDER BY CustomerID;

-- 6.10: Qualifying two-period sales register with UNION ALL
SELECT 'October 2026' AS PeriodLabel,o.OrderID,o.OrderDate,c.CustomerID,c.FirstName || ' ' || c.LastName AS CustomerName,e.FirstName || ' ' || e.LastName AS EmployeeName,o.Sales FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID JOIN Employees e ON e.EmployeeID=o.SalesPersonID WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31' UNION ALL SELECT 'November 01–07' AS PeriodLabel,o.OrderID,o.OrderDate,c.CustomerID,c.FirstName || ' ' || c.LastName AS CustomerName,e.FirstName || ' ' || e.LastName AS EmployeeName,o.Sales FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID JOIN Employees e ON e.EmployeeID=o.SalesPersonID WHERE o.OrderStatus IN ('Shipped','Delivered') AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate AND o.OrderDate BETWEEN '2026-11-01' AND '2026-11-07' ORDER BY OrderDate,OrderID;
