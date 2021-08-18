USE AdventureWorks2019
GO
--1:
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
--2:
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
Where ListPrice=0
--3:
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
Where Color IS NULL
--4:
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
Where Color IS NOT NULL
--5:
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
Where Color IS NOT NULL And ListPrice>0
--6:
SELECT Name, Color
FROM Production.Product
Where Color IS NOT NULL
--7:
SELECT Name, Color
FROM Production.Product
Where Color IS NOT NULL
--8:
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID>=400 AND ProductID<=500
--9:
SELECT ProductID, Name, color
FROM Production.Product
WHERE color='black' OR color='blue'
--10:
SELECT Name as products
FROM Production.Product
WHERE Name LIKE 'S%'
--11:
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'S%[a-z] %'
ORDER BY Name 
--12:
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'A%' OR  Name LIKE 'S%'
ORDER BY Name 
--13:///
SELECT Name, ListPrice
FROM Production.Product
WHERE Name Like '[SPO]%'
ORDER BY Name 
--14
SELECT DISTINCT Color
FROM  Production.Product
ORDER BY Color DESC
--15//
SELECT DISTINCT Color, ProductSubcategoryID
FROM  Production.Product 
ORDER BY Color, ProductSubcategoryID
--16:
SELECT ProductSubCategoryID, LEFT([Name],35)AS[Name],Color,ListPrice
FROM Production.Product
WHERE Color NOT IN('Red','Black') OR ListPrice BETWEEN 1000 AND 2000 AND ProductSubCategoryID=1
ORDER BY ProductID

--assignment2 
--1:
SELECT COUNT(Name) AS Products
FROM Production.Product
--2://....
SELECT COUNT(ProductSubcategoryID) AS [Products with subcategory]
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
--3://....
SELECT ProductSubcategoryID, COUNT(Name) AS CountedProducts
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
--4
SELECT COUNT(ProductSubcategoryID) AS Sub, COUNT(Name) AS Products,
(COUNT(Name)-COUNT(ProductSubcategoryID)) AS [Products with no SubCategory]
FROM Production.Product
--5:
SELECT SUM(Quantity) AS [Products Quantity]
FROM Production.ProductInventory
--6:
SELECT ProductID,SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID=40 AND Quantity<100
GROUP BY ProductID
--7:
SELECT Shelf, ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID=40 AND Quantity<100
GROUP BY Shelf, ProductID
--8:
SELECT AVG(Quantity) AS [Average Quantity]
FROM Production.ProductInventory
WHERE LocationID=10
--9:
SELECT ProductID, Shelf, AVG(Quantity)AS AvgPrice
FROM Production.ProductInventory
GROUP BY Shelf,ProductID
--10:
SELECT ProductID, Shelf, AVG(Quantity)AS AvgPrice
FROM Production.ProductInventory
WHERE Shelf IS NOT NULL
GROUP BY Shelf,ProductID
--11:
SELECT Color, Class, COUNT(Name),AVG(ListPrice)AS AvgPrice
FROM Production.Product
GROUP BY Color, Class
--12:
SELECT p2.Name AS Country, p1.Name AS Province
FROM Person.StateProvince p1 JOIN Person.CountryRegion p2 ON p1.CountryRegionCode=p2.CountryRegionCode
--13
SELECT p2.Name AS Country, p1.Name AS Province
FROM Person.StateProvince p1 JOIN Person.CountryRegion p2 ON p1.CountryRegionCode=p2.CountryRegionCode
WHERE p2.Name='Germany' OR  p2.Name='Canada'


USE Northwind
GO
--14:
SELECT ProductName, UnitsOnOrder, OrderDate
FROM Products JOIN [Order Details] od ON od.ProductID=Products.ProductID
JOIN Orders ON od.OrderID=Orders.OrderID
WHERE UnitsOnOrder>=1 AND OrderDate>1994
--15:////
SELECT DISTINCT TOP 5 ShipPostalCode AS Zip, UnitsOnOrder, ShipPostalCode
FROM Products JOIN [Order Details] od ON od.ProductID=Products.ProductID
JOIN Orders ON od.OrderID=Orders.OrderID
WHERE ShipPostalCode IS NOT NULL 
--16:///
SELECT ProductName, UnitsOnOrder, OrderDate
FROM Products JOIN [Order Details] od ON od.ProductID=Products.ProductID
JOIN Orders ON od.OrderID=Orders.OrderID
WHERE UnitsOnOrder>=1 AND OrderDate>1994
--17
SELECT City, COUNT(CustomerID)
FROM Customers
GROUP BY City
--18
SELECT City, COUNT(CustomerID) AS [Number Of Customer]
FROM Customers
GROUP BY City
HAVING  COUNT(CustomerID)>2
--19///
SELECT ContactName, OrderDate
FROM Customers JOIN Orders ON Orders.CustomerID=Customers.CustomerID
GROUP BY OrderDate,ContactName
HAVING OrderDate >='1998'
--20:
SELECT ContactName, OrderDate
FROM Customers JOIN Orders ON Orders.CustomerID=Customers.CustomerID
GROUP BY OrderDate,ContactName
HAVING OrderDate >'1998-05-05'
--21:///...
SELECT ContactName,Quantity
FROM Products JOIN [Order Details] od ON od.ProductID=Products.ProductID
JOIN Orders ON od.OrderID=Orders.OrderID
JOIN Customers ON Orders.CustomerID=Customers.CustomerID
WHERE Quantity>0
--22:
SELECT ContactName,Quantity
FROM Products JOIN [Order Details] od ON od.ProductID=Products.ProductID
JOIN Orders ON od.OrderID=Orders.OrderID
JOIN Customers ON Orders.CustomerID=Customers.CustomerID
WHERE Quantity>100
--23://..
SELECT CompanyName AS [Supplier Company Name], ContactName
FROM SUppliers
GROUP BY CompanyName,ContactName
--24:
SELECT ProductName, OrderDate
FROM Products JOIN [Order Details] od ON od.ProductID=Products.ProductID
JOIN Orders ON od.OrderID=Orders.OrderID
GROUP BY ProductName,OrderDate
--25
SELECT Title, LastName, FirstName
FROM Employees
WHERE Title LIKE  '%, %'
--26///
SELECT Title, LastName, FirstName, ReportsTo,SUM(ReportsTo)
FROM Employees
GROUP BY Title, LastName, FirstName, ReportsTo
HAVING SUM(ReportsTo)>2
--27:
SELECT Customers.City,Customers.ContactName AS Name,s.ContactName,s.SupplierID,s.CompanyName AS[Type of Supplier]
FROM Orders JOIN [Order Details] od ON od.OrderID=Orders.OrderID
JOIN Products ON od.ProductID=od.ProductID
JOIN Customers ON Orders.CustomerID=Customers.CustomerID
JOIN Suppliers s ON s.SupplierID=Products.SupplierID
--28:
--SELECT FROM table1.F1,table1.F2
--FROM table1 INNER JOIN Table2 ON table1.F1=table2.T1
--29:
--SELECT FROM table1.F1,table1.F2
--FROM table1 LEFT JOIN Table2 ON table1.F1=table2.T1





