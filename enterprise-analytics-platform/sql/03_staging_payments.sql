-- ========================================
-- STAGING: Payments
-- ========================================

DROP TABLE IF EXISTS stg_payments;

CREATE TABLE stg_payments AS
SELECT
    order_id,
    payment_sequential,
    payment_type,
    CAST(payment_installments AS INTEGER) AS payment_installments,
    CAST(payment_value AS REAL) AS payment_value
FROM olist_order_payments
WHERE order_id IS NOT NULL;
