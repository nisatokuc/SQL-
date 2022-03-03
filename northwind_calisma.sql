use Northwind;

/*Countsuz 1*/
SELECT Customers.ContactName , Orders.CustomerID
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerID;


/*1-Müşterilerin sipariş sayıları, en çoktan en aza sıralı*/
SELECT COUNT(*) sayi, Customers.ContactName , Orders.CustomerID
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Orders.CustomerID,Customers.ContactName
ORDER BY COUNT(*) DESC;



/*2) Her bir kategorideki ürün sayısı*/
SELECT COUNT(*) sayi, Categories.CategoryName 
FROM Categories
INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryName;



/*3) Her bir kategoride sipariş edilen toplam ürün adedi
Total number of products ordered in each category*/
SELECT SUM(Quantity) urun_adedi, Categories.CategoryName, Products.CategoryID
FROM ((Categories
INNER JOIN Products ON Products.CategoryID = Categories.CategoryID)
INNER JOIN [Order Details] ON [Order Details].ProductID = Products.ProductID)
GROUP BY Categories.CategoryName , Products.CategoryID
ORDER BY SUM(Quantity);



/*4) 10 dan fazla siparişi olan müşterilerin sayısı, en çoktan en aza sıralı*/
SELECT COUNT(*) sayi, Orders.CustomerID , Customers.ContactName
FROM Customers
INNER JOIN Orders ON Orders.CustomerID = Customers.CustomerID
GROUP BY Orders.CustomerID , Customers.ContactName
HAVING COUNT(*) > 10
ORDER BY COUNT(*) DESC;


/*10000 TL tutarından fazla alışveriş yapan müşteriler, en yüksek tutardan en aza sıralı*/
SELECT SUM(([Order Details].UnitPrice*[Order Details].Quantity)-
(([Order Details].UnitPrice*[Order Details].Quantity)*[Order Details].Discount)) OrderAmount,
Customers.ContactName , Orders.CustomerID
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
GROUP BY Customers.ContactName , Orders.CustomerID
HAVING SUM(([Order Details].UnitPrice*[Order Details].Quantity)-
(([Order Details].UnitPrice*[Order Details].Quantity)*[Order Details].Discount)) > 10000
ORDER BY OrderAmount DESC;



/*6) Her çalışanın satmış olduğu ürünlerin toplam tutarları çoktan aza sıralı*/
SELECT Employees.EmployeeID , Employees.FirstName , Employees.LastName ,
SUM(([Order Details].UnitPrice*[Order Details].Quantity)-(([Order Details].UnitPrice*[Order Details].Quantity)*[Order Details].Discount)) OrderAmount
FROM Orders
INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.EmployeeID , Employees.FirstName , Employees.LastName
ORDER BY OrderAmount DESC;

SELECT ROUND(SUM((od.UnitPrice*od.Quantity)-((od.UnitPrice*od.Quantity)*od.Discount)),2) OrderAmount,
c.ContactName , o.CustomerID
FROM [Orders] o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY c.ContactName , o.CustomerID
HAVING SUM((od.UnitPrice*od.Quantity)-((od.UnitPrice*od.Quantity)*od.Discount)) > 10000
ORDER BY OrderAmount DESC;

SELECT SUM(Quantity) urun_adedi, Categories.CategoryName, Products.CategoryID
FROM 
Categories
INNER JOIN Products ON Products.CategoryID = Categories.CategoryID
INNER JOIN [Order Details] ON [Order Details].ProductID = Products.ProductID
GROUP BY Categories.CategoryName , Products.CategoryID
ORDER BY SUM(Quantity);

SELECT SUM(Quantity) urun_adedi, Categories.CategoryName, Products.CategoryID
FROM ((Categories
INNER JOIN Products ON Products.CategoryID = Categories.CategoryID)
INNER JOIN [Order Details] ON [Order Details].ProductID = Products.ProductID)
GROUP BY Categories.CategoryName , Products.CategoryID
ORDER BY 1;

SELECT SUM(([Order Details].UnitPrice*[Order Details].Quantity)-(([Order Details].UnitPrice*[Order Details].Quantity)*[Order Details].Discount)) OrderAmount,
Customers.ContactName , Orders.CustomerID
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
GROUP BY Customers.ContactName , Orders.CustomerID
HAVING SUM(([Order Details].UnitPrice*[Order Details].Quantity)-(([Order Details].UnitPrice*[Order Details].Quantity)*[Order Details].Discount)) > 10000
ORDER BY 1 DESC;
