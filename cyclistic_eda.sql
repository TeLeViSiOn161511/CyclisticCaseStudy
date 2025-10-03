-- Exploratory Data Analysis

-- A1. Observe total rides (overall)
SELECT member_casual, COUNT(*)
FROM cd_stage1
GROUP BY member_casual;

-- A2. Observe total rides (by ride type)
SELECT member_casual, rideable_type, COUNT(*)
FROM cd_stage1
GROUP BY member_casual, rideable_type
ORDER BY member_casual;


-- A3. Observe monthly frequency (by member type)
SELECT member_casual, ride_month, COUNT(*)
FROM cd_stage1
GROUP BY member_casual, ride_month
ORDER BY member_casual, ride_month;


-- A4. Observe weekly frequency
SELECT member_casual, ride_day, COUNT(*)
FROM cd_stage1
GROUP BY member_casual, ride_day
ORDER BY member_casual, COUNT(*) DESC;


-- A5. Observe hourly frequency
SELECT member_casual, ride_hour, COUNT(*)
FROM cd_stage1
GROUP BY member_casual, ride_hour
ORDER BY member_casual, ride_hour;



-- B1. Observe average length (overall)
SELECT 
	(
		SELECT SEC_TO_TIME(AVG(ride_length))
		FROM cd_stage1
	) AS avgLength_overall,
    (
		SELECT SEC_TO_TIME(AVG(ride_length))
		FROM cd_stage1
		WHERE member_casual = 'member\r'
    ) AS avgLength_member,
    (
		SELECT SEC_TO_TIME(AVG(ride_length))
		FROM cd_stage1
		WHERE member_casual = 'casual\r'   
    ) AS avgLength_casual;



-- B2. Max ride lengths
SELECT member_casual, SEC_TO_TIME(MAX(ride_length)) AS max_ride_length
FROM cd_stage1
GROUP BY member_casual;

SELECT member_casual, SEC_TO_TIME(ride_length) AS ride_length
FROM cd_stage1
WHERE member_casual = 'casual\r'
ORDER BY SEC_TO_TIME(ride_length) DESC;

SELECT member_casual, SEC_TO_TIME(ride_length) AS ride_length
FROM cd_stage1
WHERE member_casual = 'member\r'
ORDER BY SEC_TO_TIME(ride_length) DESC;



-- C1. Start station use
SELECT start_station_name,
	member_casual,
	AVG(start_lat) AS start_lat,
    AVG(start_lng) AS start_lng, 
    COUNT(ride_id) AS rides
FROM cd_stage1
GROUP BY start_station_name, member_casual;

SELECT start_station_name,
	TRIM('\r' FROM member_casual) AS member_casual,
	AVG(start_lat) as start_lat,
    AVG(start_lng) as start_lng,
    COUNT(ride_id)
FROM cd_stage1
WHERE TRIM('\r' FROM member_casual) = 'member'
GROUP BY start_station_name, TRIM('\r' FROM member_casual)
ORDER BY COUNT(ride_id) DESC;

SELECT start_station_name,
	TRIM('\r' FROM member_casual) AS member_casual,
	AVG(start_lat) as start_lat,
    AVG(start_lng) as start_lng,
    COUNT(ride_id)
FROM cd_stage1
WHERE TRIM('\r' FROM member_casual) = 'casual'
GROUP BY start_station_name, TRIM('\r' FROM member_casual)
ORDER BY COUNT(ride_id) DESC;

-- C2. End station use
SELECT end_station_name,
	member_casual,
	AVG(end_lat) AS end_lat,
    AVG(end_lng) AS end_lng, 
    COUNT(ride_id) AS rides
FROM cd_stage1
GROUP BY end_station_name, member_casual
ORDER BY COUNT(ride_id) DESC;

SELECT end_station_name,
	TRIM('\r' FROM member_casual) AS member_casual,
	AVG(end_lat) as end_lat,
    AVG(end_lng) as end_lng,
    COUNT(ride_id)
FROM cd_stage1
WHERE TRIM('\r' FROM member_casual) = 'member'
GROUP BY end_station_name, TRIM('\r' FROM member_casual)
ORDER BY COUNT(ride_id) DESC;

SELECT end_station_name,
	TRIM('\r' FROM member_casual) AS member_casual,
	AVG(end_lat) as end_lat,
    AVG(end_lng) as end_lng,
    COUNT(ride_id)
FROM cd_stage1
WHERE TRIM('\r' FROM member_casual) = 'casual'
GROUP BY end_station_name, TRIM('\r' FROM member_casual)
ORDER BY COUNT(ride_id) DESC;




