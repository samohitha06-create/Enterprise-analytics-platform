-- ========================================
-- STAGING: Orders
-- ========================================

DROP TABLE IF EXISTS stg_orders;

CREATE TABLE stg_orders AS
SELECT
    order_id,
    customer_id,
    order_status,
    DATE(order_purchase_timestamp) AS order_date,
    DATE(order_approved_at) AS order_approved_date,
    DATE(order_delivered_carrier_date) AS shipped_date,
    DATE(order_delivered_customer_date) AS delivered_date,
    DATE(order_estimated_delivery_date) AS estimated_delivery_date
FROM olist_orders
WHERE order_id IS NOT NULL
  AND customer_id IS NOT NULL;
