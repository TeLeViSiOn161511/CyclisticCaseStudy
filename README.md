# Google Data Analytics Capstone Project: Cyclistic Case Study 

## About
This is a capstone project for the completion of the Google Data Analytics Certificate. In order to answer the following business questions, I will follow the steps of the data analysis process: *Ask*, *Prepare*, *Process*, *Analyse*, *Share*, and *Act*.
In this case study, I work for a fictional bike-share company, Cyclistic, to answer some business questions.

## Step 1: Ask
Business Task:

| Title | Improving Cyclistic’s Annual Membership |
| ----------- | ----------- |
| Background | Cyclistic’s financial analyst concluded that annual members are more profitable than casual riders. The marketing director believes that maximising the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets new customers, she believes there is an opportunity to convert casual riders into members as they are already aware of Cyclistic and have chosen Cyclistic for their mobility needs. |
| Opportunity | Converting casual riders into annual members will provide a more profitable growth for the future. |
| Objective | Use Cyclistic’s historical trip data to analyse how annual members and casual riders use Cyclistic bikes differently. |
| Expected Outcome | 3 recommendations on how to turn casual riders to annual members based on the analysis made. |

## Step 2: Prepare
Data Source:

For the purpose of this case study, I will be using Cyclistic’s historical trip dataset from January 2024 to December 2024, which was sourced from this [link](https://divvy-tripdata.s3.amazonaws.com/index.html). The data has been made publicly available by Motivate International Inc. under the [license](https://divvybikes.com/data-license-agreement) *Lyft Bikes and Scooters, LLC (“Bikeshare”)*.

Metadata:

The datasets are stored in spreadsheets. There are twelve .csv files in total and each file are consistent with 13 column attributes, which are:

| Attribute | Description |
| ----- | ----- |
| `ride_id` | Unique identifier for each bike ride. |
| `rideable_type` | Categorisation of the bike used in the ride |
| `started_at` | Timestamp of when the ride started (formatted in: dd/mm/yyyy hh:mm:ss) |
| `ended_at` | Timestamp of when the ride ended (formatted in: dd/mm/yyyy hh:mm:ss) |
| `start_station_name` | Name of the bike station where the ride started |
| `start_station_id` | Unique identifier of the starting station |
| `end_station_name` | Name of the bike station where the ride ended |
| `end_station_id` | Unique identifier of the ending station |
| `start_lat` | Latitude coordinates of the starting station |
| `start_lng` | Longitude coordinate of the starting station |
| `end_lat` | Latitude coordinates of the starting station |
| `end_lng` | Longitude coordinate of the ending station |
| `member_casual` | Categorisation of the rider as an annual member of casual rider |

## Step 3: Process
1. After downloading the necessary files, folders are created to store a copy of the original data in .csv and .xls format.
<img width="940" height="69" alt="image" src="https://github.com/user-attachments/assets/1c0a538e-b18c-4d8f-870f-468890ddbed5" />
   
2. Using the .xls files, initial data cleaning was performed using Microsoft Excel. In each file, the format of columns `started_at` and `ended_at` is changed from `dd/mm/yyyy hh:mm:ss` to `yyyy-mm-dd hh:mm:ss`.
3. Next, the files are then uploaded into a MySQL database for further processing and analysis due to its extremely large size. All 12 files are combined into one large dataset and stored in a new table `combined_data`, which contains a total of 6,005,441 data rows.
4. The cleaning steps in MySQL are as follows:
   - Checking for null values for each column and remove rows if `ride_id` contains null values. The table below shows the number of null values in each column. There are no null values present in `ride_id`, therefore no rows are removed.
   <img width="940" height="42" alt="image" src="https://github.com/user-attachments/assets/acfa0367-3db7-431e-8b24-c8154d4c9024" />
   
   - Duplicates are checked for removal.
     * There were 144,925 duplicated rows. Below is an example of a duplicated row.
     <img width="940" height="46" alt="image" src="https://github.com/user-attachments/assets/e17ce9b2-7485-4e23-b7ec-748da58e0f11" />

     * Used `ROW_NUMBER()` to remove duplicates. Duplicates are checked by rows having the same `ride_id`, `rideable_type`, `started_at`, `ended_at`, & `member_casual`. Rows containing null values were excluded.
     * A staging table `cd_stage1` was created to safely clean and preprocess data before analysis.
     * After removing duplicates, there are now 5,860,516 remaining rows.
   - Check values in columns `rideable_type` and `member_casual` for any misspellings. Based on the results below, there are 3 distinct types of rides and 2 distinct types of riders.
     <img width="198" height="144" alt="image" src="https://github.com/user-attachments/assets/f15e61a5-2025-4438-a005-a0efab854bae" />
     <img width="188" height="116" alt="image" src="https://github.com/user-attachments/assets/ed07d9d2-eb37-4502-a582-6967e54d9b3f" />


5. The preprocessing steps in MySQL are as follows:
   - Create column `ride_length`, which is the length of each ride by subtracting column `started_at` from `ended_at`.
     - Used `TIME_TO_SEC(TIMEDIFF(ended_at, started_at))`
     - Values are stored as `INT` in the table, which corresponds to the length of the ride in seconds
   - Create column `ride_day`, which is the day of the week of each ride.
     * Used `DAYNAME(started_at)`
     * Values are stored as `VARCHAR(10)`, which corresponds to the lengths of the name of the days
   - Create column `ride_month`, which is the month of each ride.
     * Used `MONTH(started_at)`
     * Values stored as `INT`, which corresponds to the numeric value of each month
   - Create column `ride_hour`, which is the hour of each ride.
     * Used `HOUR(started_at)`
     * Values stored as `INT`

## Step 4-5: Analyse & Share
(to be continued)

## Step 6: Act
After identifying the differences between casual and member riders, here are three strategies I recommend for the purpose of persuading casual riders to become annual members:

1. The number of casual riders were at its highest in the third quarter, which is presumably summer during that period. Therefore, a summer event should be conducted for riders to ride the bikes in the summer to gain points in exchange for rewards like food delivery vouchers. Members get more exclusive rewards.
2. Casual riders rode the bikes longer and more frequent in the weekends and in the evening. Therefore, we should create an incentive, such as discounts for longer rides to members to ride for longer periods.
3. Casual riders are more located in parks and recreational areas. Therefore, marketing campaigns should be held in those areas for a higher exposure of persuading them to join the membership.

