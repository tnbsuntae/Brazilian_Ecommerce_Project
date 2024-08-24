/* ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
Database Load Issues (follow if receiving permission denied when running SQL code below)

NOTE: If you are having issues with permissions. And you get error: 

'could not open file "[your file path]\job_postings_fact.csv" for reading: Permission denied.'

1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `sql_course` database
3. Right-click `sql_course` and select `PSQL Tool`
    - This opens a terminal window to write the following code
4. Get the absolute file path of your csv files
    1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
5. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy olist_customers_dataset FROM '/Users/suntaetangsatgatham/suntae/kaggle/brazilian_ecom_project/dataset/olist_customers_dataset.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy olist_products_dataset FROM '/Users/suntaetangsatgatham/suntae/kaggle/brazilian_ecom_project/dataset/olist_products_dataset.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy olist_sellers_dataset FROM '/Users/suntaetangsatgatham/suntae/kaggle/brazilian_ecom_project/dataset/olist_sellers_dataset.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy olist_orders_dataset FROM '/Users/suntaetangsatgatham/suntae/kaggle/brazilian_ecom_project/dataset/olist_orders_dataset.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy olist_order_items_dataset FROM '/Users/suntaetangsatgatham/suntae/kaggle/brazilian_ecom_project/dataset/olist_order_items_dataset.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy product_category_name_translation FROM '/Users/suntaetangsatgatham/suntae/kaggle/brazilian_ecom_project/dataset/product_category_name_translation.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
*/

COPY olist_customers_dataset
FROM '/Users/suntaetangsatgatham/suntae/kaggle/brazilian_ecom_project/dataset/olist_customers_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY olist_products_dataset
FROM '/Users/suntaetangsatgatham/suntae/kaggle/brazilian_ecom_project/dataset/olist_products_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY olist_sellers_dataset
FROM '/Users/suntaetangsatgatham/suntae/kaggle/brazilian_ecom_project/dataset/olist_sellers_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY olist_orders_dataset
FROM '/Users/suntaetangsatgatham/suntae/kaggle/brazilian_ecom_project/dataset/olist_orders_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY olist_order_items_dataset
FROM '/Users/suntaetangsatgatham/suntae/kaggle/brazilian_ecom_project/dataset/olist_order_items_dataset.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY product_category_name_translation
FROM '/Users/suntaetangsatgatham/suntae/kaggle/brazilian_ecom_project/dataset/product_category_name_translation.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');