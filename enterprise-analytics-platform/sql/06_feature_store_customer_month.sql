-- ========================================
-- FEATURE STORE: Customer Monthly Features
-- ========================================

DROP TABLE IF EXISTS feature_store_customer_month;

CREATE TABLE feature_store_customer_month AS
SELECT
    customer_id,
    substr(order_date, 1, 7) AS order_month,

    COUNT(DISTINCT order_id) AS orders_count,
    ROUND(SUM(price + freight_value), 2) AS total_spend,
    ROUND(AVG(price + freight_value), 2) AS avg_order_value,

    ROUND(AVG(delivery_days), 1) AS avg_delivery_days,
    ROUND(AVG(is_on_time), 3) AS on_time_rate

FROM fct_order_lines
WHERE order_status = 'delivered'
GROUP BY customer_id, order_month;

