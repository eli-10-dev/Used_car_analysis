SELECT
	MIN(selling_price) AS min_selling_price,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY selling_price) AS q1,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY selling_price) AS median,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY selling_price) AS q3,
	MAX(selling_price) AS max_selling_price,
	(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY selling_price) - 1.5 
	 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY selling_price) 
	 - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY selling_price))) AS price_lower_outlier,
	(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY selling_price) + 1.5
	 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY selling_price) 
	 - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY selling_price))) AS price_upper_outlier
FROM car_data_raw;
