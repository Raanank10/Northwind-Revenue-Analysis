/*
  Cost assumption: Northwind has no supplier-cost column. Per the project brief,
  [Products].UnitPrice is used as a PROXY for wholesale cost and [Order Details].UnitPrice
  as the selling price. "Gross profit" below is therefore an estimate, valid only for
  comparing categories/products with each other, not as an absolute margin.
*/
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