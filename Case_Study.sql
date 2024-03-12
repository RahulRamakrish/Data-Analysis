"""The major calculations that are done here are:
1.Converts the start_time and end_time timestamps to dates to isolate the day on which the ride started and ended.
2.Extracts the time from start_time and end_time to capture when the ride started and ended within the day, respectively.
3.Extracts the day of the week from the start_time as a numeric value, where 1 represents Sunday, 2 represents Monday, etc.
4.Computes the difference in seconds between the end_time and start_time, offering a numeric representation of the ride's length in seconds.
5.Formats the date extracted from start_time to a three-letter abbreviation of the weekday (e.g., Mon, Tue).
6.Ensure an equal number of entries for 'Subscriber' and 'Customer' user types by limiting the number of rows selected for Subscribers to match the total count of Customer records, thereby facilitating a balanced comparison between the two."""


(select
  *,
  date(start_time) as start_day,
  date(end_time) as end_day,
  time(start_time) as start_at,
  time(end_time) as end_at,
  time(abs(extract(hour from end_time) - extract(hour from start_time)),
  abs(extract(minute from end_time) - extract(minute from start_time)),
  abs(extract(second from end_time) - extract(second from start_time))) as ride_length,
  extract(dayofweek from start_time) as day_of_week,
  time_diff(time(end_time),time(start_time),second) as num_ride_length,
  FORMAT_DATE('%a', DATE(start_time)) AS weekday

from
  `casestudy-413817.cyclist_data.data_2019`

where
  usertype="Subscriber"

Limit 23163)

union all

(select
  *,
  date(start_time) as start_day,
  date(end_time) as end_day,
  time(start_time) as start_at,
  time(end_time) as end_at,
  time(abs(extract(hour from end_time) - extract(hour from start_time)),
  abs(extract(minute from end_time) - extract(minute from start_time)),
  abs(extract(second from end_time) - extract(second from start_time))) as ride_length,
  extract(dayofweek from start_time) as day_of_week,
  time_diff(time(end_time),time(start_time),second) as num_ride_length,
  FORMAT_DATE('%a', DATE(start_time)) AS weekday

from
  `casestudy-413817.cyclist_data.data_2019`

where
  usertype = "Customer")