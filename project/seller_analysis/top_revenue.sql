SELECT
    seller_state,
    SUM((order_item_id * price) + (order_item_id * freight_value)) AS sum_order_value
FROM
    olist_order_items_dataset AS order_item
LEFT JOIN olist_sellers_dataset AS seller
    ON order_item.seller_id = seller.seller_id
GROUP BY
    seller_state
ORDER BY
    sum_order_value DESC
LIMIT 5
