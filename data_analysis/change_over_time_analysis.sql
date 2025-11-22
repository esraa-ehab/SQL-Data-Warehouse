-- performance over time (by year only)
SELECT YEAR(order_date)
    , SUM(sales) AS total_sales
    , COUNT(DISTINCT customer_key) AS total_customers
    , SUM(quantity) AS total_quantity
FROM gold.sales_fact
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);

-- performance over time (by year and month)
SELECT DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS order_date
    , SUM(sales) AS total_sales
    , COUNT(DISTINCT customer_key) AS total_customers
    , SUM(quantity) AS total_quantity
FROM gold.sales_fact
WHERE order_date IS NOT NULL
GROUP BY DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1)
ORDER BY DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1);

------------------------
-- cumulative analysis
------------------------
-- how the business is growing?
SELECT order_date
    , SUM(total_sales) OVER (PARTITION BY order_date ORDER BY order_date) as cum_total_sales
    , SUM(total_customers) OVER (PARTITION BY order_date ORDER BY order_date) as cum_total_quantity
    , SUM(total_quantity) OVER (PARTITION BY order_date ORDER BY order_date) as cum_total_quantity
    , AVG(average_price) OVER (PARTITION BY order_date ORDER BY order_date) as cum_average_price
FROM(
SELECT DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS order_date
    , SUM(sales) AS total_sales
    , COUNT(DISTINCT customer_key) AS total_customers
    , SUM(quantity) AS total_quantity
    , AVG(price) as average_price
FROM gold.sales_fact
WHERE order_date IS NOT NULL
GROUP BY DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1)) t
ORDER BY order_date