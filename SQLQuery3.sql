SELECT DISTINCT city 
FROM dbo.Customers
WHERE city IN (SELECT city FROM dbo.Employees); 

SELECT DISTINCT city 
FROM dbo.Customers
WHERE city NOT IN (SELECT city FROM dbo.Employees); 

SELECT DISTINCT c.City
FROM Customers c
LEFT JOIN Employees e
  ON c.City = e.City
WHERE e.City IS NULL;

SELECT p.ProductName,SUM(od.Quantity) AS TotalQuantity
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantity DESC;

SELECT c.City , SUM(od.Quantity) AS totalProductOrdered 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = o.OrderID
GROUP BY c.City

SELECT CITY 
FROM Customers 
GROUP BY City 
HAVING COUNT(*) >=2;

SELECT c.City, COUNT(DISTINCT od.ProductID) AS NumberOfDifferentProducts
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(DISTINCT od.ProductID) >= 2

SELECT DISTINCT c.CustomerID, c.CompanyName,c.City AS CustomerCity,o.ShipCity
FROM Customers c
JOIN Orders o 
ON c.CustomerID = o.CustomerID
WHERE c.City <> o.ShipCity
ORDER BY c.CustomerID;

SELECT TOP 5 
    p.ProductName,
    AVG(od.UnitPrice) AS AvgPrice,
    c.City AS TopCity,
    SUM(od.Quantity) AS TotalQty
FROM 
    [Order Details] od
JOIN Orders o ON o.OrderID = od.OrderID
JOIN Customers c ON c.CustomerID = o.CustomerID
JOIN Products p ON p.ProductID = od.ProductID
GROUP BY 
    p.ProductName, c.City
ORDER BY 
    SUM(od.Quantity) DESC;


SELECT DISTINCT e.City
FROM Employees e
WHERE e.City NOT IN (
    SELECT DISTINCT c.City
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
);


SELECT DISTINCT e.City
FROM Employees e
LEFT JOIN Customers c ON e.City = c.City
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

SELECT e.City
FROM Employees e
JOIN (
    -- Subquery 1: City of employee with the most orders sold
    SELECT TOP 1 e2.City AS EmpCity, COUNT(o2.OrderID) AS TotalOrders
    FROM Employees e2
    JOIN Orders o2 ON e2.EmployeeID = o2.EmployeeID
    GROUP BY e2.City
    ORDER BY COUNT(o2.OrderID) DESC
) AS EmpTop ON e.City = EmpTop.EmpCity
JOIN (
    -- Subquery 2: City of customer with the most total quantity ordered
    SELECT TOP 1 c2.City AS CustCity, SUM(od2.Quantity) AS TotalQty
    FROM Customers c2
    JOIN Orders o2 ON c2.CustomerID = o2.CustomerID
    JOIN [Order Details] od2 ON o2.OrderID = od2.OrderID
    GROUP BY c2.City
    ORDER BY SUM(od2.Quantity) DESC
) AS CustTop ON e.City = CustTop.CustCity;


--This SQL script removes duplicates by first creating a temporary table with only unique rows using `SELECT DISTINCT * INTO TempTable FROM YourTable;`. It then deletes the original table with `DROP TABLE YourTable;` and recreates it from the temporary one using `SELECT * INTO YourTable FROM TempTable;`. Finally, the duplicates are gone, and only unique records remain.
