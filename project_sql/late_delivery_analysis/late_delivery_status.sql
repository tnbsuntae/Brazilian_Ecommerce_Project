WITH all_delivery AS (
    SELECT
        CASE
            WHEN order_delivered_customer_date > order_estimated_delivery_date THEN TRUE
            ELSE FALSE
        END AS late
    FROM 
        olist_orders_dataset
    WHERE
        order_status = 'delivered'
), late_delivery AS (
    SELECT
        COUNT(CASE WHEN late = TRUE THEN 1 END) AS late_count,
        COUNT(late) AS total_count
    FROM
        all_delivery
)
SELECT
    late_count,
    total_count,
    TO_CHAR((late_count * 100.0 / total_count), 'FM999.00') || '%' AS late_percentage
FROM
    late_delivery