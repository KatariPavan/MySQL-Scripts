CREATE DATABASE Blinkit_SQL_Assignment;
USE Blinkit_SQL_Assignment

CREATE TABLE Orders(
  OrderID INT ,
  CustomerID INT,
  StoreID INT,
  OrderDate DATETIME,
  DeliveryTime INT,
  TotalAmount INT,
  Status VARCHAR(10),
  PRIMARY KEY (OrderID)
);

INSERT INTO Orders VALUES(101,1001,201,'2024-01-15 08:30:00',30,150,'Completed'),
(102,1002,202,'2024-01-15 09:00:00',45,230,'Completed'),
(103,1003,201,'2024-01-15 09:15:00',60,500,'Completed'),
(104,1001,201,'2024-01-15 10:00:00',20,100,'Completed'),
(105,1004,203,'2024-01-15 11:00:00',35,200,'Completed');

select * FROM Orders;
 
CREATE TABLE Customers (
  CustomerID INT ,
  Name VARCHAR(50),
  City VARCHAR(50),
  SignUpDate DATE,
  TotalOrders INT,
  LastOrderDate DATE,
  PRIMARY KEY (CustomerID)
);

INSERT INTO customers VALUES
(1001,'John Doe','Mumbai','2023-12-01',10,'2024-01-15'),
(1002,'Alice Johnson','Bangalore','2024-01-02',3,'2024-01-15'),
(1003,'Bob Smith','Pune','2023-11-25',2,'2024-01-15'),
(1004,'Charlie Brown','Delhi','2023-10-10',1,'2024-01-15'),
(1005,'Eve Miller','Mumbai','2023-12-20',5,'2024-01-10');

SELECT * FROM CUSTOMERS;

CREATE TABLE Stores (
  StoreID INT ,
  City VARCHAR(50),
  Area VARCHAR(50),
  Category VARCHAR(50),
  PRIMARY KEY(StoreID)
);

INSERT INTO Stores VALUES
(201,'Mumbai','Andheri','Groceries'),
(202,'Bangalore','Koramangala', 'Groceries'),
(203,'Delhi','CP','Essential'),
(204,'Pune','Baner','Groceries'),
(205,'Mumbai','Borivali','Essential');

SELECT * FROM Stores;

CREATE TABLE Products (
  ProductID INT ,
  ProductName VARCHAR(50),
  Category VARCHAR(50),
  Price DECIMAL(10, 2),
  PRIMARY KEY(ProductID)
);

INSERT INTO Products VALUES
(301,'Milk','Dairy',50),
(302,'Bread','Bakery',30),
(303,'Apples','Fruits',100),
(304,'Toothpaste','Personal Care',75),
(305,'Rice','Grains',120);

SELECT * FROM Products;

CREATE TABLE OrderDetails (
  OrderID INT,
  ProductID INT,
  Quantity INT,
  FOREIGN KEY (OrderID) REFERENCES orders(OrderID),
  FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);

INSERT INTO OrderDetails VALUES
  (101,301,2),
  (101,302,1),
  (101,303,1),
  (102,304,3),
  (104,305,1),
  (101,301,4),
  (105,303,2);
  
  SELECT * FROM OrderDetails;

CREATE TABLE delivery (
  OrderID INT,
  DeliveryPersonID INT,
  DeliveryStartTime DATETIME,
  DeliveryEndTime DATETIME,
  DistanceCovered INT,
  FOREIGN KEY (OrderID) REFERENCES orders(OrderID)
);

INSERT INTO Delivery VALUES
  (101,501,'2024-01-15 08:45:00','2024-01-15 09:15:00',5),
  (102,502,'2024-01-15 09:10:00','2024-01-15 09:55:00',8),
  (104,503,'2024-01-15 10:05:00','2024-01-15 10:25:00',3),
  (105,504,'2024-01-15 11:10:00','2024-01-15 11:45:00',7);
  
  SELECT * FROM Delivery;

## A1 Calculate the AVG. delivery time for all orders in each city 

SELECT c.City, ROUND(AVG(o.DeliveryTime)) AS Avg_Delivery_Time_In_Min FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID GROUP BY c.City;  

## A2 Finding top 3 customers based on order value they placed

SELECT c.CustomerID, c.Name, SUM(o.TotalAmount) AS TotalOrderValue FROM orders o
RIGHT JOIN customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID ORDER BY TotalOrderValue DESC LIMIT 3;

## A3 The top 3 most frequently ordered products in Mumbai 

SELECT p.ProductName, COUNT(*) AS OrderCount FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.City = 'Mumbai' GROUP BY p.ProductName ORDER BY OrderCount DESC LIMIT 3;

## A4 Identifying Number of customers who have not placed an order in last 30 days

SELECT COUNT(*) AS InactiveCustomers FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL AND o.OrderDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);
  
## B1 Calculating Total revenue generated from each store

SELECT s.StoreID, s.City, SUM(o.TotalAmount) AS TotalRevenue FROM orders o
JOIN stores s ON o.StoreID = s.StoreID GROUP BY s.StoreID;

## B2 Identifying customers who placed only one order in last 3 months

SELECT c.City, COUNT(*) AS TotalCustomers,COUNT(CASE WHEN o.OrderID IS NULL THEN 1 ELSE NULL END) AS SingleOrders
FROM customers c LEFT JOIN orders o ON c.CustomerID = o.CustomerID GROUP BY c.City;

## B3 Cities with high percentage of single order customers
 SELECT c.City, ROUND(COUNT(CASE WHEN o.OrderID IS NULL THEN 1 ELSE NULL END) / COUNT(*),1) AS SingleOrderPercentage
 FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID GROUP BY c.City; 
 
## B4 Relation between the distance covered by delivery agents and the AVG. delivery time 
 
 SELECT Round(AVG(d.DistanceCovered)) AS AvgDistance, ROUND(AVG(o.DeliveryTime)) AS AvgDeliveryTime
 FROM delivery d JOIN orders o ON d.OrderID = o.OrderID GROUP BY d.DeliveryPersonID;