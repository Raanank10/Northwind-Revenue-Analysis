SELECT 
    Country,
    DATEPART(yyyy, OrderDate) AS OrderYear,
    DATEPART(qq, OrderDate) AS OrderQuarter,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Quarterly_Revenue
FROM [Northwind].[Orders] o
JOIN [Northwind].[Order Details] od ON o.OrderID = od.OrderID
JOIN [Northwind].[Customers] c ON o.CustomerID = c.CustomerID
GROUP BY Country, DATEPART(yyyy, OrderDate), DATEPART(qq, OrderDate)
ORDER BY Country, OrderYear, OrderQuarter;