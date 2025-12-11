SELECT
	engine,
	COUNT (CASE WHEN transmission = 'Manual' 
		   AND selling_price < 1320000 
		   AND km_driven < 186062.5
		   THEN 1 END) AS manual_count,
	COUNT (CASE WHEN transmission = 'Automatic' 
		   AND selling_price < 1320000 
		   AND km_driven < 186062.5
		   THEN 1 END) AS automatic_count,
	ROUND(AVG(km_driven) FILTER (
		WHERE km_driven < 186062.5
		AND transmission = 'Manual'), 2) AS avg_manual_km_driven,
	ROUND(AVG(km_driven) FILTER (
		WHERE km_driven < 186062.5
		AND transmission = 'Automatic'), 2) AS avg_automatic_km_driven,
	ROUND(AVG(selling_price) FILTER (
		WHERE selling_price < 1320000
		AND transmission = 'Manual'), 2) AS avg_manual_price,
	ROUND(AVG(selling_price) FILTER (
		WHERE selling_price < 1320000
		AND transmission = 'Automatic'), 2) AS avg_automatic_price,
	ROUND(AVG(mileage::numeric) FILTER (
		WHERE selling_price < 1320000
		AND transmission = 'Manual'), 2) AS avg_manual_mileage,
	ROUND(AVG(mileage::numeric) FILTER (
		WHERE selling_price < 1320000
		AND transmission = 'Automatic'), 2) AS avg_automatic_mileage
FROM car_data_raw
WHERE
	fuel = 'Diesel'
	AND seller_type = 'Individual'
	AND owner  = 'First_Owner'
	AND seats = 5
GROUP BY engine
HAVING
	COUNT (CASE WHEN transmission = 'Manual' 
			   AND selling_price < 1320000 
		   	   AND km_driven < 186062.5
		       THEN 1 END) >= 1
	AND COUNT (CASE WHEN transmission = 'Automatic'
			   AND selling_price < 1320000 
		   	   AND km_driven < 186062.5
		       THEN 1 END) >= 1
ORDER BY engine;
