/*
  Shipper Lead Time - carrier-level fulfillment summary (order grain)

  Answers: which carrier moves the most revenue, how fast, and how often is it late?
  "Late" = more than 10 days from order to shipment.
*/
WITH order_totals AS (
    SELECT
        o.OrderID,
        o.ShipVia,
        DATEDIFF(day, o.OrderDate, o.ShippedDate)            AS Days_to_Ship,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))  AS Order_Revenue
    FROM [Northwind].[Orders] o
    JOIN [Northwind].[Order Details] od ON o.OrderID = od.OrderID
    WHERE o.ShippedDate IS NOT NULL
    GROUP BY o.OrderID, o.ShipVia, o.OrderDate, o.ShippedDate
)
SELECT
    s.CompanyName                                                        AS Shipper_Name,
    COUNT(*)                                                             AS Shipped_Orders,
    ROUND(AVG(CAST(ot.Days_to_Ship AS FLOAT)), 2)                        AS Avg_Days_to_Ship,
    ROUND(100.0 * SUM(CASE WHEN ot.Days_to_Ship > 10 THEN 1 ELSE 0 END)
          / COUNT(*), 1)                                                 AS Pct_Orders_Over_10_Days,
    ROUND(SUM(ot.Order_Revenue), 2)                                      AS Total_Revenue,
    ROUND(AVG(ot.Order_Revenue), 2)                                      AS Avg_Order_Value
FROM order_totals ot
JOIN [Northwind].[Shippers] s ON ot.ShipVia = s.ShipperID
GROUP BY s.CompanyName
ORDER BY Avg_Days_to_Ship DESC;
