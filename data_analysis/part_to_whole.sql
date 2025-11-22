-- which categories contribute the most to the overall sales? --> Bikes
WITH category_sales
AS (
    SELECT p.category
        , SUM(s.sales) AS total_sales
    FROM gold.sales_fact s
    LEFT JOIN gold.new_product_dim p
        ON s.product_key = p.product_key
    GROUP BY p.category
    )
SELECT category
    , total_sales
    , CONCAT (round((cast(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2), '%') AS cat_sales_percent
FROM category_sales
ORDER BY cat_sales_percent DESC;

-- which categories contribute the most to the overall cutomers? --> Accessories
WITH category_sales
AS (
    SELECT p.category
        , COUNT(s.customer_key) AS total_customers
    FROM gold.sales_fact s
    LEFT JOIN gold.new_product_dim p
        ON s.product_key = p.product_key
    GROUP BY p.category
    )
SELECT category
    , total_customers
    , CONCAT (round((cast(total_customers AS FLOAT) / SUM(total_customers) OVER ()) * 100, 2), '%') AS cat_cust_percent
FROM category_sales
ORDER BY cat_cust_percent DESC;

-- which categories contribute the most to the overall quantity? --> Accessories
WITH category_sales
AS (
    SELECT p.category
        , SUM(s.quantity) AS total_quantity
    FROM gold.sales_fact s
    LEFT JOIN gold.new_product_dim p
        ON s.product_key = p.product_key
    GROUP BY p.category
    )
SELECT category
    , total_quantity
    , CONCAT (round((cast(total_quantity AS FLOAT) / SUM(total_quantity) OVER ()) * 100, 2), '%') AS cat_quantity_percent
FROM category_sales
ORDER BY cat_quantity_percent DESC;

-- which categories contribute the most to the overall price? --> Bikes
WITH category_sales
AS (
    SELECT p.category
        , SUM(s.price) AS total_price
    FROM gold.sales_fact s
    LEFT JOIN gold.new_product_dim p
        ON s.product_key = p.product_key
    GROUP BY p.category
    )
SELECT category
    , total_price
    , CONCAT (round((cast(total_price AS FLOAT) / SUM(total_price) OVER ()) * 100, 2), '%') AS cat_price_percent
FROM category_sales
ORDER BY cat_price_percent DESC;