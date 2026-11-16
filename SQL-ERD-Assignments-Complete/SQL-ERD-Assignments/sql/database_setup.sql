-- SQLite SalesDB reference schema | PDF pp. 2-7
PRAGMA foreign_keys = ON;
CREATE TABLE Customers (CustomerID INTEGER PRIMARY KEY, FirstName VARCHAR(50), LastName VARCHAR(50), Country VARCHAR(50), Score INTEGER);
CREATE TABLE Products (ProductID INTEGER PRIMARY KEY, Product VARCHAR(100), Category VARCHAR(50), Price DECIMAL(10,2));
CREATE TABLE Employees (EmployeeID INTEGER PRIMARY KEY, FirstName VARCHAR(50), LastName VARCHAR(50), Department VARCHAR(50), BirthDate DATE, Gender VARCHAR(10), Salary DECIMAL(10,2), ManagerID INTEGER REFERENCES Employees(EmployeeID));
CREATE TABLE Orders (OrderID INTEGER PRIMARY KEY, ProductID INTEGER REFERENCES Products(ProductID), CustomerID INTEGER REFERENCES Customers(CustomerID), SalesPersonID INTEGER REFERENCES Employees(EmployeeID), OrderDate DATE, ShipDate DATE, OrderStatus VARCHAR(30), ShipAddress VARCHAR(150), BillAddress VARCHAR(150), Quantity INTEGER, Sales DECIMAL(10,2), CreationTime DATETIME);

-- Customers reference records
INSERT INTO Customers (CustomerID,FirstName,LastName,Country,Score) VALUES (1, 'Ayla', 'Karimova', 'Azerbaijan', 720);
INSERT INTO Customers (CustomerID,FirstName,LastName,Country,Score) VALUES (2, 'John', 'Miller', 'USA', 450);
INSERT INTO Customers (CustomerID,FirstName,LastName,Country,Score) VALUES (3, 'Emma', 'Schmidt', 'Germany', 860);
INSERT INTO Customers (CustomerID,FirstName,LastName,Country,Score) VALUES (4, 'Sara', 'Martin', 'France', 280);
INSERT INTO Customers (CustomerID,FirstName,LastName,Country,Score) VALUES (5, 'Lukas', 'Weber', 'Germany', 550);
INSERT INTO Customers (CustomerID,FirstName,LastName,Country,Score) VALUES (6, 'Noah', 'Adams', 'USA', 610);
INSERT INTO Customers (CustomerID,FirstName,LastName,Country,Score) VALUES (7, 'Lea', 'Fischer', 'Germany', 680);
INSERT INTO Customers (CustomerID,FirstName,LastName,Country,Score) VALUES (8, 'Sofia', 'Rossi', 'Italy', 700);
INSERT INTO Customers (CustomerID,FirstName,LastName,Country,Score) VALUES (9, 'Ali', 'Hasanov', 'Azerbaijan', 330);

-- Products reference records
INSERT INTO Products (ProductID,Product,Category,Price) VALUES (101, 'Wireless Mouse', 'Electronics', 55);
INSERT INTO Products (ProductID,Product,Category,Price) VALUES (102, 'Office Chair', 'Furniture', 230);
INSERT INTO Products (ProductID,Product,Category,Price) VALUES (103, 'Laptop', 'Electronics', 850);
INSERT INTO Products (ProductID,Product,Category,Price) VALUES (104, 'Notebook', 'Stationery', 12);
INSERT INTO Products (ProductID,Product,Category,Price) VALUES (105, 'Smart Phone', 'Electronics', 420);
INSERT INTO Products (ProductID,Product,Category,Price) VALUES (106, 'Standing Desk', 'Furniture', 380);
INSERT INTO Products (ProductID,Product,Category,Price) VALUES (107, 'USB Hub', 'Electronics', 45);
INSERT INTO Products (ProductID,Product,Category,Price) VALUES (108, 'Desk Lamp', 'Furniture', 65);

-- Employees reference records
INSERT INTO Employees (EmployeeID,FirstName,LastName,Department,BirthDate,Gender,Salary,ManagerID) VALUES (12, 'Maya', 'Brown', 'Sales', '1990-07-09', 'Female', 2400, NULL);
INSERT INTO Employees (EmployeeID,FirstName,LastName,Department,BirthDate,Gender,Salary,ManagerID) VALUES (11, 'David', 'Lee', 'Sales', '1987-05-14', 'Male', 2200, 12);
INSERT INTO Employees (EmployeeID,FirstName,LastName,Department,BirthDate,Gender,Salary,ManagerID) VALUES (13, 'Alex', 'Green', 'Support', '1994-11-21', 'Male', 1900, 12);
INSERT INTO Employees (EmployeeID,FirstName,LastName,Department,BirthDate,Gender,Salary,ManagerID) VALUES (14, 'Omar', 'Ali', 'Sales', '1995-02-17', 'Male', 2100, 12);
INSERT INTO Employees (EmployeeID,FirstName,LastName,Department,BirthDate,Gender,Salary,ManagerID) VALUES (15, 'Nina', 'Stone', 'Sales', '1998-08-03', 'Female', 2000, 12);

-- Orders reference records
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (201, 101, 1, 11, '2026-10-04', '2026-10-06', 'Delivered', '10 Nizami St, Baku', '10 Nizami St, Baku', 2, 110.0, '2026-10-04 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (202, 103, 3, 12, '2026-10-08', '2026-10-18', 'Shipped', '22 Oak St, Berlin', '22 Oak St, Berlin', 1, 850.0, '2026-10-08 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (203, 102, 2, 11, '2026-10-12', NULL, 'Pending', NULL, '45 Main St, New York', 1, 230.0, '2026-10-12 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (204, 105, 5, 12, '2026-10-15', '2026-10-19', 'Delivered', '16 Park Rd, Munich', '16 Park Rd, Munich', 1, 420.0, '2026-10-15 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (205, 103, 3, 12, '2026-10-20', '2026-10-22', 'Delivered', '22 Oak St, Berlin', '22 Oak St, Berlin', 8, 6800.0, '2026-10-20 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (206, 105, 2, 11, '2026-10-21', '2026-10-23', 'Delivered', '45 Main St, New York', '9 Pine St, Boston', 3, 1260.0, '2026-10-21 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (207, 102, 6, 14, '2026-10-22', '2026-10-24', 'Delivered', '31 Oak St, Boston', '31 Oak St, Boston', 4, 920.0, '2026-10-22 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (208, 101, 4, 11, '2026-10-23', NULL, 'Pending', NULL, '8 Rue Lyon, Paris', 2, 110.0, '2026-10-23 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (209, 106, 1, 14, '2026-10-24', '2026-10-27', 'Delivered', '10 Nizami St, Baku', '10 Nizami St, Baku', 2, 760.0, '2026-10-24 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (210, 103, 6, 14, '2026-10-25', NULL, 'Cancelled', '31 Oak St, Boston', '31 Oak St, Boston', 2, 1700.0, '2026-10-25 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (211, 104, 5, 11, '2026-10-26', '2026-10-28', 'Delivered', '16 Park Rd, Munich', '16 Park Rd, Munich', 10, 120.0, '2026-10-26 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (212, 105, 3, 12, '2026-10-27', NULL, 'Pending', NULL, '22 Oak St, Berlin', 2, 840.0, '2026-10-27 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (213, 107, 2, 11, '2026-10-28', '2026-10-30', 'Shipped', '45 Main St, New York', '45 Main St, New York', 3, 135.0, '2026-10-28 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (214, 103, 8, 14, '2026-10-29', '2026-11-01', 'Delivered', '18 Via Roma, Milan', '18 Via Roma, Milan', 1, 850.0, '2026-10-29 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (215, 106, 5, 12, '2026-10-30', NULL, 'Pending', '16 Park Rd, Munich', '16 Park Rd, Munich', 1, 380.0, '2026-10-30 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (216, 101, 1, 11, '2026-11-02', '2026-11-04', 'Delivered', '10 Nizami St, Baku', '10 Nizami St, Baku', 1, 55.0, '2026-11-02 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (217, 102, 7, 14, '2026-11-03', '2026-11-05', 'Shipped', '9 River St, Berlin', '9 River St, Berlin', 1, 230.0, '2026-11-03 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (218, 105, 6, 14, '2026-11-04', NULL, 'Pending', '31 Oak St, Boston', NULL, 1, 420.0, '2026-11-04 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (219, 103, 3, 12, '2026-11-05', '2026-11-06', 'Shipped', '22 Oak St, Berlin', '22 Oak St, Berlin', 1, 850.0, '2026-11-05 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (220, 104, 2, 11, '2026-11-06', '2026-11-07', 'Delivered', '45 Main St, New York', '45 Main St, New York', 5, 60.0, '2026-11-06 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (221, 107, 6, 14, '2026-10-28', NULL, 'Shipped', '31 Oak St, Boston', '31 Oak St, Boston', 1, 45.0, '2026-10-28 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (222, 102, 4, 11, '2026-10-31', '2026-10-30', 'Shipped', '8 Rue Lyon, Paris', '8 Rue Lyon, Paris', 1, 230.0, '2026-10-31 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (223, 102, 2, 11, '2026-10-29', '2026-10-31', 'Delivered', '45 Main St, New York', '45 Main St, New York', 1, 230.0, '2026-10-29 10:00:00');
INSERT INTO Orders (OrderID,ProductID,CustomerID,SalesPersonID,OrderDate,ShipDate,OrderStatus,ShipAddress,BillAddress,Quantity,Sales,CreationTime) VALUES (224, 101, 3, 12, '2026-11-02', NULL, 'Pending', '22 Oak St, Berlin', '22 Oak St, Berlin', 2, 110.0, '2026-11-02 10:00:00');

-- Expected counts: Customers=9, Products=8, Employees=5, Orders=24
