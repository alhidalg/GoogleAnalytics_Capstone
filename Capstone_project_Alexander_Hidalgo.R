### Cyclistic_Exercise_Full_Year_Analysis ###

# This analysis is for case study 1 from the Google Data Analytics Certificate (Cyclistic).  It’s originally based on the case study "'Sophisticated, Clear, and Polished’: Divvy and Data Visualization" written by Kevin Hartman (found here: https://artscience.blog/home/divvy-dataviz-case-study). We will be using the Divvy dataset for the case study. The purpose of this script is to consolidate downloaded Divvy data into a single dataframe and then conduct simple analysis to help answer the key question: “In what ways do members and casual riders use Divvy bikes differently?”

# # # # # # # # # # # # # # # # # # # # # # # 
# Install required packages
# tidyverse for data import and wrangling
# libridate for date functions
# ggplot for visualization
# # # # # # # # # # # # # # # # # # # # # # #  

library(tidyverse)  #helps wrangle data
library(lubridate)  #helps wrangle date attributes
library(ggplot2)  #helps visualize data
getwd() #displays your working directory
setwd("C:/Users/AlexanderAntonioHida/Downloads/Capstone/Cyclistic Historical trips") #sets your working directory to simplify calls to data ... make sure to use your OWN username instead of mine ;)

#=====================
# STEP 1: COLLECT DATA
#=====================
# Upload Divvy datasets (csv files) here
Aug_2022 <- read_csv("202208-divvy-tripdata.csv")
Sep_2022 <- read_csv("202209-divvy-tripdata.csv")
Oct_2022 <- read_csv("202210-divvy-tripdata.csv")
Nov_2022 <- read_csv("202211-divvy-tripdata.csv")
Dec_2022 <- read_csv("202212-divvy-tripdata.csv")
Jan_2023 <- read_csv("202301-divvy-tripdata.csv")
Feb_2023 <- read_csv("202302-divvy-tripdata.csv")
Mar_2023 <- read_csv("202303-divvy-tripdata.csv")
Apr_2023 <- read_csv("202304-divvy-tripdata.csv")
May_2023 <- read_csv("202305-divvy-tripdata.csv")
Jun_2023 <- read_csv("202306-divvy-tripdata.csv")
Jul_2023 <- read_csv("202307-divvy-tripdata.csv")

#====================================================
# STEP 2: WRANGLE DATA AND COMBINE INTO A SINGLE FILE
#====================================================
# Compare column names each of the files
# While the names don't have to be in the same order, they DO need to match perfectly before we can use a command to join them into one file
colnames(Aug_2022)
colnames(Sep_2022)
colnames(Oct_2022)
colnames(Nov_2022)
colnames(Dec_2022)
colnames(Jan_2023)
colnames(Feb_2023)
colnames(Mar_2023)
colnames(Apr_2023)
colnames(May_2023)
colnames(Jun_2023)
colnames(Jul_2023)

##############Before going into transformation, validating if indeed the colums are different or not across data sets
# List of dataset names
dataset_names <- c(
  "Aug_2022",
  "Sep_2022",
  "Oct_2022",
  "Nov_2022",
  "Dec_2022",
  "Jan_2023",
  "Feb_2023",
  "Mar_2023",
  "Apr_2023",
  "May_2023",
  "Jun_2023",
  "Jul_2023"
)

# Create a list of data frames using the dataset names
datasets <- lapply(dataset_names, function(name) {
  get(name)  # Assuming you've loaded the datasets using these names
})

# Check if all datasets have the same columns
all_columns_same <- all(sapply(datasets, function(data) {
  identical(names(datasets[[1]]), names(data))
}))

if (all_columns_same) {
  print("All datasets have the same columns.")
} else {
  print("Not all datasets have the same columns.")
}

##############################Based on validatio all columns are the same therefore skipping provided script step. 
# Rename columns  to make them consisent with q1_2020 (as this will be the supposed going-forward table design for Divvy)
# Rename columns for q4_2019 dataset
# (q4_2019 <- rename(q4_2019,
#                    ride_id = trip_id,
#                    rideable_type = bikeid,
#                    started_at = start_time,
#                    ended_at = end_time,
#                    start_station_name = from_station_name,
#                    start_station_id = from_station_id,
#                    end_station_name = to_station_name,
#                    end_station_id = to_station_id,
#                    member_casual = usertype))

# Rename columns for q3_2019 dataset
# (q3_2019 <- rename(q3_2019,
#                    ride_id = trip_id,
#                    rideable_type = bikeid,
#                    started_at = start_time,
#                    ended_at = end_time,
#                    start_station_name = from_station_name,
#                    start_station_id = from_station_id,
#                    end_station_name = to_station_name,
#                    end_station_id = to_station_id,
#                    member_casual = usertype))

# Rename columns for q2_2019 dataset
# (q2_2019 <- rename(q2_2019,
#                    ride_id = "01 - Rental Details Rental ID",
#                    rideable_type = "01 - Rental Details Bike ID",
#                    started_at = "01 - Rental Details Local Start Time",
#                    ended_at = "01 - Rental Details Local End Time",
#                    start_station_name = "03 - Rental Start Station Name",
#                    start_station_id = "03 - Rental Start Station ID",
#                    end_station_name = "02 - Rental End Station Name",
#                    end_station_id = "02 - Rental End Station ID",
#                    member_casual = "User Type"))

# Inspect the dataframes and look for inconguencies
str(Aug_2022)
str(Sep_2022)
str(Oct_2022)
str(Nov_2022)
str(Dec_2022)
str(Jan_2023)
str(Feb_2023)
str(Mar_2023)
str(Apr_2023)
str(May_2023)
str(Jun_2023)
str(Jul_2023)
################There are no inconsistencies across files, ignoring next step as well 

# Convert ride_id and rideable_type to character so that they can stack correctly
#Jul_2023 <-  mutate(Jul_2023, ride_id = as.character(ride_id)
#                   ,rideable_type = as.character(rideable_type)) 
#q3_2019 <-  mutate(q3_2019, ride_id = as.character(ride_id)
#                   ,rideable_type = as.character(rideable_type)) 
#q2_2019 <-  mutate(q2_2019, ride_id = as.character(ride_id)
#                   ,rideable_type = as.character(rideable_type)) 

# Stack individual quarter's data frames into one big data frame
all_trips <- bind_rows(
  Aug_2022,
  Sep_2022,
  Oct_2022,
  Nov_2022,
  Dec_2022,
  Jan_2023,
  Feb_2023,
  Mar_2023,
  Apr_2023,
  May_2023,
  Jun_2023,
  Jul_2023
)

# Remove lat, long, station Ids fields as they won't be used
all_trips <- all_trips %>%  
  select(-c(start_lat, start_lng, end_lat, end_lng, start_station_id, end_station_id))

#======================================================
# STEP 3: CLEAN UP AND ADD DATA TO PREPARE FOR ANALYSIS
#======================================================
# Inspect the new table that has been created
colnames(all_trips)  #List of column names
nrow(all_trips)  #How many rows are in data frame?
dim(all_trips)  #Dimensions of the data frame?
head(all_trips)  #See the first 6 rows of data frame.  Also tail(qs_raw)
str(all_trips)  #See list of columns and data types (numeric, character, etc)
summary(all_trips)  #Statistical summary of data. Mainly for numerics

# There are a few problems we will need to fix:
# (1) In the "member_casual" column, there are two names for members ("member" and "Subscriber") and two names for casual riders ("Customer" and "casual"). We will need to consolidate that from four to two labels.
# (2) The data can only be aggregated at the ride-level, which is too granular. We will want to add some additional columns of data -- such as day, month, year -- that provide additional opportunities to aggregate the data.
# (3) We will want to add a calculated field for length of ride since the 2020Q1 data did not have the "tripduration" column. We will add "ride_length" to the entire dataframe for consistency.
# (4) There are some rides where tripduration shows up as negative, including several hundred rides where Divvy took bikes out of circulation for Quality Control reasons. We will want to delete these rides.

# In the "member_casual" column, replace "Subscriber" with "member" and "Customer" with "casual"
# Before 2020, Divvy used different labels for these two types of riders ... we will want to make our dataframe consistent with their current nomenclature
# N.B.: "Level" is a special property of a column that is retained even if a subset does not contain any values from a specific level
# Begin by seeing how many observations fall under each usertype
table(all_trips$member_casual)

# Check for distribution of member type
table(all_trips$member_casual)

# Add columns that list the date, month, day, and year of each ride
# This will allow us to aggregate ride data for each month, day, or year ... before completing these operations we could only aggregate at the ride level
# https://www.statmethods.net/input/dates.html more on date formats in R found at that link
all_trips$date <- as.Date(all_trips$started_at) #The default format is yyyy-mm-dd
all_trips$month <- format(as.Date(all_trips$date), "%m")
all_trips$day <- format(as.Date(all_trips$date), "%d")
all_trips$year <- format(as.Date(all_trips$date), "%Y")
all_trips$day_of_week <- format(as.Date(all_trips$date), "%A")

# Add a "ride_length" calculation to all_trips (in seconds)
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/difftime.html
all_trips$ride_length <- difftime(all_trips$ended_at,all_trips$started_at)

# Inspect the structure of the columns
str(all_trips)

# Convert "ride_length" from Factor to numeric so we can run calculations on the data
is.factor(all_trips$ride_length)
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))
is.numeric(all_trips$ride_length)

# Remove "bad" data
# The dataframe includes a few hundred entries when bikes were taken out of docks and checked for quality by Divvy or ride_length was negative
# We will create a new version of the dataframe (v2) since data is being removed
# https://www.datasciencemadesimple.com/delete-or-drop-rows-in-r-with-conditions-2/
all_trips_v2 <- all_trips[!(all_trips$ride_length<0),]

#=====================================
# STEP 4: CONDUCT DESCRIPTIVE ANALYSIS
#=====================================
# Descriptive analysis on ride_length (all figures in seconds)
mean(all_trips_v2$ride_length) #straight average (total ride length / rides)
median(all_trips_v2$ride_length) #midpoint number in the ascending array of ride lengths
max(all_trips_v2$ride_length) #longest ride
min(all_trips_v2$ride_length) #shortest ride

# You can condense the four lines above to one line using summary() on the specific attribute
summary(all_trips_v2$ride_length)

# Compare members and casual users
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = max)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = min)

# See the average ride time by each day for members vs casual users
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)

# Notice that the days of the week are out of order. Let's fix that.
all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

# Now, let's run the average ride time by each day for members vs casual users
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)

# analyze ridership data by type and weekday
all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>%  #creates weekday field using wday()
  group_by(member_casual, weekday) %>%  #groups by usertype and weekday
  summarise(number_of_rides = n()							#calculates the number of rides and average duration 
            ,average_duration = mean(ride_length)) %>% 		# calculates the average duration
  arrange(member_casual, weekday)								# sorts

# Let's visualize the number of rides by rider type
all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")

# Let's create a visualization for average duration
all_trips_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge")

#=================================================
# STEP 5: EXPORT SUMMARY FILE FOR FURTHER ANALYSIS
#=================================================
# Create a csv file that we will visualize in Excel, Tableau, or my presentation software
# N.B.: This file location is for a Mac. If you are working on a PC, change the file location accordingly (most likely "C:\Users\YOUR_USERNAME\Desktop\...") to export the data. You can read more here: https://datatofish.com/export-dataframe-to-csv-in-r/
counts <- aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)
write.csv(counts, file = 'C:/Users/AlexanderAntonioHida/Downloads/Capstone/Cyclistic Historical trips/avg_ride_length.csv')

#You're done! Congratulations!

#Let's now do additional data exploration here for the Sharing part of the analysis 

#get the hour of the day
all_trips_v2$hour_of_day <- hour(all_trips_v2$started_at)

#Now get a heatmap of hour of the day vs day of the week 
# Create a summary table for counting ride_ids
heatmap_data <- all_trips_v2 %>%
  group_by(hour_of_day, day_of_week) %>%
  summarise(ride_count = n())

# Create the heatmap using ggplot2 with y-axis in increments of 1 unit
ggplot(heatmap_data, aes(x = day_of_week, y = hour_of_day, fill = ride_count)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(
    x = "Day of the Week",
    y = "Hour of the Day",
    fill = "Ride Count",
    title = "Heatmap of Ride Count by Hour and Day"
  ) +
  scale_y_continuous(breaks = seq(min(heatmap_data$hour_of_day), max(heatmap_data$hour_of_day), by = 1)) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.text.y = element_text(size = 8),
    axis.ticks.y = element_blank(),
    plot.title = element_text(hjust = 0.5)
  )



### Now let's review the distribution per type of ride 

# Assuming all_trips_v2$rideable_type is a categorical variable
rideable_type_counts <- all_trips_v2 %>%
  group_by(rideable_type) %>%
  summarise(ride_count = n())

# Create a vector of distinct colors (you can add more colors as needed)
distinct_colors <- c("dodgerblue", "orange", "purple", "red", "yellow", "pink")

# Create the bar graph using ggplot2 with distinct colors for each bar
ggplot(rideable_type_counts, aes(x = reorder(rideable_type, -ride_count), y = ride_count, fill = rideable_type)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = distinct_colors) +  # Assign distinct colors to bars
  labs(
    x = "Rideable Type",
    y = "Ride Count",
    title = "Total Ride Count by Rideable Type"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(hjust = 0.5)
  )


## Dig into the monthly distribution of rides 

# install.packages("scales")
library(scales)
library(dplyr)
library(ggplot2)
library(RColorBrewer)
# Assuming all_trips_v2$started_at is in timestamp format
all_trips_v2$month <- format(all_trips_v2$started_at, "%B")  # Extract month name

# Define a custom color palette with a gradient from blue to purple
n_colors <- nlevels(factor(month_volume$month))
color_palette <- colorRampPalette(c("blue", "purple"))(n_colors)

# Define the custom order of months
custom_month_order <- c(
  "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
)

# Convert month to a factor with custom levels
all_trips_v2$month <- factor(all_trips_v2$month, levels = custom_month_order)


# Create a summary table for counting ride_ids per month
month_volume <- all_trips_v2 %>%
  group_by(month) %>%
  summarise(total_count = n())

# Create a summary table for counting ride_ids per month
month_volume <- all_trips_v2 %>%
  group_by(month) %>%
  summarise(total_count = n())


# Create the volume chart using ggplot2 with custom-colored gradients and sorted months
ggplot(month_volume, aes(x = month, y = total_count, fill = month)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = scales::hue_pal()(length(custom_month_order))) +
  labs(
    x = "Month",
    y = "Ride Count",
    title = "Total Volume of Rides per Month",
    fill = "Month"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(hjust = 0.5)
  )
