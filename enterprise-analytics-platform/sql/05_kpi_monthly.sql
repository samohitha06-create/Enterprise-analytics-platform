-- ========================================
-- KPI: Monthly Finance & Operations Metrics
-- ========================================

SELECT
    substr(order_date, 1, 7) AS order_month,

    COUNT(DISTINCT order_id) AS total_orders,

    ROUND(SUM(price + freight_value), 2) AS gross_revenue,

    ROUND(
        SUM(price + freight_value) / COUNT(DISTINCT order_id),
        2
    ) AS avg_order_value,

    ROUND(AVG(delivery_days), 1) AS avg_delivery_days,

    ROUND(
        SUM(is_on_time) * 1.0 / COUNT(is_delivered),
        4
    ) AS on_time_delivery_rate

FROM fct_order_lines
WHERE order_status = 'delivered'
GROUP BY order_month
ORDER BY order_month;
