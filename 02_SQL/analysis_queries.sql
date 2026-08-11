-- ============================================
-- BLINKIT BUSINESS ANALYSIS PROJECT
-- Author: Tanmay Rana
-- ============================================

-- ============================================
-- SECTION 1 : BUSINESS KPIs
-- ============================================

-- 1. Total Revenue
SELECT SUM(order_total) AS total_revenue
FROM orders;

-- 2. Total Orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 3. Total Customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- 4. Average Order Value
SELECT ROUND(AVG(order_total),2) AS average_order_value
FROM orders;

-- 5. Total Products
SELECT COUNT(*) AS total_products
FROM products;

-- ============================================
-- SECTION 2 : CUSTOMER ANALYSIS
-- ============================================

-- 6. Customers by Segment
SELECT
    customer_segment,
    COUNT(*) AS total_customers
FROM customers
GROUP BY customer_segment
ORDER BY total_customers DESC;

-- 7. Top 10 Customers by Total Spending
SELECT
    c.customer_id,
    c.customer_name,
    c.customer_segment,
    SUM(o.order_total) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.customer_segment
ORDER BY total_spent DESC
LIMIT 10;

-- 8. Average Spending by Customer Segment
SELECT
    c.customer_segment,
    ROUND(AVG(o.order_total),2) AS average_spending
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_segment
ORDER BY average_spending DESC;

-- 9. Payment Method Usage
SELECT
    payment_method,
    COUNT(*) AS total_orders
FROM orders
GROUP BY payment_method
ORDER BY total_orders DESC;

-- 10. Customers Who Placed More Than One Order
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1
ORDER BY total_orders DESC;

-- ============================================
-- SECTION 3 : PRODUCT ANALYSIS
-- ============================================

-- 11. Total Products by Category
SELECT
    category,
    COUNT(*) AS total_products
FROM products
GROUP BY category
ORDER BY total_products DESC;

-- 12. Top 10 Selling Products
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 10;

-- 13. Top 10 Brands by Revenue
SELECT
    p.brand,
    ROUND(SUM(oi.quantity * oi.unit_price),2) AS total_revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.brand
ORDER BY total_revenue DESC
LIMIT 10;

-- 14. Average Product Price by Category
SELECT
    category,
    ROUND(AVG(price),2) AS average_price
FROM products
GROUP BY category
ORDER BY average_price DESC;

-- 15. Top 10 Most Expensive Products
SELECT
    product_name,
    brand,
    category,
    price
FROM products
ORDER BY price DESC
LIMIT 10;

-- ============================================
-- SECTION 4 : SALES ANALYSIS
-- ============================================

-- 16. Monthly Revenue Trend
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    ROUND(SUM(order_total),2) AS total_revenue
FROM orders
GROUP BY month
ORDER BY month;

-- 17. Revenue by Payment Method
SELECT
    payment_method,
    ROUND(SUM(order_total),2) AS total_revenue
FROM orders
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- 18. Top 10 Highest Value Orders
SELECT
    order_id,
    customer_id,
    order_total
FROM orders
ORDER BY order_total DESC
LIMIT 10;

-- 19. Average Order Value by Payment Method
SELECT
    payment_method,
    ROUND(AVG(order_total),2) AS average_order_value
FROM orders
GROUP BY payment_method
ORDER BY average_order_value DESC;

-- 20. Daily Sales Trend
SELECT
    DATE(order_date) AS order_day,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(order_total),2) AS daily_revenue
FROM orders
GROUP BY order_day
ORDER BY order_day;

-- ============================================
-- SECTION 5 : DELIVERY PERFORMANCE
-- ============================================

-- 21. Delivery Status Distribution
SELECT
    delivery_status,
    COUNT(*) AS total_orders
FROM delivery_performance
GROUP BY delivery_status
ORDER BY total_orders DESC;

-- 22. Average Delivery Time
SELECT
    ROUND(AVG(delivery_time_minutes),2) AS average_delivery_time
FROM delivery_performance;

-- 23. Top Delay Reasons
SELECT
    reasons_if_delayed,
    COUNT(*) AS total_delays
FROM delivery_performance
WHERE delivery_status = 'Delayed'
GROUP BY reasons_if_delayed
ORDER BY total_delays DESC;

-- 24. Average Delivery Time by Status
SELECT
    delivery_status,
    ROUND(AVG(delivery_time_minutes),2) AS average_time
FROM delivery_performance
GROUP BY delivery_status;

-- 25. Longest 10 Deliveries
SELECT
    order_id,
    delivery_partner_id,
    delivery_time_minutes,
    distance_km
FROM delivery_performance
ORDER BY delivery_time_minutes DESC
LIMIT 10;

-- ============================================
-- SECTION 6 : CUSTOMER FEEDBACK ANALYSIS
-- ============================================

-- 26. Rating Distribution
SELECT
    rating,
    COUNT(*) AS total_feedback
FROM customer_feedback
GROUP BY rating
ORDER BY rating DESC;

-- 27. Average Customer Rating
SELECT
    ROUND(AVG(rating),2) AS average_rating
FROM customer_feedback;

-- 28. Feedback by Sentiment
SELECT
    sentiment,
    COUNT(*) AS total_feedback
FROM customer_feedback
GROUP BY sentiment
ORDER BY total_feedback DESC;

-- 29. Feedback by Category
SELECT
    feedback_category,
    COUNT(*) AS total_feedback
FROM customer_feedback
GROUP BY feedback_category
ORDER BY total_feedback DESC;

-- 30. Monthly Feedback Trend
SELECT
    DATE_FORMAT(feedback_date, '%Y-%m') AS month,
    COUNT(*) AS total_feedback
FROM customer_feedback
GROUP BY month
ORDER BY month;

-- ============================================
-- SECTION 7 : MARKETING PERFORMANCE ANALYSIS
-- ============================================

-- 31. Total Marketing Spend
SELECT
    ROUND(SUM(spend),2) AS total_marketing_spend
FROM marketing_performance;

-- 32. Total Revenue Generated from Marketing
SELECT
    ROUND(SUM(revenue_generated),2) AS total_revenue_generated
FROM marketing_performance;

-- 33. Top 10 Campaigns by Revenue
SELECT
    campaign_name,
    ROUND(SUM(revenue_generated),2) AS revenue
FROM marketing_performance
GROUP BY campaign_name
ORDER BY revenue DESC
LIMIT 10;

-- 34. Channel Performance
SELECT
    channel,
    ROUND(SUM(revenue_generated),2) AS revenue,
    ROUND(SUM(spend),2) AS total_spend,
    ROUND(AVG(roas),2) AS average_roas
FROM marketing_performance
GROUP BY channel
ORDER BY revenue DESC;

-- 35. Top 10 Campaigns by ROAS
SELECT
    campaign_name,
    ROUND(AVG(roas),2) AS average_roas
FROM marketing_performance
GROUP BY campaign_name
ORDER BY average_roas DESC
LIMIT 10;

-- 36. Conversion Rate by Campaign
SELECT
    campaign_name,
    ROUND((SUM(conversions) / SUM(clicks)) * 100, 2) AS conversion_rate_percentage
FROM marketing_performance
WHERE clicks > 0
GROUP BY campaign_name
ORDER BY conversion_rate_percentage DESC;

-- 37. Top Target Audiences by Revenue
SELECT
    target_audience,
    ROUND(SUM(revenue_generated),2) AS revenue
FROM marketing_performance
GROUP BY target_audience
ORDER BY revenue DESC;

-- 38. Monthly Marketing Spend
SELECT
    DATE_FORMAT(campaign_date, '%Y-%m') AS month,
    ROUND(SUM(spend),2) AS total_spend
FROM marketing_performance
GROUP BY month
ORDER BY month;

-- 39. Monthly Revenue Generated
SELECT
    DATE_FORMAT(campaign_date, '%Y-%m') AS month,
    ROUND(SUM(revenue_generated),2) AS revenue
FROM marketing_performance
GROUP BY month
ORDER BY month;

-- 40. Overall Marketing KPIs
SELECT
    ROUND(SUM(spend),2) AS total_spend,
    ROUND(SUM(revenue_generated),2) AS total_revenue,
    ROUND(AVG(roas),2) AS average_roas,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(conversions) AS total_conversions
FROM marketing_performance;
