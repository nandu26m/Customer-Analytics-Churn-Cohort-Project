CREATE TABLE [users] (
  [user_id] int PRIMARY KEY IDENTITY(1, 1),
  [user_name] nvarchar(255),
  [email] nvarchar(255),
  [signup_date] date,
  [status] nvarchar(255)
)
GO

CREATE TABLE [subscriptions] (
  [subscription_id] int PRIMARY KEY IDENTITY(1, 1),
  [user_id] int,
  [plan_id] int,
  [start_date] date,
  [end_date] date,
  [status] nvarchar(255)
)
GO

CREATE TABLE [subscription_plans] (
  [plan_id] int PRIMARY KEY IDENTITY(1, 1),
  [plan_name] nvarchar(255),
  [price] decimal(10,2),
  [duration_months] int
)
GO

CREATE TABLE [subscription_promotions] (
  [subscription_promo_id] int PRIMARY KEY IDENTITY(1, 1),
  [subscription_id] int,
  [promo_id] int,
  [applied_date] date
)
GO

CREATE TABLE [promotions] (
  [promo_id] int PRIMARY KEY IDENTITY(1, 1),
  [promo_code] nvarchar(255),
  [discount_percent] int,
  [start_date] date,
  [end_date] date,
  [applicable_plan_ids] nvarchar(255)
)
GO

CREATE TABLE [payments] (
  [payment_id] int PRIMARY KEY IDENTITY(1, 1),
  [subscription_id] int,
  [payment_date] date,
  [amount] decimal(10,2),
  [payment_method] nvarchar(255),
  [status] nvarchar(255)
)
GO

CREATE TABLE [cancellations] (
  [cancellation_id] int PRIMARY KEY IDENTITY(1, 1),
  [subscription_id] int,
  [cancellation_date] date,
  [reason] nvarchar(255)
)
GO

CREATE TABLE [user_logins] (
  [login_id] int PRIMARY KEY IDENTITY(1, 1),
  [user_id] int,
  [login_date] datetime,
  [ip_address] nvarchar(255),
  [device] nvarchar(255)
)
GO

CREATE TABLE [support_tickets] (
  [ticket_id] int PRIMARY KEY IDENTITY(1, 1),
  [user_id] int,
  [issue_date] datetime,
  [issue_type] nvarchar(255),
  [status] nvarchar(255),
  [resolution_date] datetime
)
GO

CREATE TABLE [retention_snapshots] (
  [snapshot_id] int PRIMARY KEY IDENTITY(1, 1),
  [user_id] int,
  [snapshot_date] date,
  [retention_score] int
)
GO

CREATE TABLE [user_ltv] (
  [ltv_id] int PRIMARY KEY IDENTITY(1, 1),
  [user_id] int,
  [calculated_date] date,
  [lifetime_value] decimal(10,2)
)
GO

CREATE TABLE [churn_events] (
  [churn_event_id] int PRIMARY KEY IDENTITY(1, 1),
  [user_id] int,
  [churn_date] date,
  [churn_reason] nvarchar(255),
  [detected_by] nvarchar(255),
  [comments] text
)
GO

ALTER TABLE [subscriptions] ADD FOREIGN KEY ([user_id]) REFERENCES [users] ([user_id])
GO

ALTER TABLE [subscriptions] ADD FOREIGN KEY ([plan_id]) REFERENCES [subscription_plans] ([plan_id])
GO

ALTER TABLE [subscription_promotions] ADD FOREIGN KEY ([subscription_id]) REFERENCES [subscriptions] ([subscription_id])
GO

ALTER TABLE [subscription_promotions] ADD FOREIGN KEY ([promo_id]) REFERENCES [promotions] ([promo_id])
GO

ALTER TABLE [payments] ADD FOREIGN KEY ([subscription_id]) REFERENCES [subscriptions] ([subscription_id])
GO

ALTER TABLE [cancellations] ADD FOREIGN KEY ([subscription_id]) REFERENCES [subscriptions] ([subscription_id])
GO

ALTER TABLE [user_logins] ADD FOREIGN KEY ([user_id]) REFERENCES [users] ([user_id])
GO

ALTER TABLE [support_tickets] ADD FOREIGN KEY ([user_id]) REFERENCES [users] ([user_id])
GO

ALTER TABLE [retention_snapshots] ADD FOREIGN KEY ([user_id]) REFERENCES [users] ([user_id])
GO

ALTER TABLE [user_ltv] ADD FOREIGN KEY ([user_id]) REFERENCES [users] ([user_id])
GO

ALTER TABLE [churn_events] ADD FOREIGN KEY ([user_id]) REFERENCES [users] ([user_id])
GO
