SELECT
    seller_state,
    COUNT(order_id) AS order_count
FROM
    olist_order_items_dataset AS order_item
LEFT JOIN olist_sellers_dataset AS seller
    ON order_item.seller_id = seller.seller_id
GROUP BY
    seller_state
ORDER BY
    order_count DESC
LIMIT 5
