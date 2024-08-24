WITH order_date AS (
    SELECT
        order_id,
        order_status,
        order_purchase_timestamp,
        EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
        EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
        order_delivered_carrier_date,
        order_delivered_customer_date,
        order_estimated_delivery_date
    FROM 
        olist_orders_dataset
)

SELECT
    order_purchase_timestamp,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM 
    order_date
WHERE
    year = 2018 AND month = 9