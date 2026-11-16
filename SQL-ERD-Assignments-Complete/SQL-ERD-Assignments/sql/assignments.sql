-- ALL 68 TASKS | SQLITe
-- IMPORTANT: run database_setup.sql on NEW empty DB only.
-- IMPORTANT: the marked modification tasks MUST run only in SalesDB_Practice.sqlite.
-- For a one-click read-only report file use reporting_only.sql.

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

-- B10: SAFE PRACTICE COPY ONLY: insert, update, verify, delete targeted test product
-- PRACTICE-ONLY BLOCK; run from sql/modifications.sql on a practice copy.
-- INSERT INTO Products(ProductID,Product,Category,Price) VALUES (502,'Temporary Test Item','Stationery',20);
-- UPDATE Products SET Price=25 WHERE ProductID=502;
-- SELECT * FROM Products WHERE ProductID=502;
-- DELETE FROM Products WHERE ProductID=502;
-- -- WHERE prevents unintended changes to every row;

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

-- 2.1: October order register
SELECT OrderID,CustomerID,OrderDate,ShipDate,OrderStatus FROM Orders WHERE OrderDate BETWEEN '2026-10-01' AND '2026-10-31' ORDER BY OrderDate,OrderID;

-- 2.2: Pending oldest first
SELECT * FROM Orders WHERE OrderStatus='Pending' ORDER BY OrderDate,OrderID;

-- 2.3: Dispatch more than 7 days after placement
SELECT o.OrderID,c.FirstName || ' ' || c.LastName AS CustomerName,o.OrderDate,o.ShipDate FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID WHERE o.ShipDate IS NOT NULL AND julianday(o.ShipDate)-julianday(o.OrderDate)>7 ORDER BY o.OrderID;

-- 2.4: Customers associated with delayed orders
SELECT DISTINCT c.CustomerID,c.FirstName || ' ' || c.LastName AS CustomerName,c.Country FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID WHERE o.ShipDate IS NOT NULL AND julianday(o.ShipDate)-julianday(o.OrderDate)>7 ORDER BY c.CustomerID;

-- 2.5: PRACTICE: create valid temporary 105 then correct shipping data
-- PRACTICE-ONLY BLOCK; run from sql/modifications.sql on a practice copy.
-- INSERT INTO Orders(OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,OrderStatus,Quantity,Sales,CreationTime) VALUES (105,101,1,11,'2026-11-01','Pending',1,55,'2026-11-01 10:00:00');
-- SELECT * FROM Orders WHERE OrderID=105;
-- UPDATE Orders SET OrderStatus='Shipped',ShipDate='2026-11-05' WHERE OrderID=105;
-- SELECT OrderID,OrderStatus,ShipDate FROM Orders WHERE OrderID=105;

-- 2.6: PRACTICE: create valid temporary 110 then correct address
-- PRACTICE-ONLY BLOCK; run from sql/modifications.sql on a practice copy.
-- INSERT INTO Orders(OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,OrderStatus,Quantity,Sales,CreationTime) VALUES (110,101,1,11,'2026-11-01','Pending',1,55,'2026-11-01 10:00:00');
-- SELECT * FROM Orders WHERE OrderID=110;
-- UPDATE Orders SET ShipAddress='45 Main Street, Baku' WHERE OrderID=110;
-- SELECT OrderID,ShipAddress FROM Orders WHERE OrderID=110;

-- 2.7: PRACTICE: delete temporary test order only
-- PRACTICE-ONLY BLOCK; run from sql/modifications.sql on a practice copy.
-- INSERT INTO Orders(OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,OrderStatus,Quantity,Sales,CreationTime) VALUES (999,101,1,11,'2026-11-01','Pending',1,55,'2026-11-01 10:00:00');
-- SELECT * FROM Orders WHERE OrderID=999;
-- DELETE FROM Orders WHERE OrderID=999;
-- SELECT * FROM Orders WHERE OrderID=999;

-- 2.8: Count orders in each status
SELECT OrderStatus,COUNT(*) AS OrderCount FROM Orders GROUP BY OrderStatus ORDER BY OrderStatus;

-- 2.9: Unshipped orders including cancelled and inconsistent records
SELECT o.OrderID,c.FirstName || ' ' || c.LastName AS CustomerName,o.OrderDate,o.OrderStatus FROM Orders o JOIN Customers c ON c.CustomerID=o.CustomerID WHERE o.ShipDate IS NULL ORDER BY o.OrderDate,o.OrderID;

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

-- 3.8: PRACTICE: insert Wireless Keyboard
-- PRACTICE-ONLY BLOCK; run from sql/modifications.sql on a practice copy.
-- INSERT INTO Products(ProductID,Product,Category,Price) VALUES(501,'Wireless Keyboard','Electronics',75);
-- SELECT * FROM Products WHERE ProductID=501;

-- 3.9: PRACTICE: update Wireless Keyboard price
-- PRACTICE-ONLY BLOCK; run from sql/modifications.sql on a practice copy.
-- SELECT * FROM Products WHERE ProductID=501;
-- UPDATE Products SET Price=90 WHERE ProductID=501;
-- SELECT * FROM Products WHERE ProductID=501;

-- 3.10: PRACTICE: add inventory column
-- PRACTICE-ONLY BLOCK; run from sql/modifications.sql on a practice copy.
-- ALTER TABLE Products ADD COLUMN StockQuantity INTEGER;
-- PRAGMA table_info(Products);

-- 3.11: Union unique first/last-name combinations
SELECT FirstName,LastName FROM Customers UNION SELECT FirstName,LastName FROM Employees ORDER BY FirstName,LastName;

-- 3.12: Categories with stored Sales >2000
SELECT p.Category,SUM(o.Quantity) AS TotalQuantity,SUM(o.Sales) AS TotalSales FROM Products p JOIN Orders o ON o.ProductID=p.ProductID GROUP BY p.Category HAVING SUM(o.Sales)>2000 ORDER BY TotalSales DESC,p.Category;

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

