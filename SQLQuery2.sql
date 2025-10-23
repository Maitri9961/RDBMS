SELECT Count(*) AS totalProduct
FROM Production.Product;

SELECT COUNT(*) AS ProductsWithSubcategory
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL;

SELECT ProductSubcategoryID, COUNT(ProductSubcategoryID) AS CountedProducts
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID;

SELECT COUNT(*) 
FROM Production.Product
WHERE ProductSubcategoryID IS NULL;

SELECT SUM(Quantity) AS totalQuantity
FROM Production.ProductInventory;

SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID
HAVING SUM(Quantity) < 100;

SELECT Shelf,ProductID,SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY Shelf, ProductID
HAVING SUM(Quantity) < 100;

SELECT AVG(Quantity) AS avgQuantity
FROM Production.ProductInventory
WHERE LocationID=10;

SELECT ProductID,Shelf,AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
GROUP BY ProductID,Shelf;

SELECT ProductID,Shelf,AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
WHERE Shelf <> 'N/A'
GROUP BY ProductID,Shelf;

SELECT Color, Class, COUNT(*) AS TheCount, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class;

SELECT c.Name AS Country, s.Name AS Province
FROM Person.CountryRegion AS c
JOIN Person.StateProvince AS s
ON c.CountryRegionCode = s.CountryRegionCode;

SELECT c.Name AS Country, s.Name AS Province
FROM Person.CountryRegion AS c
JOIN Person.StateProvince AS s
ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.Name IN ('Germany', 'Canada');



SELECT DISTINCT p.ProductID, p.ProductName
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= DATEADD(YEAR, -27, GETDATE());


SELECT TOP 5 c.PostalCode, COUNT(o.OrderID) AS TotalOrders
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.PostalCode
ORDER BY TotalOrders DESC;

SELECT TOP 5 c.PostalCode, COUNT(o.OrderID) AS TotalOrders
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate >= DATEADD(YEAR, -27, GETDATE())
GROUP BY c.PostalCode
ORDER BY TotalOrders DESC;

SELECT City, COUNT(CustomerID) AS NumberOfCustomers
FROM Customers
GROUP BY City;

SELECT City, COUNT(CustomerID) AS NumberOfCustomers
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) > 2;

SELECT  c.ContactName,  o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate > '1998-01-01';

SELECT c.ContactName, MAX(o.OrderDate) AS MostRecentOrder
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName;

SELECT c.ContactName, COUNT(od.ProductID) AS ProductCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.ContactName;

SELECT c.CustomerID, COUNT(od.ProductID) AS TotalProducts
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID
HAVING COUNT(od.ProductID) > 100;

SELECT s.CompanyName AS [Supplier Company Name],sh.CompanyName AS [Shipping Company Name]
FROM Suppliers s
CROSS JOIN Shippers sh
ORDER BY s.CompanyName, sh.CompanyName;

SELECT o.OrderDate, p.ProductName
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
ORDER BY o.OrderDate;

SELECT e1.FirstName + ' ' + e1.LastName AS Employee1, e2.FirstName + ' ' + e2.LastName AS Employee2,e1.Title
FROM Employees e1
JOIN Employees e2 ON e1.Title = e2.Title AND e1.EmployeeID < e2.EmployeeID
ORDER BY e1.Title;

SELECT m.EmployeeID,m.FirstName + ' ' + m.LastName AS ManagerName,COUNT(e.EmployeeID) AS ReportCount
FROM Employees m
JOIN Employees e ON m.EmployeeID = e.ReportsTo
GROUP BY m.EmployeeID, m.FirstName, m.LastName
HAVING COUNT(e.EmployeeID) > 2;

SELECT City, CompanyName AS Name, ContactName, 'Customer' AS Type
FROM Customers
UNION
SELECT City, CompanyName AS Name, ContactName, 'Supplier' AS Type
FROM Suppliers
ORDER BY City, Type;
