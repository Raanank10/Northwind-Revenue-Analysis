SELECT TOP 10
    p.ProductName,
    c.CategoryName,
    SUM(od.Quantity) AS Total_Units_Sold,
    ROUND(SUM((od.UnitPrice * od.Quantity * (1 - od.Discount)) - (p.UnitPrice * od.Quantity)), 2) AS Product_Gross_Profit,
    ROUND(AVG(od.Discount) * 100, 2) AS Avg_Discount
FROM [Northwind].[Products] p
JOIN [Northwind].[Categories] c ON p.CategoryID = c.CategoryID
JOIN [Northwind].[Order Details] od ON p.ProductID = od.ProductID
WHERE c.CategoryName = 'Meat/Poultry' -- Use single quotes for text
GROUP BY p.ProductName, c.CategoryName
ORDER BY Product_Gross_Profit ASC;