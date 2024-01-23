library(dplyr)
library(opendatatoronto)
# Load the data
resources <- list_package_resources("police-annual-statistical-report-tickets-issued")
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))
data <- filter(datastore_resources, row_number()==1) %>% get_resource()

# Check Null Values
null_values <- data %>%
  summarise_all(~ sum(is.na(.)))

# Check Duplicates
duplicates <- data[duplicated(data),]
