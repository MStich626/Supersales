-- Top 3 products in each category by revenue
-- Business Goal: Identify the best-selling products in each category.


WITH CTE AS
(
	SELECT  
		p."product_name",
		pg."group",
		pg."category",
		ROUND(SUM(op."item_quantity" * p."product_price") :: NUMERIC, 2) AS revenue,
		RANK() OVER (PARTITION BY pg."category" ORDER BY SUM(op."item_quantity" * p."product_price") DESC) AS POSITION
	FROM products_v2 p 
	JOIN product_groups pg ON pg."group_id" = p."group_id"
	JOIN order_positions op ON op."product_id" = p."product_id"
	GROUP BY 1,2,3
),
REV_BY_CATEGORY AS
(
	SELECT 
		pg."category",
		ROUND(SUM(op."item_quantity" * p."product_price") :: NUMERIC, 2) AS SUM_BY_CATEGORY
	FROM products_v2 p 
	JOIN product_groups pg ON pg."group_id" = p."group_id"
	JOIN order_positions op ON op."product_id" = p."product_id"
	GROUP BY 1
)
SELECT 
	CTE.*, 
	ROUND((CTE.revenue * 100) / REV_BY_CATEGORY.SUM_BY_CATEGORY::NUMERIC, 2) AS PERCENTAGE 
FROM CTE 
JOIN REV_BY_CATEGORY ON CTE."category" = REV_BY_CATEGORY."category" 
WHERE CTE.POSITION <= 3;




-- Most return products
-- Business Goal: Identify which products are most returned


WITH MOST_RETURN_PRODUCTS AS
(
	SELECT 
		p.product_name,
		COUNT(ordr.order_id) AS COUNT_OF_RETURNS
	FROM customers c JOIN orders ord ON c.customer_id = ord.customer_id
	JOIN order_positions op ON op.order_id = ord.order_id
	JOIN products_v2 p ON p.product_id = op.product_id
	JOIN order_returns ordr ON ordr.order_id = ord.order_id
	GROUP BY 1
),
TOTAL AS
(
	SELECT COUNT(order_r.order_id) AS SUM_OF_RETURNS FROM order_returns order_r
	JOIN order_positions op ON op.order_id = order_r.order_id
)
SELECT
	MOST_RETURN_PRODUCTS.*, 
	round(((MOST_RETURN_PRODUCTS.COUNT_OF_RETURNS * 100) / TOTAL.SUM_OF_RETURNS::NUMERIC), 2) 
	FROM MOST_RETURN_PRODUCTS JOIN TOTAL ON 1 = 1
	ORDER BY 2 DESC;






