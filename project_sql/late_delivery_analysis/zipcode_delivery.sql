WITH zipcode_comparison AS (
    SELECT
        order_detail.order_id,
        CASE
            WHEN customer.customer_zip_code_prefix = seller.seller_zip_code_prefix THEN TRUE
            ELSE FALSE
        END AS is_same_zipcode
    FROM
        olist_orders_dataset AS order_detail
    LEFT JOIN olist_customers_dataset as customer
        ON order_detail.customer_id = customer.customer_id
    LEFT JOIN olist_order_items_dataset as order_item
        ON order_detail.order_id = order_item.order_id
    LEFT JOIN olist_sellers_dataset as seller
        ON order_item.seller_id = seller.seller_id
    WHERE
        order_detail.order_status = 'delivered'
)
SELECT
    is_same_zipcode,
    COUNT(order_id) AS order_count
FROM
    zipcode_comparison
GROUP BY
    is_same_zipcode

