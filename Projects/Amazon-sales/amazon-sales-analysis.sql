--Price & Discount Analysis
--1.Most Discounted Products
SELECT
  product_name,
  category,
  actual_price,
  discounted_price,
  discount_percentage
FROM `sinuous-set-448618-f9.events.amazon-sales` 
ORDER BY
  discount_percentage DESC
LIMIT 10

--Correlation Between Price and Ratings
SELECT 
    CORR(CAST(actual_price AS FLOAT64), CAST(rating AS FLOAT64)) AS price_rating_correlation
FROM `sinuous-set-448618-f9.events.amazon-sales` 

--Analyzes by Product Category
--Top 10 Best-Selling Products by Rating Count
SELECT 
    product_name, 
    rating_count 
FROM 
  `sinuous-set-448618-f9.events.amazon-sales` 
ORDER BY rating_count DESC
LIMIT 10

--Average Price of Products per Category
SELECT 
    category, 
    AVG(CAST(actual_price AS FLOAT64)) AS avg_price
FROM 
  `sinuous-set-448618-f9.events.amazon-sales`
GROUP BY category
ORDER BY avg_price DESC

--2.Categories with the Most Reviews
SELECT
  category,
  COUNT(*) AS total_products,
  SUM(rating_count) AS total_reviews
FROM
  `sinuous-set-448618-f9.events.amazon-sales` 
GROUP BY
  category
ORDER BY
  total_reviews DESC
LIMIT 10

--User Behavior & Trust Analysis
--Users with the Most Comments
SELECT
  user_name,
  COUNT(*)AS total_reviews
FROM
  `sinuous-set-448618-f9.events.amazon-sales` 
GROUP BY 
  user_name
ORDER BY
  total_reviews DESC
LIMIT 10

--Average Value of User Ratings
SELECT
  user_id,
  AVG(SAFE_CAST(rating AS FLOAT64)) AS avg_rating,
  COUNT(*) AS total_reviews
FROM
  `sinuous-set-448618-f9.events.amazon-sales` 
GROUP BY
  user_id
HAVING
  COUNT(*) > 5
ORDER BY
  avg_rating DESC
LIMIT 10


