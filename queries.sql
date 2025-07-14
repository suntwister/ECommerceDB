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

-- Product Return Rate

	
