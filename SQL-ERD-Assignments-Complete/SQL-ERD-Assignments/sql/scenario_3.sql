-- SCENARIO 3 | SQLite | 9 tasks
-- Read-only scripts use the clean SalesDB.sqlite file.
-- Modification tasks use SalesDB_Practice.sqlite ONLY.

-- 3.1: Products priced from 50 to 300
SELECT Product,Category,Price FROM Products WHERE Price BETWEEN 50 AND 300 ORDER BY Price,ProductID;

-- 3.2: Electronic products over 500
SELECT Product,Category,Price FROM Products WHERE Category='Electronics' AND Price>500;

-- 3.3: Product and associated order rows
SELECT p.Product,p.Category,o.Quantity,o.Sales FROM Products p JOIN Orders o ON o.ProductID=p.ProductID ORDER BY o.OrderID;

-- 3.4: Top five products by units sold
SELECT p.ProductID,p.Product,SUM(o.Quantity) AS TotalQuantity FROM Products p JOIN Orders o ON o.ProductID=p.ProductID GROUP BY p.ProductID,p.Product ORDER BY TotalQuantity DESC,p.ProductID LIMIT 5;

-- 3.5: Products without orders
SELECT p.ProductID,p.Product,p.Category FROM Products p LEFT JOIN Orders o ON o.ProductID=p.ProductID WHERE o.OrderID IS NULL ORDER BY p.ProductID;

-- 3.6: Sales handled by employees
SELECT e.EmployeeID,e.FirstName || ' ' || e.LastName AS EmployeeName,e.Department,SUM(o.Sales) AS TotalSales FROM Employees e JOIN Orders o ON o.SalesPersonID=e.EmployeeID GROUP BY e.EmployeeID,e.FirstName,e.LastName,e.Department ORDER BY TotalSales DESC,e.EmployeeID;

-- 3.7: Staff with total stored Sales over 5000
SELECT e.EmployeeID,e.FirstName || ' ' || e.LastName AS EmployeeName,e.Department,SUM(o.Sales) AS TotalSales FROM Employees e JOIN Orders o ON o.SalesPersonID=e.EmployeeID GROUP BY e.EmployeeID,e.FirstName,e.LastName,e.Department HAVING SUM(o.Sales)>5000 ORDER BY TotalSales DESC,e.EmployeeID;

-- 3.11: Union unique first/last-name combinations
SELECT FirstName,LastName FROM Customers UNION SELECT FirstName,LastName FROM Employees ORDER BY FirstName,LastName;

-- 3.12: Categories with stored Sales >2000
SELECT p.Category,SUM(o.Quantity) AS TotalQuantity,SUM(o.Sales) AS TotalSales FROM Products p JOIN Orders o ON o.ProductID=p.ProductID GROUP BY p.Category HAVING SUM(o.Sales)>2000 ORDER BY TotalSales DESC,p.Category;
