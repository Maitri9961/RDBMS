SELECT ProductID, Name, Color, ListPrice FROM Production.Product;

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE ListPrice <> 0;

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NULL;

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL;

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL AND ListPrice > 0;

SELECT CONCAT(Name, ':', Color) AS ProductDescription
FROM Production.Product
WHERE Color IS NOT NULL;

SELECT CONCAT('NAME: ', Name, '  --  COLOR: ', Color) AS ProductDetails
FROM Production.Product
WHERE (Name IN ('LL Crankarm', 'ML Crankarm', 'HL Crankarm', 
                'Chainring Bolts', 'Chainring Nut', 'Chainring'))
  AND Color IS NOT NULL;

SELECT ProductID, Name
FROM Production.Product
WHERE ProductID BETWEEN 400 AND 500;

SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IN ('Black', 'Blue');

SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Name LIKE 'S%';

SELECT Name, ListPrice
FROM Production.Product
ORDER BY Name;


SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'A%' OR Name LIKE 'S%'
ORDER BY Name;


SELECT Name
FROM Production.Product
WHERE Name LIKE 'SPO%' AND Name NOT LIKE 'SPOK%'
ORDER BY Name;


SELECT DISTINCT Color
FROM Production.Product
WHERE Color IS NOT NULL
ORDER BY Color DESC;