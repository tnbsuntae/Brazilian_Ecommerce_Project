WITH late_by_month AS (
    SELECT
        order_detail.order_id,
        EXTRACT(YEAR FROM order_estimated_delivery_date) AS year,
        EXTRACT(MONTH FROM order_estimated_delivery_date) AS month,
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
        order_detail.order_status = 'delivered'
        AND seller.seller_state = 'MA'
), ma_late_delivey AS (
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
), ma_all_delivery AS (
    SELECT
        year,
        CASE
            WHEN month <= 3 THEN 'Q1'
            WHEN month <= 6 THEN 'Q2'
            WHEN month <= 9 THEN 'Q3'
            ELSE 'Q4'
        END AS quarter,
        COUNT(is_late_delivery) AS delivery_count
    FROM
        late_by_month
    GROUP BY
        year, quarter
    ORDER BY
        year, quarter
)
SELECT
    ma_all_delivery.year,
    ma_all_delivery.quarter,
    ma_late_delivey.late_count,
    ma_all_delivery.delivery_count,
    TO_CHAR((ma_late_delivey.late_count * 100.0 / ma_all_delivery.delivery_count), 'FM999.00') || '%' AS late_percentage
FROM
    ma_all_delivery
LEFT JOIN ma_late_delivey
    ON ma_all_delivery.year = ma_late_delivey.year 
    AND ma_all_delivery.quarter = ma_late_delivey.quarter 
