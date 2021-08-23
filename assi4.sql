Use Northwind
Go
--1:a
BEGIN TRAN
select * from Region
select * from Territories
select * from Employees
select * from EmployeeTerritories
INSERT INTO Region VALUES(6,'Middel Earth')
IF @@ERROR <>0
ROLLBACK

--b
INSERT INTO Territories VALUES(98105,'Gondor',6)
DECLARE @error INT  = @@ERROR 
IF @error <>0
BEGIN
PRINT @error
ROLLBACK
END

--c
INSERT INTO Employees VALUES('Aragorn',	'King'	,'Sales Representative',	'Ms.'	,'1966-01-27 00:00:00.000','1994-11-15 00:00:00.000', 'Houndstooth Rd.',	'London',	NULL	,'WG2 7LT',	'UK',	'(71) 555-4444'	,452,NULL,	'Anne has a BA degree in English from St. Lawrence College.  She is fluent in French and German.',	5,	'http://accweb/emmployees/davolio.bmp/')
INSERT INTO EmployeeTerritories VALUES(@@IDENTITY,98105)
DECLARE @error2 INT  = @@ERROR 
IF @error2 <>0
BEGIN
PRINT @error2
ROLLBACK
END


--2:
UPDATE Territories
SET TerritoryDescription = 'Arnor'
WHERE TerritoryDescription = 'Gondor'
IF @@ERROR<>0
ROLLBACK

--3:
DELETE FROM EmployeeTerritories 
WHERE TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription = 'Arnor')
DELETE FROM Territories
WHERE TerritoryDescription = 'Arnor'
DELETE FROM Region
WHERE RegionDescription = 'Middel Earth'
IF @@ERROR <>0
ROLLBACK
ELSE BEGIN
COMMIT
END

--4:
CREATE VIEW View_Product_Order_Gaddam
AS
SELECT ProductName,SUM(Quantity) As TotalOrderQty FROM [Order Details] OD JOIN Products P ON P.ProductID = OD.ProductID
GROUP BY ProductName
--5
ALTER PROC sp_Product_Order_Quantity_Gaddam
@ProductID INT,
@TotalOrderQty INT OUT
AS
BEGIN
SELECT @TotalOrderQty = SUM(Quantity)  FROM [Order Details] OD JOIN Products P ON P.ProductID = OD.ProductID
WHERE P.ProductID = @ProductID
GROUP BY ProductName
END
DECLARE @Tot INT
EXEC sp_Product_Order_Quantity_Gaddam 11,@Tot OUT
PRINT @Tot 
--6
ALTER PROC sp_Product_Order_City_Gaddam
@ProductName NVARCHAR(50)
AS
BEGIN
SELECT TOP 5 ShipCity,SUM(Quantity) FROM [Order Details] OD JOIN Products P ON P.ProductID = OD.ProductID JOIN Orders O ON O.OrderID = OD.OrderID
WHERE ProductName=@ProductName
GROUP BY ProductName,ShipCity
ORDER BY SUM(Quantity) DESC
END
EXEC sp_Product_Order_City_Gaddam 'Queso Cabrales'

--7
BEGIN TRAN
select * from Region
select * from Territories
select * from Employees
select * from EmployeeTerritories
GO
ALTER PROC sp_move_employees_gaddam
AS
BEGIN

IF EXISTS(SELECT EmployeeID FROM EmployeeTerritories WHERE TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription ='Troy'))
BEGIN
DECLARE @TerritotyID INT
SELECT @TerritotyID = MAX(TerritoryID) FROM Territories
BEGIN TRAN
INSERT INTO Territories VALUES(@TerritotyID+1 ,'Stevens Point',3)
UPDATE EmployeeTerritories
SET TerritoryID = @TerritotyID+1
WHERE EmployeeID IN (SELECT EmployeeID FROM EmployeeTerritories WHERE TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription ='Troy'))
IF @@ERROR <> 0
BEGIN
ROLLBACK
END
ELSE
COMMIT
END
EXEC sp_move_employees_gaddam
--8
CREATE TRIGGER tr_move_emp_gaddam
ON EmployeeTerritories
AFTER INSERT
AS
DECLARE @EmpCount INT
SELECT @EmpCount = COUNT(*) FROM EmployeeTerritories WHERE TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription = 'Stevens Point' AND RegionID=3) GROUP BY EmployeeID
IF (@EmpCount>100)
BEGIN
UPDATE EmployeeTerritories
SET TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription ='Troy')
WHERE EmployeeID IN (SELECT EmployeeID FROM EmployeeTerritories WHERE TerritoryID = (SELECT TerritoryID FROM Territories WHERE TerritoryDescription ='Stevens Point' AND RegionID=3))
END
DROP TRIGGER tr_move_emp_gaddam
COMMIT

--9
CREATE TABLE People_Gaddam
(
id int ,
name nvarchar(100),
city int
)
CREATE table City_Gaddam
(
id int,
city nvarchar(100)
)
BEGIN TRAN 
INSERT into City_Gaddam values(1,'Seattle')
INSERT into City_Gaddam values(2,'Green Bay')

INSERT into People_Gaddam values(1,'Aaron Rodgers',1)
INSERT into People_Gaddam values(2,'Russell Wilson',2)
INSERT into People_Gaddam values(3,'Jody Nelson',2)

if exists(select id FROM People_Gaddam where city = (select id FROM City_Gaddam where city = 'Seatle'))
begin
INSERT into City_Gaddam values(3,'Madison')
update People_Gaddam
set city = 'Madison'
where id in (select id FROM People_Gaddam where city = (select id FROM City_Gaddam where city = 'Seatle'))
end
delete FROM City_Gaddam where city = 'Seattle'

CREATE VIEW Packers_Gaddam
AS
SELECT name FROM People_Gaddam WHERE city = 'Green Bay'
select * FROM Packers_Gaddam
commit
DROP TABLE People_Gaddam
DROP TABLE City_Gaddam
DROP view Packers_Gaddam
-- 10
ALTER PROC sp_birthday_employee_gaddam
AS
BEGIN
SELECT * INTO #EmployeeTemp
FROM Employees WHERE DATEPART(MM,BirthDate) = 02
SELECT * FROM #EmployeeTemp
END
--11
CREATE PROC sp_gaddam_1
AS
BEGIN
SELECT City FROM CUSTOMERS
GROUP BY City
HAVING COUNT(*)>2
INTERSECT
SELECT City FROM Customers C JOIN Orders O ON O.CustomerID=C.CustomerID JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY OD.ProductID,C.CustomerID,City
HAVING COUNT(*) BETWEEN 0 AND 1
END
GO
EXEC sp_gaddam_1
GO
CREATE PROC sp_gaddam_2
AS
BEGIN
SELECT City FROM CUSTOMERS
WHERE CITY IN (SELECT City FROM Customers C JOIN Orders O ON O.CustomerID=C.CustomerID JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY OD.ProductID,C.CustomerID,City
HAVING COUNT(*) BETWEEN 0 AND 1)
GROUP BY City
HAVING COUNT(*)>2
END
GO
EXEC sp_gaddam_2
GO
--12 USE EXCEPT KEYWORD
SELECT * FROM Customers
EXCEPT
SELECT * FROM Customers

--14 
--SELECT firstName+' '+lastName FROM Person where middleName is null UNION SELECT firstName+' '+lastName+' '+middelName+'.' FROM Person where middleName is not null

--15 
--SELECT top 1 marks FROM student where sex = 'F' order by marks desc

--16 
--SELECT * FROM students order by sex,marks