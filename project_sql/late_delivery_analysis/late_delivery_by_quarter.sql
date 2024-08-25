WITH late_by_month AS (
    SELECT
        EXTRACT(YEAR FROM order_estimated_delivery_date) AS year,
        EXTRACT(MONTH FROM order_estimated_delivery_date) AS month,
        CASE
            WHEN order_delivered_customer_date > order_estimated_delivery_date THEN TRUE
            ELSE FALSE
        END AS is_late_delivery
    FROM 
        olist_orders_dataset
    WHERE
        order_status = 'delivered'
), late_by_qt AS (
    SELECT
        year,
        CASE
            WHEN month <= 3 THEN 'Q1'
            WHEN month <= 6 THEN 'Q2'
            WHEN month <= 9 THEN 'Q3'
            ELSE 'Q4'
        END AS quarter,
        COUNT(is_late_delivery) AS late_count
    FROM
        late_by_month
    WHERE
        is_late_delivery = TRUE
    GROUP BY
        year, quarter
    ORDER BY
        year, quarter
)
SELECT
    CONCAT(year, ' ', quarter) AS quarter,
    late_count
FROM
    late_by_qt