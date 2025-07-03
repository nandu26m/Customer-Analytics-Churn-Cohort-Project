CREATE TABLE `users` (
  `user_id` int PRIMARY KEY AUTO_INCREMENT,
  `email` varchar(255) UNIQUE NOT NULL,
  `signup_date` date NOT NULL,
  `country` varchar(50),
  `language` varchar(10),
  `device_type` varchar(50),
  `acquisition_channel` varchar(50)
);

CREATE TABLE `subscription_plans` (
  `plan_id` int PRIMARY KEY AUTO_INCREMENT,
  `plan_name` varchar(100),
  `plan_type` varchar(20),
  `price` decimal(10,2) NOT NULL,
  `duration_months` int NOT NULL,
  `is_active` boolean DEFAULT true
);

CREATE TABLE `subscriptions` (
  `subscription_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `plan_id` int,
  `subscription_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `is_renewal` boolean DEFAULT false,
  `status` varchar(20)
);

CREATE TABLE `payments` (
  `payment_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `subscription_id` int,
  `payment_date` date NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50),
  `status` varchar(20)
);

CREATE TABLE `cancellations` (
  `cancel_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `subscription_id` int,
  `cancel_date` date NOT NULL,
  `cancel_reason` text,
  `churn_type` varchar(20)
);

CREATE TABLE `user_logins` (
  `login_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `login_timestamp` timestamp NOT NULL,
  `device_type` varchar(50),
  `ip_address` varchar(45)
);

CREATE TABLE `support_tickets` (
  `ticket_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `created_at` timestamp NOT NULL,
  `resolved_at` timestamp,
  `status` varchar(20),
  `category` varchar(50),
  `feedback` text
);

CREATE TABLE `promotions` (
  `promo_id` int PRIMARY KEY AUTO_INCREMENT,
  `promo_code` varchar(50) UNIQUE,
  `discount_percent` int,
  `start_date` date,
  `end_date` date,
  `applicable_plan_ids` int[]
);

CREATE TABLE `subscription_promotions` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `subscription_id` int,
  `promo_id` int,
  `applied_date` date NOT NULL
);

CREATE TABLE `user_ltv` (
  `user_id` int PRIMARY KEY,
  `total_revenue` decimal(10,2),
  `avg_monthly_revenue` decimal(10,2),
  `lifetime_months` int
);

CREATE TABLE `retention_snapshots` (
  `cohort_month` date,
  `snapshot_month` date,
  `cohort_size` int,
  `retained_users` int,
  PRIMARY KEY (`cohort_month`, `snapshot_month`)
);

CREATE TABLE `user_events` (
  `event_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `event_type` varchar(100) NOT NULL,
  `event_timestamp` timestamp NOT NULL,
  `event_metadata` jsonb,
  `device_type` varchar(50),
  `ip_address` varchar(45)
);

CREATE TABLE `payment_transactions` (
  `transaction_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `subscription_id` int,
  `transaction_date` timestamp NOT NULL,
  `transaction_type` varchar(20) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50),
  `status` varchar(20) NOT NULL,
  `transaction_reference` varchar(100) UNIQUE
);

CREATE TABLE `subscription_status_history` (
  `status_history_id` int PRIMARY KEY AUTO_INCREMENT,
  `subscription_id` int,
  `status` varchar(20) NOT NULL,
  `status_start_date` date NOT NULL,
  `status_end_date` date,
  `reason` varchar(255)
);

ALTER TABLE `subscriptions` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `subscriptions` ADD FOREIGN KEY (`plan_id`) REFERENCES `subscription_plans` (`plan_id`);

ALTER TABLE `payments` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `payments` ADD FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`subscription_id`);

ALTER TABLE `cancellations` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `cancellations` ADD FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`subscription_id`);

ALTER TABLE `user_logins` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `support_tickets` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `subscription_promotions` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `subscription_promotions` ADD FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`subscription_id`);

ALTER TABLE `subscription_promotions` ADD FOREIGN KEY (`promo_id`) REFERENCES `promotions` (`promo_id`);

ALTER TABLE `user_ltv` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `user_events` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `payment_transactions` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `payment_transactions` ADD FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`subscription_id`);

ALTER TABLE `subscription_status_history` ADD FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`subscription_id`);
