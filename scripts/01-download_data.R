library(opendatatoronto)
library(dplyr)

# Load the data from Open data toronto
package <- show_package("police-annual-statistical-report-tickets-issued")
resources <- list_package_resources("police-annual-statistical-report-tickets-issued")
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

data <- filter(datastore_resources, row_number()==1) %>% get_resource()

write.table(data, file = "unedited_data.csv", sep = ",", row.names = FALSE)