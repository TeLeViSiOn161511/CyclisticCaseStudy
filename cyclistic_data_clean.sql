-- data cleaning v2

-- 1. Checking for null values in every column
SELECT 
	COUNT(*) - COUNT(ride_id) AS ride_id,
    COUNT(*) - COUNT(rideable_type) AS rideable_type,
    COUNT(*) - COUNT(started_at) AS started_at,
    COUNT(*) - COUNT(ended_at) AS ended_at,
    COUNT(*) - COUNT(start_station_name) AS start_station_name,
    COUNT(*) - COUNT(start_station_id) AS start_station_id,
    COUNT(*) - COUNT(end_station_name) AS end_station_name,
    COUNT(*) - COUNT(end_station_id) AS end_station_id,
    COUNT(*) - COUNT(start_lat) AS start_lat,
    COUNT(*) - COUNT(start_lng) AS start_lng,
    COUNT(*) - COUNT(end_lat) AS end_lat,
    COUNT(*) - COUNT(end_lng) AS end_lng,
    COUNT(*) - COUNT(member_casual) AS member_casual
FROM cd_stage1;


-- 2a. Checking ride_id duplicates, 144925
SELECT COUNT(*) - COUNT(DISTINCT ride_id, rideable_type, started_at, ended_at, member_casual) AS num_duplicates
FROM combined_data;

WITH duplicate_cte AS(
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY ride_id, rideable_type, started_at, ended_at, member_casual) AS row_num
	FROM combined_data
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- 2b. Create staging table
CREATE TABLE `cd_stage1` (
  `ride_id` varchar(50) DEFAULT NULL,
  `rideable_type` varchar(50) DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `ended_at` datetime DEFAULT NULL,
  `start_station_name` varchar(100) DEFAULT NULL,
  `start_station_id` varchar(50) DEFAULT NULL,
  `end_station_name` varchar(100) DEFAULT NULL,
  `end_station_id` varchar(50) DEFAULT NULL,
  `start_lat` float DEFAULT NULL,
  `start_lng` float DEFAULT NULL,
  `end_lat` float DEFAULT NULL,
  `end_lng` float DEFAULT NULL,
  `member_casual` varchar(50) DEFAULT NULL,
  `row_num` INT,
  KEY `index_ride_id` (`ride_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO cd_stage1
SELECT *,
	ROW_NUMBER() OVER(PARTITION BY ride_id, rideable_type, started_at, ended_at, member_casual) AS row_num
FROM combined_data;

-- 2c. Remove duplicates
DELETE
FROM cd_stage1
WHERE row_num > 1;


-- 3. Check rideable_type and member_casual values
SELECT DISTINCT rideable_type
FROM cd_stage1;

SELECT DISTINCT member_casual
FROM cd_stage1;
