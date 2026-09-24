-- 1ST QUERY

SELECT
    SUM(TotalPrice) AS GrossRevenue,
    SUM(CASE WHEN OrderStatus IN
    ('Cancelled', 'Returned') THEN TotalPrice 
ELSE 0 END) AS RevenueLost,
    SUM(CASE WHEN OrderStatus = 'Pending' 
THEN TotalPrice ELSE 0 END) AS 
RevenuePending,
    SUM(CASE WHEN OrderStatus NOT IN 
('Cancelled', 'Returned') THEN TotalPrice 
ELSE 0 END) AS NetRevenue,
    CAST(
        SUM(CASE WHEN OrderStatus NOT IN 
('Cancelled', 'Returned') THEN TotalPrice 
ELSE 0 END)
        / NULLIF(SUM(TotalPrice), 0) AS 
DECIMAL(5,4)
    ) AS NetRevenuePctOfGross
FROM AnalysisDataset

-- 2ND QUERY

SELECT
    DATEFROMPARTS(YEAR([Date]), 
MONTH([Date]), 1) AS OrderMonth,
    COUNT(*) AS OrderCount,
    SUM(TotalPrice) AS GrossRevenue,
    SUM(CASE WHEN OrderStatus IN 
('Cancelled', 'Returned') THEN TotalPrice 
ELSE 0 END) AS RevenueLost
FROM AnalysisDataset
GROUP BY DATEFROMPARTS(YEAR([Date]) ,
MONTH([Date]), 1)
ORDER BY OrderMonth

-- 3RD QUERY

SELECT
    OrderStatus,
    COUNT(*) AS OrderCount,
    CAST(COUNT(*) * 1.0 / SUM(COUNT(*)) 
OVER () AS DECIMAL(5,4)) AS PctOfOrders,
    SUM(TotalPrice) AS TotalRevenue
FROM AnalysisDataset
GROUP BY OrderStatus
ORDER BY OrderCount DESC


-- 4TH QUERY
SELECT
    PaymentMethod,
    COUNT(*) AS OrderCount,
    CAST(COUNT(*) * 1.0 / SUM(COUNT(*)) 
OVER () AS DECIMAL(5,4)) AS PctOfOrders,
    SUM(TotalPrice) AS TotalRevenue
FROM AnalysisDataset
GROUP BY PaymentMethod
ORDER BY OrderCount DESC

-- 5TH QUERY

SELECT
    PaymentMethod,
    COUNT(*) AS TotalOrders,
    SUM(CASE WHEN OrderStatus IN 
('Cancelled', 'Returned') THEN 1 ELSE 0 
END) AS LostOrders,
    CAST(
        SUM(CASE WHEN OrderStatus IN 
('Cancelled', 'Returned') THEN 1 ELSE 0 
END) * 1.0
        / COUNT(*) AS DECIMAL(5,4)
    ) AS LostRate
FROM AnalysisDataset
GROUP BY PaymentMethod
ORDER BY LostRate DESC

-- 6TH QUERY

SELECT TOP 10
    Product,
    COUNT(*) AS OrderCount,
    SUM(Quantity) AS UnitsSold,
    SUM(TotalPrice) AS TotalRevenue,
    AVG(UnitPrice) AS AvgUnitPrice
FROM AnalysisDataset
GROUP BY Product
ORDER BY TotalRevenue DESC

-- 7TH QUERY

SELECT TOP 20
    CustomerID,
    COUNT(*) AS OrderCount,
    SUM(TotalPrice) AS TotalSpend,
    AVG(TotalPrice) AS AvgOrderValue,
    MAX(Date) AS MostRecentOrder
FROM AnalysisDataset
GROUP BY CustomerID
ORDER BY TotalSpend DESC
  
  -- 8TH QUERY
  
SELECT
    ReferralSource,
    COUNT(*) AS OrderCount,
    SUM(TotalPrice) AS GrossRevenue,
    SUM(CASE WHEN OrderStatus NOT IN 
('Cancelled', 'Returned') THEN TotalPrice 
ELSE 0 END) AS NetRevenue,
    CAST(
        SUM(CASE WHEN OrderStatus IN 
('Cancelled', 'Returned') THEN 1 ELSE 0 
END) * 1.0
        / COUNT(*) AS DECIMAL(5,4)
    ) AS LostRate
FROM AnalysisDataset
GROUP BY ReferralSource
ORDER BY NetRevenue DESC

-- 9TH QUERY

SELECT
    CASE WHEN CouponCode IS NULL OR 
CouponCode = 'NO COUPON' THEN 'No Coupon' ELSE 
'Coupon Used' END AS CouponFlag,
 COUNT(*) AS OrderCount,
    AVG(TotalPrice) AS AvgOrderValue,
    SUM(TotalPrice) AS TotalRevenue
FROM AnalysisDataset
GROUP BY CASE WHEN CouponCode IS NULL OR 
CouponCode = 'NO COUPON' THEN 'No Coupon' ELSE 
'Coupon Used' END;

-- 10TH QUERY


SELECT
    DATEFROMPARTS(YEAR([Date]), 
MONTH([Date]), 1) AS OrderMonth,
    COUNT(*) AS OrderCount,
    AVG(TotalPrice) AS AvgOrderValue,
    AVG(CAST(Quantity AS FLOAT)) AS 
AvgQuantity
FROM AnalysisDataset
GROUP BY DATEFROMPARTS(YEAR([Date]), MONTH([Date]), 1)
ORDER BY OrderMonth