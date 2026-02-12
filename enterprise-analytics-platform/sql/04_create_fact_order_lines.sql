-- ========================================
-- FACT TABLE: Order Lines (Analytics Base)
-- ========================================

DROP TABLE IF EXISTS fct_order_lines;

CREATE TABLE fct_order_lines AS
WITH payment_totals AS (
    SELECT
        order_id,
        SUM(payment_value) AS total_paid
    FROM stg_payments
    GROUP BY order_id
)
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_date,
    o.shipped_date,
    o.delivered_date,
    o.estimated_delivery_date,

    i.order_item_id,
    i.product_id,
    i.seller_id,
    i.shipping_limit_date,
    i.price,
    i.freight_value,

    COALESCE(p.total_paid, 0) AS total_paid,

    -- Operations metrics
    CASE
        WHEN o.delivered_date IS NOT NULL THEN 1 ELSE 0
    END AS is_delivered,

    CASE
        WHEN o.delivered_date IS NOT NULL AND o.order_date IS NOT NULL
        THEN CAST(julianday(o.delivered_date) - julianday(o.order_date) AS INTEGER)
        ELSE NULL
    END AS delivery_days,

    CASE
        WHEN o.delivered_date IS NOT NULL
         AND o.estimated_delivery_date IS NOT NULL
         AND julianday(o.delivered_date) <= julianday(o.estimated_delivery_date)
        THEN 1 ELSE 0
    END AS is_on_time

FROM stg_orders o
JOIN stg_order_items i
  ON o.order_id = i.order_id
LEFT JOIN payment_totals p
  ON o.order_id = p.order_id;
