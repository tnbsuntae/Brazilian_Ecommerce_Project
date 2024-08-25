# Introduction
📊 This project analyzes Brazilian e-commerce data from 2016 to 2018, focusing on two main areas: sales trends 📈 and delivery performance 🚚. The sales analysis examines quarterly revenue to identify growth patterns and the top-selling products each quarter 🛍️. The delivery analysis investigates late deliveries to uncover potential areas for operational improvement 🔍. This study aims to provide valuable insights into both market trends and service efficiency ✨.

🔍 SQL queries? Check them out here: [project folder](/project_sql/)
    
# Backgroud
Brazil's e-commerce market has experienced significant growth 📊 over the past few years, becoming one of the largest in Latin America. With the rapid expansion of online shopping 🛒, understanding sales trends and delivery performance is crucial for businesses looking to optimize their operations and enhance customer satisfaction. This dataset, sourced from Kaggle 📚, provides a comprehensive look at e-commerce transactions from 2016 to 2018, including detailed information on orders, products, customers, and logistics 🚚.

By analyzing this data, we can uncover patterns in consumer behavior 👥, identify top-performing products 🏆, and understand the factors contributing to late deliveries ⏰. These insights can help businesses make informed decisions to drive sales and improve service quality, ultimately enhancing the overall customer experience in the competitive e-commerce landscape 🌐.

# Tools I Used
Throughout this project, several tools were utilized to analyze and manage the data effectively:

- **SQL:** Employed for querying the data to identify insights and trends 📊.
- **PostgreSQL:** Used as the database management system to handle and organize the data 💾.
- **Visual Studio Code:** Utilized for managing and executing SQL queries, offering a streamlined coding environment 🖥️.
- **Git & GitHub:** Leveraged for version control and sharing SQL scripts and analysis, ensuring collaborative and organized project management 🌐.

# The Analysis
### Sales Analysis
The goal of analyzing the ecommerce sales data is to uncover the key factors affecting business performance. This analysis focuses on all successful orders, specifically those marked with the status "delivered."

Initially, the quarterly revenue of the entire ecommerce platform was examined to assess the growth of the business in Brazil.

The analysis reveals a significant increase in revenue throughout 2017 and the first half of 2018. However, there is a notable decline in the third quarter of 2018, with revenue dropping sharply from approximately 3.7 million to 2.2 million.

🔍 Check the query of this analysis here: [quarterly revenue](/project_sql/sale_analysis/quarterly_revenue.sql)

![alt text](asset/quarterly_revenue.png)
_Line graph visualizing quarterly revenue from 2016 Q3 to 2018 Q3_

To gain a deeper understanding of the decline observed in the third quarter of 2018, the monthly revenue for this period was closely examined.

It was discovered that there is no data available for September 2018. This absence may account for the significant drop in revenue, given that the other two months in the quarter each generated substantial revenue of approximately 1 million. Further investigation is needed to understand what happened in September.

🔍 Check the query of this analysis here: [revenue in 2018 Q3](/project_sql/sale_analysis/2018_q3_orders.sql)

![alt text](asset/q3_2018_revenue.png)
_Bar graph visualizing monthly revenue in 2018 Q3_

The database contains only 16 ongoing orders and no completed shipments for September 2018. It appears the data may have been truncated before all entries for this month were updated, as it is highly unlikely that only 16 orders were placed in an entire month. Therefore, it is not feasible to accurately assess the performance of Q3 2018 with the available data.

🔍 Check the query of this analysis here: [September 2018's Orders](/project_sql/sale_analysis/2018_09_orders.sql)

| Order Status |  Count  |
|:------------:|:-------:|
| On-going     |16       |
| Delivered    |0        |

_Table indicating the number of orders in September 2018_

The top three best-selling product categories for each quarter were examined to determine if there are any indications of seasonality over the seven quarters from Q1 2017 to Q3 2018. Data from 2016 was not considered in this analysis due to the relatively low revenue in that year, which would not provide meaningful insights when compared to the following two years.

Based on the visualization of the quarterly reports, there is no clear indication of seasonality due to the diversity of best-selling products in each quarter. However, some trends are observable for specific product categories:

- Products in the "bed bath table" category consistently performed well across all quarters. This suggests that further exploration into this category could provide valuable insights and help develop strategies to strengthen product offerings.
- Throughout 2017, the "sport leisure" category garnered significant interest from customers. It could be beneficial to analyze which specific products were most popular and whether these products are associated with any events during that period. This information could help the company plan special campaigns aligned with relevant events.
- The "health and beauty" category showed increased attention in the first half of 2018. Investigating market trends related to this category could reveal factors such as product launches by specific brands or celebrity endorsements that influenced consumer behavior, providing opportunities to capitalize on these trends.

🔍 Check the query of this analysis here: [Best Seller Categories](/project_sql/sale_analysis/top_categories.sql)

![alt text](asset/top_categories_by_quarter.png)
_Bar graph visualizing the top three best seller categories in each quarter_
# What I Learned

# Conclusion