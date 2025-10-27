###  Top 3 produkty w każdej kategorii wg przychodów
Cel biznesowy: Zidentyfikować najlepiej sprzedające się produkty w każdej kategorii.





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
WHERE CTE.POSITION <= 3
