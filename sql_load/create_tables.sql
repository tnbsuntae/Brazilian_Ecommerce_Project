-- Create olist_customers_dataset table with primary key
CREATE TABLE public.olist_customers_dataset
(
    customer_id VARCHAR(255) PRIMARY KEY,
    customer_unique_id VARCHAR(255),
    customer_zip_code_prefix VARCHAR(20),
    customer_city VARCHAR(100),
    customer_state VARCHAR(100)
);

-- Create olist_orders_dataset table with primary key
CREATE TABLE public.olist_orders_dataset
(
    order_id VARCHAR(255) PRIMARY KEY,
    customer_id VARCHAR(255),
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES public.olist_customers_dataset (customer_id)
);

-- Create olist_products_dataset table with primary key
CREATE TABLE public.olist_products_dataset
(
    product_id VARCHAR(255) PRIMARY KEY,
    product_category_name VARCHAR(255),
    product_name_lenght VARCHAR(50),
    product_description_lenght INT,
    product_photos_qty NUMERIC,
    product_weight_g NUMERIC,
    product_length_cm NUMERIC,
    product_height_cm NUMERIC,
    product_width_cm NUMERIC
);

-- Create olist_sellers_dataset table with primary key
CREATE TABLE public.olist_sellers_dataset
(
    seller_id VARCHAR(255) PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(50),
    seller_city VARCHAR(50),
    seller_state VARCHAR(50)
);

-- Create olist_customers_dataset table with primary key
CREATE TABLE public.olist_order_payments_dataset
(
    order_id VARCHAR(255),
    payment_sequential VARCHAR(255),
    payment_type VARCHAR(50),
    PRIMARY KEY (order_id, payment_sequential),
    payment_installments INT,
    payment_value NUMERIC,
    FOREIGN KEY (order_id) REFERENCES public.olist_orders_dataset (order_id)
);

-- Create olist_order_reviews_dataset table with primary key
CREATE TABLE public.olist_order_reviews_dataset
(
    review_id VARCHAR(255),
    order_id VARCHAR(255),
    PRIMARY KEY (review_id, order_id),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES public.olist_orders_dataset (order_id)
);

-- Create olist_order_items_dataset table with primary key
CREATE TABLE public.olist_order_items_dataset
(
    order_id VARCHAR(255),
    order_item_id INT,
    PRIMARY KEY (order_id, order_item_id),
    product_id VARCHAR(255),
    seller_id VARCHAR(255),
    shipping_limit_date TIMESTAMP,
    price NUMERIC,
    freight_value NUMERIC,
    FOREIGN KEY (order_id) REFERENCES public.olist_orders_dataset (order_id),
    FOREIGN KEY (product_id) REFERENCES public.olist_products_dataset (product_id),
    FOREIGN KEY (seller_id) REFERENCES public.olist_sellers_dataset (seller_id)
);

-- Create product_category_name_translation table with primary key
CREATE TABLE public.product_category_name_translation
(
    product_category_name VARCHAR(255),
    product_category_name_english VARCHAR(255)
);

-- Set ownership of the tables to the postgres user
ALTER TABLE public.olist_customers_dataset OWNER to postgres;
ALTER TABLE public.olist_order_payments_dataset OWNER to postgres;
ALTER TABLE public.olist_products_dataset OWNER to postgres;
ALTER TABLE public.olist_sellers_dataset OWNER to postgres;
ALTER TABLE public.olist_order_reviews_dataset OWNER to postgres;
ALTER TABLE public.olist_orders_dataset OWNER to postgres;
ALTER TABLE public.olist_order_items_dataset OWNER to postgres;
ALTER TABLE public.product_category_name_translation OWNER to postgres;