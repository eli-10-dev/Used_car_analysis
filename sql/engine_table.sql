--CREATE TABLE engine_comparison_table AS
SELECT
	engine,
	COUNT(*),
	ROUND(AVG(mileage::NUMERIC), 2) AS avg_mileage,
	ROUND(AVG(km_driven), 2) AS avg_km_driven,
	ROUND(AVG(selling_price), 2) AS avg_selling_price
FROM car_data_raw
WHERE
	seller_type = 'Individual'
	AND transmission = 'Manual'
	AND owner = 'First_Owner' 
	AND seats = 5
GROUP BY engine
ORDER BY engine
;
