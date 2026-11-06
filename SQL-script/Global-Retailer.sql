-- Q1. Overall Sales Performance
SELECT COUNT(DISTINCT s.order_number) AS total_orders,
       SUM(s.quantity) AS total_units,
       ROUND(SUM(s.quantity * p.unit_price_usd), 2) AS total_revenue_usd,
       ROUND(SUM(s.quantity * (p.unit_price_usd - p.unit_cost_usd)), 2) AS total_gross_profit_usd,
       ROUND(SUM(s.quantity * p.unit_price_usd) / COUNT(DISTINCT s.order_number), 2) AS avg_order_value_usd
FROM sales s JOIN products p ON s.productkey = p.productkey;

-- Q2. Monthly Sales Trend
SELECT EXTRACT(YEAR FROM s.order_date) AS sales_year,
       EXTRACT(MONTH FROM s.order_date) AS sales_month,
       COUNT(DISTINCT s.order_number) AS orders,
       SUM(s.quantity) AS units_sold,
       ROUND(SUM(s.quantity * p.unit_price_usd), 2) AS revenue_usd
FROM sales s JOIN products p ON s.productkey = p.productkey
GROUP BY sales_year, sales_month
ORDER BY sales_year, sales_month;

-- Q3. Top 10 Best-Selling Products (by units)
SELECT p.productkey, p.product_name, p.category,
       SUM(s.quantity) AS units_sold
FROM sales s JOIN products p ON s.productkey = p.productkey
GROUP BY p.productkey, p.product_name, p.category
ORDER BY units_sold DESC
LIMIT 10;

-- Q4. Country-Wise Sales Performance (by customer country)
SELECT c.country,
       COUNT(DISTINCT s.order_number) AS orders,
       ROUND(SUM(s.quantity * p.unit_price_usd), 2) AS revenue_usd,
       ROUND(100.0 * SUM(s.quantity * p.unit_price_usd)
             / SUM(SUM(s.quantity * p.unit_price_usd)) OVER (), 1) AS revenue_share_pct
FROM sales s
JOIN products p ON s.productkey = p.productkey
JOIN customers c ON s.customerkey = c.customerkey
GROUP BY c.country
ORDER BY revenue_usd DESC;

-- Q5. Top 10 Highest-Revenue Products
SELECT p.productkey, p.product_name, p.category,
       ROUND(SUM(s.quantity * p.unit_price_usd), 2) AS revenue_usd
FROM sales s JOIN products p ON s.productkey = p.productkey
GROUP BY p.productkey, p.product_name, p.category
ORDER BY revenue_usd DESC
LIMIT 10;

-- Q6. Store Performance Analysis
SELECT st.storekey, st.country, st.state, st.square_meters,
       COUNT(DISTINCT s.order_number) AS orders,
       ROUND(SUM(s.quantity * p.unit_price_usd), 2) AS revenue_usd,
       ROUND(SUM(s.quantity * p.unit_price_usd) / st.square_meters, 2) AS revenue_per_sqm,
       RANK() OVER (ORDER BY SUM(s.quantity * p.unit_price_usd) DESC) AS revenue_rank
FROM sales s
JOIN products p ON s.productkey = p.productkey
JOIN stores st ON s.storekey = st.storekey
WHERE s.storekey <> 0
GROUP BY st.storekey, st.country, st.state, st.square_meters
ORDER BY revenue_rank;

-- Q7. Customer Purchase Analysis
WITH cust AS (
    SELECT s.customerkey,
           COUNT(DISTINCT s.order_number) AS orders,
           SUM(s.quantity) AS units,
           SUM(s.quantity * p.unit_price_usd) AS spend
    FROM sales s JOIN products p ON s.productkey = p.productkey
    GROUP BY s.customerkey
)
SELECT COUNT(*) AS buying_customers,
       ROUND(AVG(orders), 2) AS avg_orders_per_customer,
       ROUND(AVG(spend), 2) AS avg_spend_per_customer_usd,
       ROUND(AVG(units), 2) AS avg_units_per_customer,
       ROUND(MAX(spend), 2) AS max_spend_usd
FROM cust;

-- Q8. Product Category Performance
SELECT p.category,
       SUM(s.quantity) AS units_sold,
       ROUND(SUM(s.quantity * p.unit_price_usd), 2) AS revenue_usd,
       ROUND(SUM(s.quantity * (p.unit_price_usd - p.unit_cost_usd)), 2) AS gross_profit_usd,
       ROUND(100.0 * SUM(s.quantity * (p.unit_price_usd - p.unit_cost_usd))
             / SUM(s.quantity * p.unit_price_usd), 1) AS margin_pct
FROM sales s JOIN products p ON s.productkey = p.productkey
GROUP BY p.category
ORDER BY revenue_usd DESC;

-- Q9. Customer Segmentation (spend quartiles)
WITH cust AS (
    SELECT s.customerkey,
           SUM(s.quantity * p.unit_price_usd) AS spend
    FROM sales s JOIN products p ON s.productkey = p.productkey
    GROUP BY s.customerkey
),
seg AS (
    SELECT customerkey, spend,
           NTILE(4) OVER (ORDER BY spend DESC) AS quartile
    FROM cust
)
SELECT CASE quartile WHEN 1 THEN 'Top 25% (VIP)'
                     WHEN 2 THEN 'Upper-mid'
                     WHEN 3 THEN 'Lower-mid'
                     ELSE 'Bottom 25%' END AS segment,
       COUNT(*) AS customers,
       ROUND(SUM(spend), 2) AS total_spend_usd,
       ROUND(100.0 * SUM(spend) / SUM(SUM(spend)) OVER (), 1) AS spend_share_pct,
       ROUND(AVG(spend), 2) AS avg_spend_usd
FROM seg
GROUP BY quartile
ORDER BY quartile;

-- Q10. Year-over-Year Sales Growth
WITH yearly AS (
    SELECT EXTRACT(YEAR FROM s.order_date) AS sales_year,
           SUM(s.quantity * p.unit_price_usd) AS revenue
    FROM sales s JOIN products p ON s.productkey = p.productkey
    GROUP BY sales_year
)
SELECT sales_year,
       ROUND(revenue, 2) AS revenue_usd,
       ROUND(LAG(revenue) OVER (ORDER BY sales_year), 2) AS prev_year_usd,
       ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY sales_year))
             / LAG(revenue) OVER (ORDER BY sales_year), 1) AS yoy_growth_pct
FROM yearly
ORDER BY sales_year;
