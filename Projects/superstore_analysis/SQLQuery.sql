SELECT TOP (1000) [Row_ID]
      ,[Order_ID]
      ,[Order_Date]
      ,[Ship_Date]
      ,[Ship_Mode]
      ,[Customer_ID]
      ,[Customer_Name]
      ,[Segment]
      ,[Country]
      ,[City]
      ,[State]
      ,[Postal_Code]
      ,[Region]
      ,[Product_ID]
      ,[Category]
      ,[Sub_Category]
      ,[Product_Name]
      ,[Sales]
      ,[Quantity]
      ,[Discount]
      ,[Profit]
  FROM [Portfolio].[dbo].[superstore]

SELECT TOP 5 * FROM superstore

/* Annual Sales and Profit Analysis */
SELECT 
    YEAR(Order_Date) AS Year, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY YEAR(Order_Date)
ORDER BY Year

/* Most Profitable and Least Profitable Products */
SELECT TOP 10 Product_Name, Category, SUM(Profit) AS Total_profit
FROM superstore
GROUP BY Product_Name, Category
ORDER BY Total_profit DESC

/* Top 5 Products by Order Frequency */
SELECT TOP 5 Product_Name, COUNT(Order_ID) AS Order_frequency
FROM superstore
GROUP BY Product_Name
ORDER BY Order_frequency DESC

/* Most Sold Product Categories */
SELECT Category, SUM(Quantity) AS Total_quantity
FROM superstore
GROUP BY Category
ORDER BY Total_quantity DESC

/* Product Cross-Sell Opportunities */
SELECT TOP 10 a.Product_Name AS Product_1, b.Product_Name AS Product_2, COUNT(*) AS Together_count
FROM superstore a
JOIN 
    superstore b ON a.Order_ID = b.Order_ID AND a.Product_ID <> b.Product_ID
GROUP BY 
    a.Product_Name, b.Product_Name
ORDER BY 
    Together_count DESC

/* Sales and Profit by Region */
SELECT Region, SUM(Sales) AS Total_sales, SUM(Profit) AS Total_profit
FROM superstore
GROUP BY Region
ORDER BY Total_sales DESC

/* Discount and Profit Analysis by Customer Segment */
SELECT Segment, AVG(Discount) AS Avg_discount, SUM(Profit) AS Total_profit
FROM superstore
GROUP BY Segment
ORDER BY Total_profit DESC

/* Average Order Value (AOV) by Customer Segment */
SELECT Segment, AVG(Sales) AS Avg_order_value
FROM superstore
GROUP BY Segment
ORDER BY Avg_order_value DESC

/* Customer Lifetime Value (CLV) Estimation */
SELECT TOP 10 Customer_ID, Customer_Name, SUM(Sales) AS Total_sales
FROM superstore
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_sales DESC

/* Top 5 Cities with the Highest Sales */
SELECT TOP 5 State, SUM(Sales) AS Total_sales
FROM superstore
GROUP BY State
ORDER BY Total_sales DESC

/* Profitability by Product Sub-Category */
SELECT Sub_Category, SUM(Profit) AS Total_profit
FROM superstore
GROUP BY Sub_Category
ORDER BY Total_profit DESC

/* Delivery Time Analysis */
SELECT AVG(DATEDIFF(DAY,Order_Date,Ship_Date)) AS Avg_delivery_days
FROM superstore

/* Average Shipping Time by Shipping Mode */
SELECT Ship_Mode, AVG(DATEDIFF(DAY, Order_Date, Ship_Date)) AS Avg_Shipping_Days
FROM superstore
GROUP BY Ship_Mode
ORDER BY Avg_Shipping_Days ASC

/* Annual and Monthly Sales Trend */
SELECT YEAR(Order_Date) AS year, MONTH(Order_Date) AS month,SUM(Sales) AS Total_sales
FROM superstore
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY year,month

/* Customers Receiving the Most Discounts */
SELECT TOP 10 Customer_ID,Customer_Name, SUM(Discount) AS Total_discount
FROM superstore
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_discount DESC