-- Create the database (change the name as you want)
-- CREATE DATABASE SubscriptionDB;
-- GO


/*
-- Table names
subscription_promotions
promotion_plan
promotions

support_tickets
user_logins
cancellations
payments
subscription
subscription_plans
user_ltv
retention_snapshots
users

*/


DROP TABLE IF EXISTS subscription_promotions;
DROP TABLE IF EXISTS promotion_plan;
DROP TABLE IF EXISTS promotions;

DROP TABLE IF EXISTS support_tickets;
DROP TABLE IF EXISTS user_logins;
DROP TABLE IF EXISTS cancellations;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS subscriptions;
DROP TABLE IF EXISTS subscription_plans;
DROP TABLE IF EXISTS user_ltv;
DROP TABLE IF EXISTS retention_snapshots;
DROP TABLE IF EXISTS users;



-- Use the database
USE SubscriptionDB;
GO

-- USERS TABLE
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    signup_date DATE NOT NULL,
    country VARCHAR(MAX),
    language VARCHAR(10),
    device_type VARCHAR(50),        -- e.g., 'iOS', 'Android', 'Web'
    acquisition_channel VARCHAR(MAX) -- e.g., 'organic', 'ads', 'referral'
);

-- SUBSCRIPTION PLANS
CREATE TABLE subscription_plans (
    plan_id INT IDENTITY(1,1) PRIMARY KEY,
    plan_name VARCHAR(100),
    plan_type VARCHAR(20),
    price DECIMAL(10,2) NOT NULL,
    duration_months INT NOT NULL,
    is_active BIT DEFAULT 1
);

-- SUBSCRIPTIONS
CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    plan_id INT NOT NULL,
    subscription_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    is_renewal BIT DEFAULT 0,
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    CONSTRAINT FK_subscriptions_users FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT FK_subscriptions_plans FOREIGN KEY (plan_id) REFERENCES subscription_plans(plan_id)
);

-- PAYMENTS
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    subscription_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50),    -- e.g., 'credit_card', 'paypal'
    status VARCHAR(20),             -- e.g., 'success', 'failed', 'refunded'
    CONSTRAINT FK_payments_users FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT FK_payments_subscriptions FOREIGN KEY (subscription_id) REFERENCES subscriptions(subscription_id)
);

-- CANCELLATIONS
CREATE TABLE cancellations (
    cancel_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    subscription_id INT NOT NULL,
    cancel_date DATE NOT NULL,
    cancel_reason TEXT,
    churn_type VARCHAR(20),         -- e.g., 'voluntary', 'involuntary'
    CONSTRAINT FK_cancellations_users FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT FK_cancellations_subscriptions FOREIGN KEY (subscription_id) REFERENCES subscriptions(subscription_id)
);

-- LOGIN ACTIVITY
CREATE TABLE user_logins (
    login_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    login_timestamp DATETIME2 NOT NULL,
    device_type VARCHAR(50),
    ip_address VARCHAR(45),
    CONSTRAINT FK_user_logins_users FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- CUSTOMER SUPPORT TICKETS
CREATE TABLE support_tickets (
    ticket_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    created_at DATETIME2 NOT NULL,
    resolved_at DATETIME2 NULL,
    status VARCHAR(20),             -- e.g., 'open', 'closed'
    category VARCHAR(50),           -- e.g., 'billing', 'technical'
    feedback TEXT,
    CONSTRAINT FK_support_tickets_users FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- PROMOTIONS & COUPONS
CREATE TABLE promotions (
    promo_id INT PRIMARY KEY,
    promo_code VARCHAR(50) UNIQUE,
    discount_percent INT,
    start_date DATE,
    end_date DATE
);

-- PROMOTION_PLAN JOIN TABLE (for applicable plans)
CREATE TABLE promotion_plan (
    promo_id INT NOT NULL,
    plan_id INT NOT NULL,
    CONSTRAINT PK_promotion_plan PRIMARY KEY (promo_id, plan_id),
    CONSTRAINT FK_promotion_plan_promotions FOREIGN KEY (promo_id) REFERENCES promotions(promo_id),
    CONSTRAINT FK_promotion_plan_plans FOREIGN KEY (plan_id) REFERENCES subscription_plans(plan_id)
);

-- PROMO APPLICATIONS
CREATE TABLE subscription_promotions (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    subscription_id INT NOT NULL,
    promo_id INT NOT NULL,
    applied_date DATE NOT NULL,
    CONSTRAINT FK_subscription_promotions_users FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT FK_subscription_promotions_subscriptions FOREIGN KEY (subscription_id) REFERENCES subscriptions(subscription_id),
    CONSTRAINT FK_subscription_promotions_promotions FOREIGN KEY (promo_id) REFERENCES promotions(promo_id)
);

-- CUSTOMER LIFETIME VALUE (Precalculated)
CREATE TABLE user_ltv (
    user_id INT PRIMARY KEY,
    total_revenue DECIMAL(10,2),
    avg_monthly_revenue DECIMAL(10,2),
    lifetime_months INT,
    CONSTRAINT FK_user_ltv_users FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- RETENTION SNAPSHOTS (Precalculated for Cohorts)
CREATE TABLE retention_snapshots (
    cohort_month DATE NOT NULL,
    snapshot_month DATE NOT NULL,
    cohort_size INT,
    retained_users INT,
    CONSTRAINT PK_retention_snapshots PRIMARY KEY (cohort_month, snapshot_month)
);
