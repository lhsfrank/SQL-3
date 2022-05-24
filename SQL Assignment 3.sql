--1.      Create a view named “view_product_order_[your_last_name]”, list all products and total ordered quantity for that product.
CREATE VIEW view_product_order_Li
AS
SELECT p.ProductName, od.Quantity
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName

SELECT ProductName, SUM(Quantity) AS productQuantity
FROM view_product_order_Li
GROUP BY ProductName
ORDER BY ProductName



--2.      Create a stored procedure “sp_product_order_quantity_[your_last_name]” that accept product id as an input and total quantities of order as output parameter.
CREATE PROC sp_product_order_quantity_Li
@productID int,
@totalQuantity int out
AS
BEGIN
SELECT @totalQuantity = SUM(od.Quantity)
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID
WHERE p.ProductID = @productID
GROUP BY p.ProductName
END

BEGIN
DECLARE @total int
EXEC sp_product_order_quantity_Li 1, @total out
PRINT @total
END

--3.      Create a stored procedure “sp_product_order_city_[your_last_name]” that accept product name as an input and top 5 cities
--that ordered most that product combined with the total quantity of that product ordered from that city as output.
CREATE PROC sp_product_order_city_Li
@productName varchar(20),
@city varchar(20) out,
@quantity int out
AS
BEGIN
SELECT @city = o.ShipCity, @quantity = SUM(od.Quantity)
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID
WHERE p.ProductName = @productName
GROUP BY o.ShipCity
ORDER BY od.Quantity
END

BEGIN
DECLARE @Cityname varchar(20), @Quantiynum int
EXEC sp_product_order_city_Li 'Alice Mutton', @Cityname, @Quantiynum
PRINT @Cityname
--PRINT @Quantitynum
END