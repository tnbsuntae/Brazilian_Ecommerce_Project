
SELECT
    COUNT(CASE WHEN order_delivered_customer_date IS NOT NULL THEN 1 END) AS delivered_order,
    COUNT(order_purchase_timestamp) AS ongoing_order
FROM 
    olist_orders_dataset
WHERE
    EXTRACT(MONTH FROM order_purchase_timestamp) = 9
    AND EXTRACT(YEAR FROM order_purchase_timestamp) = 2018