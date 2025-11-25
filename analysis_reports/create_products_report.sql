CREATE VIEW gold.products_report AS 
WITH base_query AS (
    -- retrieve core columns from sales fact and customer dimension 
    SELECT s.order_number
        , s.product_key
        , p.product_name
        , p.product_cost
        , s.price
        , s.sales
        , s.quantity
        , p.category
        , p.subcategory
        , s.order_date
        , s.customer_key
    FROM gold.sales_fact s
    LEFT JOIN gold.new_product_dim p on s.product_key = p.product_key
    WHERE order_date IS NOT NULL
),  -- summarize key metrics on the product level
product_aggregations AS(
    SELECT product_key
        , product_name
        , category
        , subcategory 
        , product_cost
        , SUM(sales) as total_sales
        , SUM(quantity) as total_amount
        , DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) as lifespan  
        , COUNT(DISTINCT order_number) as total_orders
        , COUNT(DISTINCT customer_key) as total_customers
        , MAX(order_date) as latest_order
        , ROUND(AVG(CAST(sales as float) / NULLIF(quantity, 0)),2) AS avg_selling_price
    FROM base_query
    GROUP BY product_key
        , product_name
        , category
        , subcategory 
        , product_cost
)
-- combine all products metrics in one result
SELECT product_key
    , product_name
    , category
    , subcategory 
    , product_cost 
    , DATEDIFF(MONTH, latest_order, GETDATE()) as recency_in_months
    , CASE 
        WHEN total_sales > 50000 THEN 'Hign'
        WHEN total_sales >= 10000 THEN 'Mid'
        ELSE 'Low'
    END AS revenue_class
    , lifespan
    , total_orders
    , total_customers
    , total_sales
    , total_amount
    , avg_selling_price
    , CASE 
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS average_order_revenue
    , CASE 
        WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS avgerage_monthly_revenue
FROM product_aggregations