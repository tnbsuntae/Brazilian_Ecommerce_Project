WITH product_eng AS (
    SELECT
        product.product_id,
        product.product_category_name,
        product_trans.product_category_name_english
    FROM
        olist_products_dataset AS product
    LEFT JOIN product_category_name_translation as product_trans
        ON product.product_category_name = product_trans.product_category_name
    WHERE
        product.product_category_name IS NOT NULL
), order_to_product AS (
    SELECT
        order_item.order_id,
        order_item.seller_id,
        product_eng.product_category_name,
        product_eng.product_category_name_english
    FROM
        olist_order_items_dataset AS order_item
    LEFT JOIN product_eng
        ON order_item.product_id = product_eng.product_id
    WHERE product_eng.product_category_name IS NOT NULL
)
    
SELECT
        seller_state,
        order_to_product.product_category_name,
        order_to_product.product_category_name_english,
        COUNT(order_to_product.order_id) AS order_count
    FROM
        order_to_product
    LEFT JOIN olist_sellers_dataset AS seller
        ON order_to_product.seller_id = seller.seller_id
    WHERE
        seller_state = 'SC'
    GROUP BY
        seller_state,
        order_to_product.product_category_name,
        order_to_product.product_category_name_english
    ORDER BY
        order_count DESC
    LIMIT 5