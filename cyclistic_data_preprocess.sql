-- Data Preprocessing

SELECT *
FROM cd_stage1;

-- 1. Add ride_length column
ALTER TABLE cd_stage1
ADD COLUMN ride_length INT
AFTER ended_at;

UPDATE cd_stage1
SET ride_length = TIME_TO_SEC(TIMEDIFF(ended_at, started_at));


-- 2. Add ride_day column
ALTER TABLE cd_stage1
ADD COLUMN ride_day VARCHAR(10)
AFTER ride_length;

UPDATE cd_stage1
SET ride_day = DAYNAME(started_at);


-- 3. Add ride_month column
ALTER TABLE cd_stage1
ADD COLUMN ride_month INT
AFTER ride_day;

UPDATE cd_stage1
SET ride_month = MONTH(started_at);


-- 4. Add ride_hour column
ALTER TABLE cd_stage1
ADD COLUMN ride_hour INT
AFTER ride_month;

UPDATE cd_stage1
SET ride_hour = HOUR(started_at);


-- Finalise table: Remove row_num column
ALTER TABLE cd_stage1
DROP COLUMN row_num;

