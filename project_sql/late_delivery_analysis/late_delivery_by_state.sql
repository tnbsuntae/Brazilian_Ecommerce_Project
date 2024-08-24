
WITH seller_delivery AS (
    SELECT
        seller_state,
        CASE
            WHEN order_delivered_customer_date > order_estimated_delivery_date THEN TRUE
            ELSE FALSE
        END AS is_late_delivery
    FROM 
        olist_orders_dataset AS order_detail
    LEFT JOIN olist_order_items_dataset AS order_item
        ON order_detail.order_id = order_item.order_id
    LEFT JOIN olist_sellers_dataset AS seller
        ON order_item.seller_id = seller.seller_id
    WHERE
        order_status = 'delivered'
), late_delivery AS (
    SELECT
        seller_state,
        COUNT(is_late_delivery) AS late_count
    FROM
        seller_delivery
    WHERE
        is_late_delivery = TRUE
    GROUP BY
        seller_state
), delivery AS (
    SELECT
        seller_state,
        COUNT(is_late_delivery) AS delivery_count
    FROM
        seller_delivery
    GROUP BY
        seller_state
)
SELECT
    late_delivery.seller_state,
    late_delivery.late_count,
    delivery.delivery_count,
    ROUND(late_delivery.late_count * 100.0 / delivery.delivery_count, 2) AS late_percentage
FROM
    late_delivery
LEFT JOIN delivery
    ON late_delivery.seller_state = delivery.seller_state
WHERE
    delivery.delivery_count > 100
ORDER BY
    late_percentage DESC