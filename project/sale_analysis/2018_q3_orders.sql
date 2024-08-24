WITH order_date AS (
    SELECT
        (order_item.order_item_id * order_item.price) + (order_item.order_item_id * order_item.freight_value) AS order_value,
        EXTRACT(MONTH FROM order_detail.order_purchase_timestamp) AS month,
        EXTRACT(YEAR FROM order_detail.order_purchase_timestamp) AS year
    FROM
        olist_order_items_dataset AS order_item
        LEFT JOIN olist_orders_dataset AS order_detail
        ON order_item.order_id = order_detail.order_id
    WHERE 
        order_detail.order_status = 'delivered'
)
    SELECT
        year,
        month,
        SUM(order_value) AS monthly_revenue
    FROM
        order_date
    WHERE
        year = 2018
        AND month >=7
    GROUP BY
        year,month
    ORDER BY
        year,month
