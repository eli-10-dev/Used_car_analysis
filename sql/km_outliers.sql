SELECT
	MIN(km_driven) AS min_km_driven,
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY km_driven) AS q1,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY km_driven) AS median,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY km_driven) AS q3,
	MAX(km_driven) AS max_km_driven,
	(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY km_driven) - 1.5 
	 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY km_driven) 
	 - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY km_driven))) AS km_lower_outlier,
	(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY km_driven) + 1.5
	 * (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY km_driven) 
	 - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY km_driven))) AS km_upper_outlier
FROM car_data_raw;
