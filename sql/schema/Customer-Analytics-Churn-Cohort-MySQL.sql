CREATE TABLE `users` (
  `user_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_name` varchar(255),
  `email` varchar(255),
  `signup_date` date,
  `status` varchar(255)
);

CREATE TABLE `subscriptions` (
  `subscription_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `plan_id` int,
  `start_date` date,
  `end_date` date,
  `status` varchar(255)
);

CREATE TABLE `subscription_plans` (
  `plan_id` int PRIMARY KEY AUTO_INCREMENT,
  `plan_name` varchar(255),
  `price` decimal(10,2),
  `duration_months` int
);

CREATE TABLE `subscription_promotions` (
  `subscription_promo_id` int PRIMARY KEY AUTO_INCREMENT,
  `subscription_id` int,
  `promo_id` int,
  `applied_date` date
);

CREATE TABLE `promotions` (
  `promo_id` int PRIMARY KEY AUTO_INCREMENT,
  `promo_code` varchar(255),
  `discount_percent` int,
  `start_date` date,
  `end_date` date,
  `applicable_plan_ids` varchar(255)
);

CREATE TABLE `payments` (
  `payment_id` int PRIMARY KEY AUTO_INCREMENT,
  `subscription_id` int,
  `payment_date` date,
  `amount` decimal(10,2),
  `payment_method` varchar(255),
  `status` varchar(255)
);

CREATE TABLE `cancellations` (
  `cancellation_id` int PRIMARY KEY AUTO_INCREMENT,
  `subscription_id` int,
  `cancellation_date` date,
  `reason` varchar(255)
);

CREATE TABLE `user_logins` (
  `login_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `login_date` datetime,
  `ip_address` varchar(255),
  `device` varchar(255)
);

CREATE TABLE `support_tickets` (
  `ticket_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `issue_date` datetime,
  `issue_type` varchar(255),
  `status` varchar(255),
  `resolution_date` datetime
);

CREATE TABLE `retention_snapshots` (
  `snapshot_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `snapshot_date` date,
  `retention_score` int
);

CREATE TABLE `user_ltv` (
  `ltv_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `calculated_date` date,
  `lifetime_value` decimal(10,2)
);

CREATE TABLE `churn_events` (
  `churn_event_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `churn_date` date,
  `churn_reason` varchar(255),
  `detected_by` varchar(255),
  `comments` text
);

ALTER TABLE `subscriptions` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `subscriptions` ADD FOREIGN KEY (`plan_id`) REFERENCES `subscription_plans` (`plan_id`);

ALTER TABLE `subscription_promotions` ADD FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`subscription_id`);

ALTER TABLE `subscription_promotions` ADD FOREIGN KEY (`promo_id`) REFERENCES `promotions` (`promo_id`);

ALTER TABLE `payments` ADD FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`subscription_id`);

ALTER TABLE `cancellations` ADD FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`subscription_id`);

ALTER TABLE `user_logins` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `support_tickets` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `retention_snapshots` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `user_ltv` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `churn_events` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
