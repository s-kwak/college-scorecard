library(dplyr)
library(tidyr)
library(ggplot2)

data_years <- list.files(pattern = 'MERGED') %>%
  substr(7, 10)

# reads in all of the years of data
for (i in 1:length(data_years)){
assign(paste('cohort', data_years[i], sep = '_'),
       read.csv(list.files(pattern = data_years[i]), header = TRUE, stringsAsFactors = FALSE,
                na.strings = c('NULL', 'PrivacySuppressed')))
}

# then update each of those
chrt_dfs <- lapply(ls(pattern = 'cohort_'), get)


?ls
list