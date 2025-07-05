-- ===========================
-- User Demographics & Acquisition
-- ===========================

-- 1. How many users are there in total?
-- Understand the overall user base size.

SELECT
	COUNT(DISTINCT user_id) AS total_users
FROM users;

-- 2. What are the top acquisition channels? / Which acquisition channels brought in the highest number of users?
-- Evaluate which marketing channels bring in the most users.

SELECT
    acquisition_channel,
    COUNT(*) AS user_count
FROM users
GROUP BY acquisition_channel
ORDER BY user_count DESC;

-- 3. What is the distribution of users by device type?
-- Learn how users access the platform (Web, iOS, Android).

SELECT
	device_type,
	COUNT(*) AS distribution
FROM users
GROUP BY device_type
ORDER BY distribution DESC;

-- 4. What countries and languages are most represented?
-- Check geographical and language preferences to tailor localization.

SELECT
	country, 
	language,
	COUNT(DISTINCT user_id) AS distribution
FROM users
GROUP BY country, language
ORDER BY distribution DESC;

-- ===========================
-- Revenue and Payments
-- ===========================

-- 5. What is the total revenue collected?
-- Get a snapshot of total income from successful payments.

SELECT
	ISNULL(SUM(amount), 0) AS total_amount_collected
FROM payments
WHERE status = 'success';

-- 6. What is the average revenue per payment method?
-- Analyze if some payment methods bring in higher-value transactions.

SELECT
	payment_method,
	AVG(amount) AS avg_rev_per_month
FROM payments
GROUP BY payment_method

-- 7. Which subscription plans generate the most revenue?
-- Identify high-performing plans.

WITH revenue_by_plans AS (
    SELECT
        subscriptions.plan_id,
        SUM(payments.amount) AS total_revenue
    FROM subscriptions
    JOIN payments ON subscriptions.subscription_id = payments.subscription_id
    WHERE payments.status = 'success'  -- Optional: only count successful payments
    GROUP BY subscriptions.plan_id
)
SELECT
    revenue_by_plans.plan_id,
    subscription_plans.plan_name,
    revenue_by_plans.total_revenue
FROM revenue_by_plans
JOIN subscription_plans 
    ON revenue_by_plans.plan_id = subscription_plans.plan_id
ORDER BY revenue_by_plans.total_revenue DESC;


-- 8. What is the trend of monthly revenue over time?
-- Monitor business growth or seasonality.

SELECT
    YEAR(payment_date) AS year,
    MONTH(payment_date) AS month,
    SUM(amount) AS total_revenue
FROM payments
WHERE status = 'success'  -- Optional: only consider successful payments
GROUP BY YEAR(payment_date), MONTH(payment_date)
ORDER BY year, month;

-- ===========================
-- Subscription Behavior
-- ===========================

-- 9. How many subscriptions are active vs. inactive?
-- Spot user drop-off and system usage patterns.

SELECT
  COUNT(CASE WHEN status = 'active' THEN 1 END) AS active_count,
  COUNT(CASE WHEN status != 'active' THEN 1 END) AS inactive_count
FROM subscriptions;


-- 10. Which plans are most popular by subscription count?
-- Understand user preferences across plan types.

SELECT 
	plan_id,
	COUNT(*) AS users
FROM subscriptions
GROUP BY plan_id
ORDER BY users DESC;

SELECT 
  plan_id,
  COUNT(*) AS users,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage_share
FROM subscriptions
GROUP BY plan_id
ORDER BY users DESC;

-- 11. What percentage of users renew their subscriptions?
-- Assess product stickiness and customer retention.

SELECT
  ROUND(COUNT(CASE WHEN is_renewal = 1 THEN 1 END) * 100.0 / COUNT(*), 2) AS renewal_rate_percentage
FROM subscriptions;

-- 12. What is the average duration of subscriptions?
-- Know how long users typically stay subscribed.


-- ===========================
-- Churn and Cancellations
-- ===========================

-- 13. How many users have churned?
-- Quantify customer loss.

-- 14. What are the most common reasons for cancellation?
-- Identify pain points or product issues.

-- 15. What is the split between voluntary and involuntary churn?
-- Help differentiate between users who leave vs. those lost to payment failures or inactivity.


-- ===========================
-- Retention and Cohort Analysis
-- ===========================

-- 16. What is the monthly retention rate by cohort?
-- Track how well different signup cohorts retain users over time.

-- 17. Which cohorts have the best long-term retention?
-- Discover which acquisition periods led to more loyal users.


-- ===========================
-- Promotions and Campaigns
-- ===========================

-- 18. Which promo codes are most frequently used?
-- Learn what offers resonate most with users.

-- 19. What is the revenue generated from users who used promotions?
-- Evaluate the ROI of your discount strategies.

-- 20. How often are promotions applied to subscriptions?
-- Spot trends in promo adoption over time.


-- ===========================
-- Customer Lifetime Value
-- ===========================

-- 21. What is the average lifetime value (LTV) across users?
-- Understand average customer worth.

-- 22. Who are the top 10 highest LTV users?
-- Profile your most valuable customers.

-- 23. What is the distribution of LTV across acquisition channels or plans?
-- Reveal what segments lead to high-value customers.
