    SELECT 
        c.CustomerID, c.CompanyName, c.Country, c.City,
        -- Count of unique orders to see loyalty
        COUNT(DISTINCT o.OrderID) AS Order_Frequency,
        -- Total Net Revenue (LTV)
        ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS Lifetime_Value,
        -- Average Discount given to this customer
        ROUND(AVG(od.Discount) * 100, 2) AS Avg_Customer_Discount
    FROM [Northwind].[Customers] c
    JOIN [Northwind].[Orders] o ON c.CustomerID = o.CustomerID
    JOIN [Northwind].[Order Details] od ON o.OrderID = od.OrderID
    GROUP BY c.CustomerID, c.CompanyName, c.Country, c.City
    ORDER BY Lifetime_Value DESC;