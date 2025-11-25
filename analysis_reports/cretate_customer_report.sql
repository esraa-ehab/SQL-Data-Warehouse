CREATE VIEW gold.customers_report AS
WITH base_query AS (
    -- retrieve core columns from sales fact and customer dimension 
    SELECT s.order_number
        , s.product_key
        , s.order_date
        , s.sales
        , s.quantity
        , c.customer_key
        , customer_number
        , CONCAT(c.frist_name, ' ', c.last_name) as customer_name
        , DATEDIFF(YEAR, c.birthdate, GETDATE()) as age
    FROM gold.sales_fact s
    LEFT JOIN gold.customer_dim c on s.customer_key = c.customer_key
), 
customer_aggregations AS (
    -- summarize key metrics on the customer level
    SELECT customer_key
        , customer_number
        , customer_name
        , age
        , COUNT(DISTINCT order_number) as total_orders
        , COUNT(DISTINCT product_key) as total_products
        , SUM(quantity) as total_quantity
        , SUM(sales) as total_sales
        , DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) as lifespan
        , MAX(order_date) as latest_order
    FROM base_query
    GROUP BY customer_key
        , customer_number
        , customer_name
        , age
) 
-- combine all cutomers metrics in one result
SELECT customer_key
    , customer_number
    , customer_name
    , CASE 
        WHEN age < 20 THEN 'Less than 20'
        WHEN age BETWEEN 20 and 29 THEN '20-29'
        WHEN age BETWEEN 30 and 39 THEN '30-39'
        WHEN age BETWEEN 40 and 49 THEN '40-49'
        ELSE '50 and above'
    END as age_group
    , CASE 
        WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN lifespan >= 12 AND total_sales < 5000 THEN 'Regular'
        ELSE 'New'
    END AS customer_class
    , total_orders
    , total_products
    , total_quantity
    , total_sales
    , latest_order
    , DATEDIFF(MONTH, latest_order, GETDATE()) as recency_in_months
    , CASE 
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS average_order_value
    , CASE 
        WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS avgerage_monthly_spendings
FROM customer_aggregations