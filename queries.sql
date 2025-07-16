-- ALL CUSTOMERS
SELECT * FROM Customers;


-- Top 5 Customers by Lifetime Spend
SELECT 
	c.customer_id,
	c.name,
	c.region,
	SUM(o.total_amount) AS Total_spent,
	COUNT(o.order_id) AS Total_orders
FROM
	customers c
JOIN
	orders o ON c.customer_id= o.customer_id
GROUP BY c.customer_id, c.name, c.region
ORDER BY Total_spent DESC
LIMIT 5;

-- products with their total number of orders and total quantity sold
SELECT 
	p.product_id,
	p.name,
	COUNT(DISTINCT oi.order_id) AS Total_orders,
	SUM(oi.quantity) AS Total_quantity_sold
FROM
	products p
JOIN
	order_items oi ON p.product_id = oi.product_id
GROUP BY 
	p.product_id,
	p.name
ORDER BY
	Total_quantity_sold DESC;

--  Top 5 Products by Revenue
SELECT 
	p.product_id,
	p.name,
	p.category,
	SUM(oi.price * oi.quantity) AS Revenue,
	COUNT(oi.product_id) AS Unit_sold
FROM
	products p
JOIN 
	order_items oi ON p.product_id = oi.product_id
GROUP BY 
	p.product_id,
	p.name,
	p.category
ORDER BY
	revenue DESC
LIMIT
	5;

-- Monthly Revenue Trend by Region
SELECT
	c.region,
	DATE_TRUNC('month', o.order_date) AS month,
	SUM(o.total_amount) AS Total_revenue
FROM
	customers c
JOIN
	orders o ON c.customer_id = o.customer_id
GROUP BY
	c.region,
	DATE_TRUNC('month', o.order_date)
ORDER BY
	c.region,
	month;

-- All customers who have spent more than ₦200,000 in total
SELECT
	c.customer_id,
	c.name,
	SUM(o.total_amount) AS Total_spent
FROM
	customers c
JOIN
	orders o ON c.customer_id = o.customer_id
GROUP BY
	c.customer_id,
	c.name
HAVING SUM(o.total_amount) > 200000
ORDER BY Total_spent DESC;

--All orders that have been returned
SELECT 
    o.order_id,
    o.order_date,
    o.total_amount,
    r.reason,
    r.amount_refunded
FROM orders o
JOIN returns r ON o.order_id = r.order_id
ORDER BY o.order_date DESC;

-- Rank customers by spending per region
SELECT 
    c.region,
    c.name,
    SUM(o.total_amount) AS total_spent,
    RANK() OVER (PARTITION BY c.region ORDER BY SUM(o.total_amount) DESC) AS spending_rank
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.region, c.name
ORDER BY c.region, spending_rank;

-- 