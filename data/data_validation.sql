-- Data Validity Queries
-- Orphaned subscriptions (user doesn't exist)
SELECT * FROM subscriptions s WHERE NOT EXISTS (
    SELECT 1 FROM users u WHERE u.user_id = s.user_id
);

-- Payments with non-existent subscriptions
SELECT * FROM payments p WHERE NOT EXISTS (
    SELECT 1 FROM subscriptions s WHERE s.subscription_id = p.subscription_id
);

-- Cancellations with invalid subscription_id
SELECT * FROM cancellations c WHERE NOT EXISTS (
    SELECT 1 FROM subscriptions s WHERE s.subscription_id = c.subscription_id
);


-- Spot-Check Record Counts
SELECT COUNT(*) FROM users;
SELECT COUNT(*) FROM subscriptions;
SELECT COUNT(*) FROM payments;
SELECT COUNT(*) FROM retention_snapshots;

-- Spot-check a few:
SELECT TOP 5 * FROM subscriptions;
SELECT TOP 5 * FROM payments;

-- Test Join Queries
-- Join subscriptions with users and plans
SELECT TOP 10 u.email, s.subscription_date, p.plan_name
FROM subscriptions s
JOIN users u ON s.user_id = u.user_id
JOIN subscription_plans p ON s.plan_id = p.plan_id;

-- Payments summary by user
SELECT u.user_id, u.email, COUNT(p.payment_id) AS total_payments, SUM(p.amount) AS total_amount
FROM users u
JOIN payments p ON u.user_id = p.user_id
GROUP BY u.user_id, u.email;

-- Integrity Validation Queries
SELECT cohort_month, snapshot_month, COUNT(*) as count
FROM retention_snapshots
GROUP BY cohort_month, snapshot_month
HAVING COUNT(*) > 1;


-- Check for NULLs in NOT NULL columns
SELECT * FROM subscriptions WHERE user_id IS NULL OR plan_id IS NULL;