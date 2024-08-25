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
), quaterly_order AS (
    SELECT
        year,
        CASE
            WHEN month <= 3 THEN 'Q1'
            WHEN month <= 6 THEN 'Q2'
            WHEN month <= 9 THEN 'Q3'
            ELSE 'Q4'
        END AS quarter,
        order_value
    FROM
        order_date
)
SELECT
    CONCAT(year, ' ', quarter) AS quarter,
    SUM(order_value) AS quarterly_revenue
FROM
    quaterly_order
GROUP BY
    year,quarter
ORDER BY
    year,quarter