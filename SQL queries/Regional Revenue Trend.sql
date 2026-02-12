SELECT 
    Country,
    -- Creates a string like '1997-Q1'
    CONCAT(CAST(YEAR(OrderDate) AS VARCHAR), '-Q', CAST(DATEPART(qq, OrderDate) AS VARCHAR)) AS Year_Quarter,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Quarterly_Revenue
FROM [Northwind].[Orders] o
JOIN [Northwind].[Order Details] od ON o.OrderID = od.OrderID
JOIN [Northwind].[Customers] c ON o.CustomerID = c.CustomerID
GROUP BY Country, YEAR(OrderDate), DATEPART(qq, OrderDate)
ORDER BY Year_Quarter ASC;