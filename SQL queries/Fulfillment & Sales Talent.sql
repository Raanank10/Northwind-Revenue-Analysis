/*
  Fulfillment & Sales Talent - employee x shipper performance

  Grain fix: the original version joined [Order Details] and then used COUNT(o.OrderID)
  and AVG(DATEDIFF(...)). Because every order has several line items, that counted
  LINE ITEMS as orders (e.g. Laura Callahan: 260 line items vs 104 real orders) and
  weighted lead time by the number of lines per order.

  This version aggregates to one row per order first (CTE), then summarizes, so
  Total_Orders is a true order count and Avg_Days_to_Ship is an order-level average.
*/
WITH order_totals AS (
    SELECT
        o.OrderID,
        o.EmployeeID,
        o.ShipVia,
        DATEDIFF(day, o.OrderDate, o.ShippedDate)                AS Days_to_Ship,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))      AS Order_Revenue
    FROM [Northwind].[Orders] o
    JOIN [Northwind].[Order Details] od ON o.OrderID = od.OrderID
    WHERE o.ShippedDate IS NOT NULL
    GROUP BY o.OrderID, o.EmployeeID, o.ShipVia, o.OrderDate, o.ShippedDate
)
SELECT
    e.FirstName + ' ' + e.LastName                    AS Employee_Name,
    s.CompanyName                                     AS Shipper_Name,
    COUNT(*)                                          AS Total_Orders,
    -- CAST avoids integer averaging in SQL Server
    ROUND(AVG(CAST(ot.Days_to_Ship AS FLOAT)), 2)     AS Avg_Days_to_Ship,
    ROUND(AVG(ot.Order_Revenue), 2)                   AS Avg_Order_Value,
    ROUND(SUM(ot.Order_Revenue), 2)                   AS Total_Revenue
FROM order_totals ot
JOIN [Northwind].[Employees] e ON ot.EmployeeID = e.EmployeeID
JOIN [Northwind].[Shippers]  s ON ot.ShipVia    = s.ShipperID
GROUP BY e.FirstName, e.LastName, s.CompanyName
ORDER BY Avg_Days_to_Ship DESC;
