getwd()

brexit_data <- read.csv("data_brexit_referendum.csv")
str(brexit_data)

# identify values that are -1 in leave variable. count them and replacethem with NA

sum(brexit_data$Leave[brexit_data$Leave == -1]) # there are 267 -1s

brexit_data$Leave[brexit_data$Leave == -1] <- NA # replace -1s with NA

sum(brexit_data$Leave[brexit_data$Leave == -1]) # proves there are no more -1s
sum(is.na(brexit_data$Leave == NA)) # counts NAs but got the wrong answer

# count NAs properly
na_records <- brexit_data[!complete.cases(brexit_data),] # assigns all the records with NAs to na_records
na_records
nrow(na_records) # count na_records

library(mice)
md.pattern(brexit_data, rotate.names = TRUE) # rotate.names writes the variable names vertically


install.packages("VIM")
library(VIM)

summary(missing_data)

#create a new variable to show the proportion of people who voted leave
brexit_data$Proportion <- brexit_data$Leave/brexit_data$NVotes*100
brexit_data[1:15, ]

# create a variable called vote and assign remain if the Proportion is <= 50
brexit_data$Vote[brexit_data$Proportion <= 50] <- "Remain"
brexit_data$Vote[brexit_data$Proportion > 50] <- "Leave"
brexit_data[1:15, ]

install.packages("VIM")
missing_data <- aggr(brexit_data, prop = FALSE, numbers = TRUE)

# shorten the Region Names from London to L. Looks better on charts
# attach(brexit_data)
brexit_data$RegionName[brexit_data$RegionName == "London"] <- "L"
brexit_data$RegionName[brexit_data$RegionName == "North West"] <- "NW"
brexit_data$RegionName[brexit_data$RegionName == "North East"] <- "NE"
brexit_data$RegionName[brexit_data$RegionName == "South West"] <- "SW"
brexit_data$RegionName[brexit_data$RegionName == "South East"] <- "SE"
brexit_data$RegionName[brexit_data$RegionName == "East Midlands"] <- "EM"
brexit_data$RegionName[brexit_data$RegionName == "West Midlands"] <- "WM"
brexit_data$RegionName[brexit_data$RegionName == "East of England"] <- "EE"
brexit_data$RegionName[brexit_data$RegionName == "Yorkshire and the Humber"] <- "Y"
# detach(brexit_data)
brexit_data[1:15, ]

summary(brexit_data)

# check each column for numeric data. we can work with numeric data
sapply(brexit_data, is.numeric)
numeric_variable_list <- sapply(brexit_data, is.numeric)
numeric_variable_list

# create a subset of the dataframe containing only numeric data
numeric_data <- brexit_data[numeric_variable_list] # same as - numeric_variable_list == TRUE
