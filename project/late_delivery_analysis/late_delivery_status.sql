SELECT
    order_id,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    CASE
        WHEN order_delivered_customer_date > order_estimated_delivery_date THEN TRUE
        ELSE FALSE
    END AS is_late_delivery
FROM 
    olist_orders_dataset
WHERE
    order_status = 'delivered'