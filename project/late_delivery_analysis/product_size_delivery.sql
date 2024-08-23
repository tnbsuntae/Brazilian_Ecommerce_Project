WITH product_dim AS (
    SELECT
        product.product_id,
        product.product_category_name,
        product_trans.product_category_name_english,
        product.product_weight_g,
        product.product_length_cm * product.product_height_cm * product.product_width_cm AS product_volume_cm3
    FROM
        olist_products_dataset AS product
    LEFT JOIN product_category_name_translation as product_trans
        ON product.product_category_name = product_trans.product_category_name
    WHERE
        product.product_category_name IS NOT NULL 
        AND product.product_weight_g IS NOT NULL 
        AND product.product_length_cm IS NOT NULL
        AND product.product_height_cm IS NOT NULL
        AND product.product_width_cm IS NOT NULL
    ORDER BY
        product.product_weight_g DESC, product_volume_cm3 DESC
), order_to_product AS (
    SELECT
        order_item.order_id,
        order_item.order_item_id,
        product_dim.product_category_name,
        product_dim.product_category_name_english,
        order_item.order_item_id * product_dim.product_weight_g AS order_weight_g,
        order_item.order_item_id * product_dim.product_volume_cm3 AS order_volume_cm3
    FROM
        olist_order_items_dataset AS order_item
    LEFT JOIN product_dim
        ON order_item.product_id = product_dim.product_id
    WHERE 
        product_dim.product_category_name IS NOT NULL 
        AND product_dim.product_weight_g IS NOT NULL 
        AND product_dim.product_volume_cm3 IS NOT NULL
), late_delivery AS (
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
)

SELECT
    order_to_product.order_id,
    order_to_product.order_item_id,
    order_to_product.product_category_name,
    order_to_product.product_category_name_english,
    CASE
        WHEN order_to_product.order_weight_g > 10000 THEN 'heavy'
        ELSE 'light'
    END AS order_weight,
    CASE
        WHEN order_to_product.order_volume_cm3 > 100000 THEN 'large'
        ELSE 'small'
    END AS order_size,
    late_delivery.is_late_delivery
FROM
    order_to_product
LEFT JOIN late_delivery
    ON order_to_product.order_id = late_delivery.order_id
WHERE
    is_late_delivery = TRUE