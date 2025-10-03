-- Data Combining

DROP TABLE IF EXISTS `combined_data`;

-- combining 12 monthly tables into one huge dataset from Jan-2024 to Dec-2024

CREATE TABLE IF NOT EXISTS `combined_data` AS (
	SELECT * FROM divvy_tripdata_202401
	UNION ALL
	SELECT * FROM divvy_tripdata_202402
	UNION ALL
	SELECT * FROM divvy_tripdata_202403
	UNION ALL
	SELECT * FROM divvy_tripdata_202404
	UNION ALL
	SELECT * FROM divvy_tripdata_202405
	UNION ALL
	SELECT * FROM divvy_tripdata_202406
	UNION ALL
	SELECT * FROM divvy_tripdata_202407
	UNION ALL
	SELECT * FROM divvy_tripdata_202408
	UNION ALL
	SELECT * FROM divvy_tripdata_202409
	UNION ALL
	SELECT * FROM divvy_tripdata_202410
	UNION ALL
	SELECT * FROM divvy_tripdata_202411
	UNION ALL
	SELECT * FROM divvy_tripdata_202412
);

-- Total number of observations:  6,005,441

SELECT COUNT(*) FROM combined_data;

