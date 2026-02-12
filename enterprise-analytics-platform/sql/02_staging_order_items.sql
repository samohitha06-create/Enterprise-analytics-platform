-- ========================================
-- STAGING: Order Items
-- ========================================

DROP TABLE IF EXISTS stg_order_items;

CREATE TABLE stg_order_items AS
SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    DATE(shipping_limit_date) AS shipping_limit_date,
    CAST(price AS REAL) AS price,
    CAST(freight_value AS REAL) AS freight_value
FROM olist_order_items
WHERE order_id IS NOT NULL
  AND product_id IS NOT NULL
  AND seller_id IS NOT NULL;
