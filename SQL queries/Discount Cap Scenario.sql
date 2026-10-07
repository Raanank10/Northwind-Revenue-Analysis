/*
  Discount Cap Scenario - what would a 5.5% discount cap on Meat/Poultry recover?

  Northwind discounts are discrete (0%, 5%, 10%, 15%, 20%, 25%). Capping at 5.5% only
  affects lines discounted above 5.5%; each such line gives back (Discount - 0.055).

  Assumption: volume does not change. Customers who lose a discount may buy less, so
  treat the result as an UPPER BOUND on recovered revenue, not a forecast.
*/
DECLARE @Cap DECIMAL(5,3) = 0.055;

SELECT
    c.CategoryName,
    COUNT(*)                                                         AS Lines_Above_Cap,
    ROUND(SUM(od.UnitPrice * od.Quantity * (od.Discount - @Cap)), 2) AS Max_Recovered_Revenue
FROM [Northwind].[Order Details] od
JOIN [Northwind].[Products]   p ON od.ProductID  = p.ProductID
JOIN [Northwind].[Categories] c ON p.CategoryID  = c.CategoryID
WHERE od.Discount > @Cap
  AND c.CategoryName = 'Meat/Poultry'
GROUP BY c.CategoryName;
