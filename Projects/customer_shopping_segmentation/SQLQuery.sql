SELECT TOP (1000) [invoice_no]
      ,[customer_id]
      ,[gender]
      ,[age]
      ,[category]
      ,[quantity]
      ,[price]
      ,[payment_method]
      ,[invoice_date]
      ,[shopping_mall]
  FROM [Portfolio].[dbo].[customer_shopping_data]

SELECT TOP 5 * FROM customer_shopping_data 

/* Which age groups spend the most? */
SELECT age, SUM(quantity*price) AS total_spent
FROM customer_shopping_data
GROUP BY age
ORDER BY total_spent DESC

/* What are the top-selling products in each shopping mall? */
SELECT shopping_mall , category, SUM(quantity) AS total_quantity_sold
FROM customer_shopping_data
GROUP BY shopping_mall,category
ORDER BY total_quantity_sold DESC

/* Which payment method is most frequently used by different customer groups? 
Age Group and Preferred Payment Methods: */
SELECT gender, payment_method, COUNT(*) AS number_of_transactions
FROM customer_shopping_data
GROUP BY gender, payment_method
ORDER BY number_of_transactions DESC

/* Are there any noticeable gender-based preferences in product categories? */
SELECT gender, category, COUNT(*) AS Total_Purchases
FROM customer_shopping_data
GROUP BY gender, category
ORDER BY Total_Purchases DESC

/* Category-wise Revenue Contribution */
SELECT category, SUM(quantity*price) AS Total_revenue
FROM customer_shopping_data
GROUP BY category
ORDER BY total_revenue DESC

/* What is the total revenue generated per shopping mall? */
SELECT shopping_mall, SUM(quantity*price) AS Total_revenue
FROM customer_shopping_data
GROUP BY shopping_mall
ORDER BY Total_revenue DESC

/* Monthly Revenue Trend Across Shopping Malls: */
SELECT shopping_mall, DATEPART(YEAR,invoice_date) AS Year, DATEPART(MONTH,invoice_date) AS Month,
SUM(quantity*price) AS Total_revenue
FROM customer_shopping_data
GROUP BY shopping_mall, DATEPART(YEAR, invoice_date), DATEPART(MONTH, invoice_date)
ORDER BY Year, Month

/* What are the busiest shopping months/days? */
SELECT DATEPART(MONTH, invoice_date) AS Month, SUM(quantity) AS Total_quantity
FROM customer_shopping_data
GROUP BY DATEPART(MONTH, invoice_date)
ORDER BY Total_quantity DESC

/* Which shopping malls attract the most loyal customers (repeat buyers)? */
SELECT shopping_mall, customer_id ,COUNT(*) AS Total_visits
FROM customer_shopping_data
GROUP BY shopping_mall, customer_id
HAVING COUNT(*) > 1
ORDER BY Total_visits DESC