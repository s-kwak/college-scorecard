library(dplyr)
library(tidyr)
library(ggplot2)

data_years <- list.files(pattern = 'MERGED') %>%
  substr(7, 10)

file_names <- list.files(pattern = 'MERGED')



## reads in all of the years of data
# for (i in 1:length(data_years)){
# assign(paste('cohort', data_years[i], sep = '_'),
#        read.csv(list.files(pattern = data_years[i]), header = TRUE, stringsAsFactors = FALSE,
#                 na.strings = c('NULL', 'PrivacySuppressed')))
# }

# better way of reading in using lapply
data <- lapply(file_names, read.csv, header = TRUE, stringsAsFactors = FALSE,
               na.strings = c('NULL', 'PrivacySuppressed'))

#then add cohort year for each element of list
for (i in 1:length(data_years)){
data[[i]] <- data[[i]] %>%
  mutate(COHORT = data_years[i])

names(data[[i]])[1] <- 'UNITID'
}

