SELECT c.CategoryName,
    -- Total value if everything was sold at full price
    ROUND(SUM(od.UnitPrice * od.Quantity), 2) AS Potential_Revenue,
    -- The actual money lost to discounts
    ROUND(SUM(od.UnitPrice * od.Quantity * od.Discount), 2) AS Total_Discount_Value, 
    -- The actual money that hit the bank
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS Actual_Revenue, 
    -- Estimated Profit (Actual Revenue minus Wholesale Cost)
    ROUND(SUM((od.UnitPrice * od.Quantity * (1 - od.Discount)) - (p.UnitPrice * od.Quantity)), 2) AS Estimated_Gross_Profit, 
    -- Average Discount Rate per Category
    ROUND(AVG(od.Discount) * 100, 2) AS Avg_Discount_Percent
FROM [Northwind].[Categories] c
JOIN [Northwind].[Products] p ON c.CategoryID = p.CategoryID
JOIN [Northwind].[Order Details] od ON p.ProductID = od.ProductID
GROUP BY c.CategoryName
ORDER BY Estimated_Gross_Profit DESC;