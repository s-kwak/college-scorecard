library(dplyr)
library(tidyr)
library(ggplot2)

# NOTE: when setting working dirs, use '..' to set parent file as wd and use './{name}' to set subfolder as wd

# read in dictionary data
dict_name <- list.files(pattern = 'Dictionary')
dict <- read.csv(dict_name, sep = ',', header = TRUE, stringsAsFactors = FALSE)

# read in and clean college data
college <- read.csv('MERGED2013_PP.csv', sep = ',',
                    header = TRUE, stringsAsFactors = FALSE,
                    na.strings = c('PrivacySuppressed', 'NULL'))
college <- tbl_df(college)

# ----

# variable cat mapping

var_type_map <- dict %>%
  select(dev.category, VARIABLE.NAME) %>%
  filter(VARIABLE.NAME != '')

types <- unique(var_type_map$dev.category)

# assigning via loop; this process creates vectors that list vars for each type

for (i in 1:length(types)) {
assign(types[i], var_type_map %>%
         filter(dev.category == types[i]) %>%
         select(VARIABLE.NAME) %>%
         .$VARIABLE.NAME)  # changes the df to a vector!! use period
}

# create separate tables per category

for (i in 1:length(types)){
assign(paste(types[i], 'd', sep = '_'), college %>%
         select(1:3, which(names(college) %in% get(types[i]))))  # FINALLY got the damn thing to loop right
}  # get() changes string into variable; which() is like grep on multiple criteria and gives positions


# tidy data into long format where relevant
