WITH order_product_status AS (
    SELECT
        product.product_category_name,
        product_trans.product_category_name_english,
        order_item.order_item_id * product.product_weight_g AS order_weight_g,
        order_item.order_item_id * product.product_length_cm * product.product_height_cm * product.product_width_cm AS order_volume_cm3,
        CASE
            WHEN order_delivered_customer_date > order_estimated_delivery_date THEN TRUE
            ELSE FALSE
        END AS is_late_delivery
    FROM
        olist_orders_dataset AS order_detail
    LEFT JOIN olist_order_items_dataset AS order_item
        ON order_detail.order_id = order_item.order_id
    LEFT JOIN olist_products_dataset AS product
        ON order_item.product_id = product.product_id
    LEFT JOIN product_category_name_translation as product_trans
        ON product.product_category_name = product_trans.product_category_name
    WHERE 
        order_status = 'delivered'
        AND product.product_category_name IS NOT NULL 
        AND product.product_weight_g IS NOT NULL 
        AND product.product_length_cm IS NOT NULL
        AND product.product_height_cm IS NOT NULL
        AND product.product_width_cm IS NOT NULL
), product_cls AS (
    SELECT
        CASE
            WHEN order_weight_g > 10000 THEN 'heavy'
            ELSE 'light'
        END AS order_weight,
        CASE
            WHEN order_volume_cm3 > 100000 THEN 'large'
            ELSE 'small'
        END AS order_size,
        COUNT(is_late_delivery) AS late_count
    FROM
        order_product_status
    WHERE 
        is_late_delivery = TRUE
    GROUP BY
        order_weight,order_size
)
SELECT
    CASE
        WHEN order_weight = 'heavy' AND order_size = 'large' THEN 'heavy and large'
        WHEN order_weight = 'heavy' AND order_size = 'small' THEN 'heavy and small'
        WHEN order_weight = 'light' AND order_size = 'large' THEN 'light and large'
        ELSE 'light and small'
    END AS order_category,
    late_count
FROM
    product_cls
ORDER BY
    late_count DESC