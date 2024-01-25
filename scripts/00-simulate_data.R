library(tidyverse)
library(lubridate)

# Step 1: Simulate the Dataset
set.seed(123)

# Dates is set to be consecutive dates from 1/1/2023 to 12/31/2023
dates <- seq(as.Date('2023-01-01'), as.Date('2023-12-31'), by="day")

# Simulate other variables
data_simulated <- tibble(
  date = sample(dates, 1000, replace = TRUE),
  offense_type = sample(c("Speeding", "Parking", "Signal Violation", "Documentation"), 1000, replace = TRUE),
  location = sample(c("Downtown", "Midtown", "Suburb"), 1000, replace = TRUE),
  tickets_issued = sample(1:10, 1000, replace = TRUE)
)

# Step 2: Basic tests

# Basic trend in data
data_simulated$date <- ymd(data_simulated$date)
time_trend <- data_simulated %>% 
  group_by(month = floor_date(date, "month")) %>%
  summarise(Total_Tickets = sum(tickets_issued))

ggplot(time_trend, aes(x = month, y = Total_Tickets)) +
  geom_line() +
  labs(title = "Monthly Trend of Tickets Issued", x = "Month", y = "Total Tickets")

# Different locations
location_analysis <- data_simulated %>%
  group_by(location) %>%
  summarise(Total_Tickets = sum(tickets_issued))

ggplot(location_analysis, aes(x = location, y = Total_Tickets, fill = location)) +
  geom_bar(stat = "identity") +
  labs(title = "Tickets Issued by Location", x = "Location", y = "Total Tickets")
