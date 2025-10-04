# Google Data Analytics Capstone Project: Cyclistic Case Study 

## About
<p>This is a capstone project for the completion of the Google Data Analytics Certificate. In order to answer the following business questions, I will follow the steps of the data analysis process: <i>Ask</i>, <i>Prepare</i>, <i>Process</i>, <i>Analyse</i>, <i>Share</i>, and <i>Act</i>.
In this case study, I work for a fictional bike-share company, Cyclistic, to answer some business questions.</p><br>


## Step 1: Ask
Business Task:
<table>
   <tr>
      <td>Title</td>
      <td>Improving Cyclistic’s Annual Membership</td>
   </tr>
   <tr>
      <td>Background</td>
      <td>Cyclistic’s financial analyst concluded that annual members are more profitable than casual riders. The marketing director believes that maximising the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets new customers, she believes there is an opportunity to convert casual riders into members as they are already aware of Cyclistic and have chosen Cyclistic for their mobility needs.</td>
   </tr>
   <tr>
      <td>Opportunity</td>
      <td>Converting casual riders into annual members will provide a more profitable growth for the future.</td>
   </tr>
   <tr>
      <td>Objective</td>
      <td>Use Cyclistic’s historical trip data to analyse how annual members and casual riders use Cyclistic bikes differently.</td>
   </tr>
   <tr>
      <td>Expected Outcome</td>
      <td>3 recommendations on how to turn casual riders to annual members based on the analysis made.</td>
   </tr>
</table>
<br>


## Step 2: Prepare
<section>
   <p>Data Source: </p>
   <p>For the purpose of this case study, I will be using Cyclistic’s historical trip dataset from January 2024 to December 2024, which was sourced from this <a href='https://divvy-tripdata.s3.amazonaws.com/index.html'>link</a>. The data has been made publicly available by Motivate International Inc. under the <a href='https://divvybikes.com/data-license-agreement'>license</a> <i>Lyft Bikes and Scooters, LLC (“Bikeshare”)</i>.</p>
</section><br>

<section>
   <p>Metadata: </p>
   <p>The datasets are stored in spreadsheets. There are twelve .csv files in total and each file are consistent with 13 column attributes, which are:</p>

   <table>
      <tr>
         <th>Attribute</th>
         <th>Description</th>
      </tr>
      <tr>
         <td><code>ride_id</code></td>
         <td>Unique identifier for each bike ride.</td>
      </tr>
      <tr>
         <td><code>started_at</code></td>
         <td>Timestamp of when the ride started (formatted in: dd/mm/yyyy hh:mm:ss)</td>
      </tr>
      <tr>
         <td><code>ended_at</code></td>
         <td>Timestamp of when the ride ended (formatted in: dd/mm/yyyy hh:mm:ss)</td>
      </tr>
      <tr>
         <td><code>start_station_name</code></td>
         <td>Name of the bike station where the ride started</td>
      </tr>
      <tr>
         <td><code>start_station_id</code></td>
         <td>Unique identifier of the starting station</td>
      </tr>
      <tr>
         <td><code>end_station_name</code></td>
         <td>Name of the bike station where the ride ended</td>
      </tr>
      <tr>
         <td><code>end_station_id</code></td>
         <td>Unique identifier of the ending station</td>
      </tr>
      <tr>
         <td><code>start_lat</code></td>
         <td>Latitude coordinates of the starting station</td>
      </tr>
      <tr>
         <td><code>start_lng</code></td>
         <td>Longitude coordinate of the starting station</td>
      </tr>
      <tr>
         <td><code>end_lat</code></td>
         <td>Latitude coordinates of the starting station</td>
      </tr>
      <tr>
         <td><code>end_lng</code></td>
         <td>Longitude coordinate of the ending station</td>
      </tr>
      <tr>
         <td><code>member_casual</code></td>
         <td>Categorisation of the rider as an annual member of casual rider</td>
      </tr>      
   </table>
</section><br>


## Step 3: Process
<ol>
   <li>
      <p>After downloading the necessary files, folders are created to store a copy of the original data in .csv and .xls format.</p>
      <img width="940" height="69" alt="image" src="https://github.com/user-attachments/assets/1c0a538e-b18c-4d8f-870f-468890ddbed5" />
   </li>
   
   <li>
      <p>Using the .xls files, initial data cleaning was performed using Microsoft Excel. In each file, the format of columns <code>started_at</code> and <code>ended_at</code> is changed from <code>dd/mm/yyyy hh:mm:ss</code> to <code>yyyy-mm-dd hh:mm:ss</code>.</p>
   </li>
   
   <li>
      <p>Next, the files are then uploaded into a MySQL database for further processing and analysis due to its extremely large size. All 12 files are combined into one large dataset and stored in a new table <code>combined_data</code>, which contains a total of 6,005,441 data rows. (<a href="cyclistic_combine_files.sql">View query file</a>)</p>
   </li>
   
   <li>
      <p>The cleaning steps in MySQL are as follows: (<a href="cyclistic_data_clean.sql">View query file</a>)</p>
      <ol>
         <li>
            <p>Checking for null values for each column and remove rows if <code>ride_id</code> contains null values. The table below shows the number of null values in each column. There are no null values present in <code>ride_id</code>, therefore no rows are removed.</p>
            <img width="940" height="42" alt="image" src="https://github.com/user-attachments/assets/acfa0367-3db7-431e-8b24-c8154d4c9024" />
         </li>
         <li>
            <p>Duplicates are checked for removal.</p>
            <ul>
               <li>
                  There were 144,925 duplicated rows. Below is an example of a duplicated row.
                  <img width="940" height="46" alt="image" src="https://github.com/user-attachments/assets/e17ce9b2-7485-4e23-b7ec-748da58e0f11" />
               </li>
               <li>
                  Used <code>ROW_NUMBER()</code> to remove duplicates. Duplicates are checked by rows having the same <code>ride_id</code>, <code>rideable_type</code>, <code>started_at</code>, <code>ended_at</code>, & <code>member_casual</code>. Rows containing null values were excluded.
               </li>
               <li>
                  A staging table <code>cd_stage1</code> was created to safely clean and preprocess data before analysis.
               </li>
               <li>
                  After removing duplicates, there are now 5,860,516 remaining rows.
               </li>
            </ul>
         </li>
         <li>
            <p>Check values in columns <code>rideable_type</code> and <code>member_casual</code> for any misspellings. Based on the results below, there are 3 distinct types of rides and 2 distinct types of riders.</p>
            <div align='center'>
               <img width="198" height="144" alt="image" src="https://github.com/user-attachments/assets/f15e61a5-2025-4438-a005-a0efab854bae" />
               <img width="188" height="116" alt="image" src="https://github.com/user-attachments/assets/ed07d9d2-eb37-4502-a582-6967e54d9b3f" />
            </div>
         </li>
      </ol>
   </li>
   
   <li>
      <p>The preprocessing steps in MySQL are as follows: (<a href="cyclistic_data_preprocess.sql">View query file</a>)</p>
      <ol>
         <li>
            Create column <code>ride_length</code>, which is the length of each ride by subtracting column <code>started_at</code> from <code>ended_at</code>.
            <ul>
               <li>Used <code>TIME_TO_SEC(TIMEDIFF(ended_at, started_at))</code></li>
               <li>Values are stored as <code>INT</code> in the table, which corresponds to the length of the ride in seconds</li>
            </ul>
         </li>
         <li>
            Create column <code>ride_day</code>, which is the day of the week of each ride.
            <ul>
               <li>Used <code>DAYNAME(started_at)</code></li>
               <li>Values are stored as <code>VARCHAR(10)</code>, which corresponds to the lengths of the name of the days</li>
            </ul>
         </li>
         <li>
            Create column <code>ride_month</code>, which is the month of each ride.
            <ul>
               <li>Used <code>MONTH(started_at)</code></li>
               <li>Values stored as <code>INT</code>, which corresponds to the numeric value of each month</li>
            </ul>
         </li>
         <li>
            Create column <code>ride_hour</code>, which is the hour of each ride.
            <ul>
               <li>Used <code>HOUR(started_at)</code></li>
               <li>Values stored as <code>INT</code></li>
            </ul>
         </li>
      </ol>
   </li>
</ol>
<br>


## Step 4-5: Analyse & Share
The objective of the analysis is to compare how annual members and casual riders use the Cyclitstic bikes throughout the year. MySQL and Microsoft Power BI were used to perform analysis and visualisations. ([View query file]("cyclistic_eda.sql"))

### Part A: Rider distribution
<section>
   <p>In 2024, Cyclistic had an overall total of 5,860,516 bike trips, where 63.29% were from annual members and the remaining 36.71% were from casual riders. Fig. 1 shows a pie chart of the annual distribution of bike trips.</p><br>
   
   <div align="center">
      <img width="579" height="325" alt="image" src="https://github.com/user-attachments/assets/b801af9c-43e9-4a95-ad04-53bda1a0f4c9" />
      <p>Fig 1. Overall bike trip distribution</p>
   </div>   
</section><br>

<section>
   <p>Fig. 2 shows the distribution of bike trips by bike types. From Fig. 2, electric bikes had the most usage followed by classic bikes and electric scooter being the lowest. Focusing on rider types, both casual and member riders preferred electric bikes than classic bikes.</p><br>
   
   <div align="center">
      <img width="584" height="325" alt="image" src="https://github.com/user-attachments/assets/ee0033d7-2146-4e3e-8da4-d90791210087" />
      <p>Fig 2. Distribution of bike trips by bike types</p>
   </div>
</section><br>

<section>
   <p>Fig. 3 shows the monthly distribution of bike trips. In general, there is a rise and fall trend for both casual and member riders.</p>
   <p>In the beginning of the year (24,420), the number of trips of casual riders were at its lowest. The number increased until it peaked in September (346,494), then it gradually declined onwards until December. Similarly, trips rode by member riders also had a similar trend whereby from January (120,413), when it was at its lowest, the number rose until it peaked in September (474,373), then also fell onwards.</p>
   <p>In the third quarter of the year (Jul-Sept), Cyclistic were at its busiest. This was probably due to the period being mainly in summertime, which are perfect for riding bicycles. It could also explain why there was a decline after September and the first quarter having the lowest numbers because the temperature was beginning to drop and were at its coldest in the first quarter.</p><br>
   
   <div align="center">
      <img width="574" height="325" alt="image" src="https://github.com/user-attachments/assets/6bc24131-eaf8-482b-b74a-2673c85c9780" />
      <p>Fig 3. Monthly distribution of bike trips</p>
   </div>
</section><br>

<section>
   <p>Fig. 4 shows the weekly distribution of bike trips accumulated throughout the year. Casual rides were the most frequent in the weekends with Saturday having the highest number. On the contrary, member rides were surprisingly at their lowest on the weekends and their busiest were on Wednesdays.</p><br>
   
   <div align="center">
      <img width="583" height="325" alt="image" src="https://github.com/user-attachments/assets/520c23ee-78c4-449d-bbec-8a0e8e5f99a9" />
      <p>Fig 4. Weekly distribution of bike trips</p>
   </div>
</section><br>

<section>
   <p>Fig. 5 shows the hourly distribution of bike trips accumulated over the year. Throughout the day, there is a consistent increase in the number of casual rides until it peaked in the evening (5 p.m.), then decreased afterwards. As for the member rides, there are two peaks: one in the morning (8 a.m.) and the other in the evening (5 p.m.).</p><br>
   
   <div align="center">
      <img width="940" height="258" alt="image" src="https://github.com/user-attachments/assets/97d64fe1-d63a-4e76-a954-bccc2d3db243" />
      <p>Fig 5. Hourly distribution of bike trips</p>      
   </div>
</section><br>

<p>Based on the observations, I can infer that annual members generally consist of typical 9-to-5 workers, as they would commute to their workplaces on bikes before 9 a.m. and return home, and bikes, after ending their shift at 5 p.m., thus resulting to the two peaks and the higher number of trips on the weekdays. As for the casual riders, the higher number of bike rides in the weekends and in the evening could imply that they use the bikes for leisure purposes.</p>
<br>


### Part B: Bike ride lengths
<section>
   <p>Table below shows a query result of the average bike ride lengths of overall, members, and casual riders. From the table, casual riders have about twice the average ride length than member riders.</p><br>
   
   <div align='center'>
      <img width="644" height="91" alt="image" src="https://github.com/user-attachments/assets/f2bef3b4-2b87-4bd5-bf79-67c4ad7765bc" />
   </div><br>
   
   <p>Further analysis was made to investigate whether outliers affect the averages. The table below shows the maximum ride length of both rider types. It is observed that the longest ride length for both casual and member rides are greater than a day.</p><br>
   
   <div align='center'>
      <img width="372" height="108" alt="image" src="https://github.com/user-attachments/assets/6db05481-1d20-4f51-b13b-9b18d5667479" />
   </div><br>

   <p>From this, I looked at the maximum ride lengths of each ride type, in descending order, to confirm if there were more than one outlier affecting the average. The query results are shown below.</p><br>
   
   <div align='center'>
      <img width="323" height="535" alt="image" src="https://github.com/user-attachments/assets/befc0bb5-b689-4609-80d7-fe3fa4d7e67e" />
      <img width="320" height="535" alt="image" src="https://github.com/user-attachments/assets/a25b7022-da65-4ffd-b680-c0d0487bde60" />
   </div><br>

   <p>Additionally, I created a histogram of the average bike ride lengths, as shown below, to observe the overall distribution shape. Based on the histogram, the distribution is significantly right-skewed.</p><br>
   
   <div align='center'>
      <img width="614" height="325" alt="image" src="https://github.com/user-attachments/assets/9c23994e-2c2d-4f13-b388-7adab2761c29" />
      <p>Skewed distribution of ride lengths</p>
   </div><br>
   
   <p>From these observations, it is concluded that the outliers had an effect on the averages for both casual and member rides. Due to the skewed distribution, a median would be a more suitable choice to compare the bike ride lengths between casual and member riders.</p>
</section><br>

<section>
   <p>Fig. 6 shows the median ride length of both rider types throughout the year. In general, both rider types have a rise and fall trend, where the median rose from January and peaked at the middle of the year, then fell onwards.</p><br>
   
   <div align='center'>
      <img width="589" height="325" alt="image" src="https://github.com/user-attachments/assets/07bc1a88-9c7d-4c00-aa2b-4959b153e7bc" />
      <p>Fig 6. Median bike ride length by month</p>
   </div><br>
   
   <p>Fig. 7 shows the median ride length of rider types by days. From the graph, it is observed that both casual rider types used the bikes the longest in the weekends. Focusing on the casual rides, there is a huge median difference between the weekends and the weekdays compared to member rides, which look consistently similar throughout.</p><br>
   
   <div align='center'>
      <img width="585" height="325" alt="image" src="https://github.com/user-attachments/assets/9e9ee089-cc37-4c57-bb6b-deaa28e11b55" />
      <p>Fig 7. Median bike ride length by day</p>
   </div><br>
   
   <p>It was previously stated that rides are popular during the warmer months. This could also explain the reason why both riders rode the longest during that period.Similarly, because there is a higher number of casual rides in the weekends, it could also result in longer rides, which further proves that casual riders use the bikes for leisure activities.</p>
</section>
<br>


### Part C: Starting stations
<section>
   <p>Fig. 8 shows maps of where the riders are distributed across starting stations.</p><br>
   
   <div align='center'>
      <img width="940" height="527" alt="image" src="https://github.com/user-attachments/assets/a7aa6aa5-44e7-4526-9dbc-991ae78ec2c4" />
      <p>Fig 8. Map of rider distribution between casual and member riders</p>
   </div><br>

   <p>It can be seen that member riders are distributed more equally across starting stations from various locations (e.g., residentials, shops, universities, parks, etc.). On the other hand, casual riders are more frequent on stations located in parks and recreational areas.</p>
   <p>Based on this observation, this proves that casual riders use the bikes for leisure purposes and member riders use them for their daily commute.</p>
</section><br>


## Step 6: Act
After identifying the differences between casual and member riders, here are three strategies I recommend for the purpose of persuading casual riders to become annual members:

1. The number of casual riders were at its highest in the third quarter, which is presumably summer during that period. Therefore, a summer event should be conducted for riders to ride the bikes in the summer to gain points in exchange for rewards like food delivery vouchers. Members get more exclusive rewards.
2. Casual riders rode the bikes longer and more frequent in the weekends and in the evening. Therefore, we should create an incentive, such as discounts for longer rides to members to ride for longer periods.
3. Casual riders are more located in parks and recreational areas. Therefore, marketing campaigns should be held in those areas for a higher exposure of persuading them to join the membership.

