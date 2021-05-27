library('stringr')
library('ggplot2')
library('dplyr')

# load the data
df <- read.csv('nh.csv')

# format the date
df$Week.Ending <- as.Date(as.character(df$Week.Ending), format="%m/%d/%Y")


# Geolocation to lat, lon
df$Geolocation <- as.character(df$Geolocation)
df$Geolocation[which(df$Geolocation=='')] <- NA
df$Geolocation <- substr(df$Geolocation, 8, nchar(df$Geolocation)-1)
df$lat <- as.numeric(str_split_fixed(df$Geolocation, " ", 2)[, 2])
df$lon <- as.numeric(str_split_fixed(df$Geolocation, " ", 2)[, 1])
df$Geolocation <- NULL

# some nursing homes are reporting 0 beds, most likely a data error
df$Number.of.All.Beds[which(df$Number.of.All.Beds==0)] <- NA

# some nursing homes are reporting more beds full than total beds
df$Number.of.All.Beds[which(df$Total.Number.of.Occupied.Beds > df$Number.of.All.Beds)] <- NA

# calculate how full each nursing home is
df$pct_full <- df$Total.Number.of.Occupied.Beds / df$Number.of.All.Beds

# some data errors
df$Total.Resident.Confirmed.COVID.19.Cases.Per.1.000.Residents[which(df$Total.Resident.Confirmed.COVID.19.Cases.Per.1.000.Residents > 1000)] <- NA
df$Total.Resident.COVID.19.Deaths.Per.1.000.Residents[which(df$Total.Resident.COVID.19.Deaths.Per.1.000.Residents > 1000)] <- NA
df$Weekly.Resident.Confirmed.COVID.19.Cases.Per.1.000.Residents[which(df$Weekly.Resident.Confirmed.COVID.19.Cases.Per.1.000.Residents > 1000)] <- NA

# set NAs
df$Shortage.of.Nursing.Staff <- factor(df$Shortage.of.Nursing.Staff, exclude = "")
df$Shortage.of.Aides <- factor(df$Shortage.of.Aides, exclude = "")
df$Shortage.of.Clinical.Staff <- factor(df$Shortage.of.Clinical.Staff, exclude = "")
df$Shortage.of.Other.Staff <- factor(df$Shortage.of.Other.Staff, exclude = "")
df$Tested.Asymptomatic.Residents.Facility.Wide.After.a.New.Case <- factor(df$Tested.Asymptomatic.Residents.Facility.Wide.After.a.New.Case, exclude = "")
df$Tested.Asymptomatic.Residents.Without.Known.Exposure.as.Surveillance <- factor(df$Tested.Asymptomatic.Residents.Without.Known.Exposure.as.Surveillance, exclude = '')


# Round up the data - most recent row for each nursing home
df_ru <- df %>% 
  group_by(Federal.Provider.Number) %>%
  slice(which.max(as.Date(Week.Ending, '%m/%d/%Y')))

#save(df_ru, file="df_ru.Rda")
