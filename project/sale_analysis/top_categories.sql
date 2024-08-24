WITH order_product AS (
    SELECT
        product.product_category_name,
        product_trans.product_category_name_english,
        EXTRACT(MONTH FROM order_detail.order_purchase_timestamp) AS month,
        EXTRACT(YEAR FROM order_detail.order_purchase_timestamp) AS year
    FROM
        olist_order_items_dataset AS order_item
    LEFT JOIN olist_orders_dataset AS order_detail
        ON order_item.order_id = order_detail.order_id
    LEFT JOIN olist_products_dataset AS product
        ON order_item.product_id = product.product_id
    LEFT JOIN product_category_name_translation as product_trans
        ON product.product_category_name = product_trans.product_category_name
    WHERE
    product.product_category_name IS NOT NULL
    AND order_detail.order_status = 'delivered'
), quaterly_order AS (
    SELECT
        product_category_name,
        product_category_name_english,
        year,
        CASE
            WHEN month <= 3 THEN 'Q1'
            WHEN month <= 6 THEN 'Q2'
            WHEN month <= 9 THEN 'Q3'
            ELSE 'Q4'
        END AS quarter
    FROM
        order_product
), count_of_product AS (
    SELECT
        year,
        quarter,
        product_category_name,
        product_category_name_english,
        COUNT(product_category_name) AS product_count
    FROM
        quaterly_order
    GROUP BY
        year,quarter,product_category_name,product_category_name_english
), rank_of_product AS (
    SELECT
        RANK() OVER (PARTITION BY year,quarter ORDER BY product_count DESC) AS sales_rank,
        year,
        quarter,
        product_category_name,
        product_category_name_english,
        product_count
    FROM
        count_of_product
)

SELECT
    sales_rank,
    year,
    quarter,
    product_category_name,
    product_category_name_english,
    product_count
FROM
    rank_of_product
WHERE
    year <> '2016'
    AND sales_rank <= 5
ORDER BY
    year, quarter, sales_rank