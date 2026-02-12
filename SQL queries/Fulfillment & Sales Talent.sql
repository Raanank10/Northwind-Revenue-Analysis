SELECT 
    e.FirstName + ' ' + e.LastName AS Employee_Name, s.CompanyName AS Shipper_Name,
    COUNT(o.OrderID) AS Total_Orders,
    -- Fulfillment Lead Time
    AVG(DATEDIFF(day, o.OrderDate, o.ShippedDate)) AS Avg_Days_to_Ship,
    -- Sales Effectiveness (Average Order Value)
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) / COUNT(DISTINCT o.OrderID), 2) AS Avg_Order_Value,
    -- Total Revenue Contribution
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS Total_Revenue
FROM [Northwind].[Orders] o
JOIN [Northwind].[Employees] e ON o.EmployeeID = e.EmployeeID
JOIN [Northwind].[Shippers] s ON o.ShipVia = s.ShipperID
JOIN [Northwind].[Order Details] od ON o.OrderID = od.OrderID
WHERE o.ShippedDate IS NOT NULL
GROUP BY e.FirstName, e.LastName, s.CompanyName
ORDER BY Avg_Days_to_Ship DESC;