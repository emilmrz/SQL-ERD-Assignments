-- MODIFICATIONS | SQLite | 7 tasks
-- Read-only scripts use the clean SalesDB.sqlite file.
-- Modification tasks use SalesDB_Practice.sqlite ONLY.

-- B10: SAFE PRACTICE COPY ONLY: insert, update, verify, delete targeted test product
INSERT INTO Products(ProductID,Product,Category,Price) VALUES (502,'Temporary Test Item','Stationery',20);
UPDATE Products SET Price=25 WHERE ProductID=502;
SELECT * FROM Products WHERE ProductID=502;
DELETE FROM Products WHERE ProductID=502;
-- WHERE prevents unintended changes to every row;

-- 2.5: PRACTICE: create valid temporary 105 then correct shipping data
INSERT INTO Orders(OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,OrderStatus,Quantity,Sales,CreationTime) VALUES (105,101,1,11,'2026-11-01','Pending',1,55,'2026-11-01 10:00:00');
SELECT * FROM Orders WHERE OrderID=105;
UPDATE Orders SET OrderStatus='Shipped',ShipDate='2026-11-05' WHERE OrderID=105;
SELECT OrderID,OrderStatus,ShipDate FROM Orders WHERE OrderID=105;

-- 2.6: PRACTICE: create valid temporary 110 then correct address
INSERT INTO Orders(OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,OrderStatus,Quantity,Sales,CreationTime) VALUES (110,101,1,11,'2026-11-01','Pending',1,55,'2026-11-01 10:00:00');
SELECT * FROM Orders WHERE OrderID=110;
UPDATE Orders SET ShipAddress='45 Main Street, Baku' WHERE OrderID=110;
SELECT OrderID,ShipAddress FROM Orders WHERE OrderID=110;

-- 2.7: PRACTICE: delete temporary test order only
INSERT INTO Orders(OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,OrderStatus,Quantity,Sales,CreationTime) VALUES (999,101,1,11,'2026-11-01','Pending',1,55,'2026-11-01 10:00:00');
SELECT * FROM Orders WHERE OrderID=999;
DELETE FROM Orders WHERE OrderID=999;
SELECT * FROM Orders WHERE OrderID=999;

-- 3.8: PRACTICE: insert Wireless Keyboard
INSERT INTO Products(ProductID,Product,Category,Price) VALUES(501,'Wireless Keyboard','Electronics',75);
SELECT * FROM Products WHERE ProductID=501;

-- 3.9: PRACTICE: update Wireless Keyboard price
SELECT * FROM Products WHERE ProductID=501;
UPDATE Products SET Price=90 WHERE ProductID=501;
SELECT * FROM Products WHERE ProductID=501;

-- 3.10: PRACTICE: add inventory column
ALTER TABLE Products ADD COLUMN StockQuantity INTEGER;
PRAGMA table_info(Products);
