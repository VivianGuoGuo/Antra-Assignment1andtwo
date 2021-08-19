USE Northwind
GO
--1:
SELECT Employees.City
FROM Customers INNER JOIN Employees ON Customers.City=Employees.City

--2:
--a://
SELECT DISTINCT Customers.City
FROM Customers
WHERE  Customers.City IN (SELECT Employees.City 
FROM Employees)
--b://
SELECT  DISTINCT Customers.City
FROM Customers LEFT JOIN Employees ON Customers.City = Employees.City
--3:
SELECT ProductID,SUM(Quantity) AS QunatityOrdered
FROM [order details]
  GROUP BY  ProductID
--4
SELECT c.City, p.UnitsOnOrder
FROM Customers c JOIN Orders o ON  c.CustomerID=o.CustomerID
JOIN [Order Details] od ON  od.OrderID=o.OrderID
JOIN Products p ON  p.ProductID=od.ProductID
WHERE p.UnitsOnOrder!=0
--5://
SELECT City,CustomerID
FROM Customers
UNION ALL
 SELECT ShipCity,CustomerID
 FROM Orders
  GROUP BY ShipCity, CustomerID
 HAVING COUNT(CustomerID)>=2
 --subquery
SELECT CompanyName,COUNT(CustomerID) AS numberCount
FROM Customers
 GROUP BY CompanyName
  --6///
SELECT DISTINCT City 
FROM Orders o 
JOIN [Order Details] od ON o.OrderID=od.OrderID 
JOIN Customers c ON c.CustomerID=o.CustomerID
GROUP BY city,ProductID
HAVING COUNT(*)>=2
 --7:
   SELECT DISTINCT c.CustomerID
   FROM Orders c JOIN [Order Details] od ON od.OrderID=c.OrderID
   JOIN Customers c1 ON c1.CustomerID=c.CustomerID
   WHERE City<>ShipCity
   --8
SELECT TOP 5 ProductID,AVG(UnitPrice) AS AvgPrice,
(SELECT TOP 1 City FROM Customers c join Orders o ON o.CustomerID=c.CustomerID join [Order Details] od2 on od2.OrderID=o.OrderID where od2.ProductID=od1.ProductID group by city order by SUM(Quantity) desc) as City from [Order Details] od1
GROUP BY ProductID 
ORDER BY SUM(Quantity) DESC
--9
--a
SELECT DISTINCT City 
FROM Employees 
WHERE City not in 
(SELECT ShipCity FROM Orders WHERE ShipCity is not null)
--b
SELECT DISTINCT City 
FROM Employees WHERE City is not null except 
(SELECT ShipCity FROM Orders WHERE ShipCity is not null)
 --10
 select (select top 1 City from Orders o join [Order Details] od on o.OrderID=od.OrderID join Employees e on e.EmployeeID = o.EmployeeID
group by e.EmployeeID,e.City
order by COUNT(*) desc) as MostOrderedCity,
(select top 1 City from Orders o join [Order Details] od on o.OrderID=od.OrderID join Employees e on e.EmployeeID = o.EmployeeID
group by e.EmployeeID,e.City
order by sum(Quantity) desc) as MostQunatitySoldCity
 --11:Using DISTINCK key word to remove duplicates
 --12:SELECT empid FROM Employee EXCEPT SELECT mgrid FROM Employee

--13:SELECT deptid 
--FROM employee 
--GROUP BY deptid HAVING count(*) = 
--(SELECT TOP 1 count(*) FROM employee GROUP BY deptid order by COUNT(*) DESC)

--14:SELECT TOP 3 deptname, empid, salary 
--FROM employee e 
--JOIN dep d ON e.deptid=d.deptid order by salary,deptname,empid DESC





