library('stringr')
library('ggplot2')
library('dplyr')

source("load.R")

ggplot(df, aes(y=pct_full * 100)) +
  geom_boxplot(notch=TRUE) +
  labs(title = "Nursing Home Percent Full", y="Percent Full")


# Deaths over time
ggplot(df, aes(x=Week.Ending, y=Weekly.Resident.COVID.19.Deaths.Per.1.000.Residents)) +
  geom_smooth()

# Cases over time
ggplot(df, aes(x=Week.Ending, y=Weekly.Resident.Confirmed.COVID.19.Cases.Per.1.000.Residents)) +
  geom_smooth()


# Deaths, cases over time
ggplot(df, aes(Week.Ending)) + 
  geom_smooth(aes(y = Weekly.Resident.COVID.19.Deaths.Per.1.000.Residents, color = "Deaths")) + 
  geom_smooth(aes(y = Weekly.Resident.Confirmed.COVID.19.Cases.Per.1.000.Residents, color = "Cases")) +
  labs(x="Week Ending", y="Per 1,000 Residents", title = "Cases & Deaths Over Time")


ggplot(df, aes(x = Week.Ending, y = Weekly.Resident.COVID.19.Deaths.Per.1.000.Residents)) + 
  geom_line(aes(color = 'red')) 


qplot(df_ru$Total.Resident.Confirmed.COVID.19.Cases.Per.1.000.Residents, df_ru$Total.Resident.COVID.19.Deaths.Per.1.000.Residents) +
  stat_smooth() +
  labs(title = "Total COVID Cases vs Total COVID Deaths", x="Total COVID Cases per 1,000 Residents", y="Total COVID Deaths per 1,000 Residents")

# Relationship between staff and resident COVID cases
qplot(df_ru$Staff.Total.Confirmed.COVID.19, df_ru$Residents.Total.Confirmed.COVID.19) +
  labs(x="Staff Total COVID-19 Cases", y="Resident Total COVID-19 Cases") +
  geom_smooth(method = "lm", formula = 'y ~ x')
  
  
qplot(df_ru$pct_full, df_ru$Staff.Total.Confirmed.COVID.19) +
  labs() +
  geom_smooth(method = "lm", formula = 'y ~ x')

qplot(df_ru$pct_full * 100, df_ru$Residents.Total.Confirmed.COVID.19) +
  labs(x="Percent of beds occupied", y="Resident Total COVID-19 Cases") +
  geom_smooth(method = "lm", formula = 'y ~ x')  

qplot(df_ru$pct_full * 100, df_ru$Total.Resident.Confirmed.COVID.19.Cases.Per.1.000.Residents) +
  labs(x="Percent of beds occupied", y="Resident COVID-19 Cases per 1,000 Residents") +
  geom_smooth()  

qplot(df_ru$pct_full * 100, df_ru$Total.Resident.COVID.19.Deaths.Per.1.000.Residents) +
  labs(x="Percent of beds occupied", y="Resident COVID-19 Deaths per 1,000 Residents") +
  geom_smooth()


ggplot(df_ru, aes(x=Provider.State, y=Total.Resident.Confirmed.COVID.19.Cases.Per.1.000.Residents)) +
  geom_boxplot() +
  labs(x = "State", y = "COVID cases per 1,000 residents")

ggplot(df_ru, aes(x=Provider.State, y=Total.Resident.COVID.19.Deaths.Per.1.000.Residents)) +
  geom_boxplot() +
  labs(x = "State", y = "COVID deaths per 1,000 residents")


# How do staff shortages impact cases?

ggplot(df_ru[which(!is.na(df_ru$Shortage.of.Nursing.Staff)),], aes(y=Total.Resident.Confirmed.COVID.19.Cases.Per.1.000.Residents, x=Shortage.of.Nursing.Staff )) +
  geom_boxplot() +
  labs(y = "COVID cases per 1,000 residents", x="Shorting of Nursing Staff?")

ggplot(df_ru[which(!is.na(df_ru$Shortage.of.Clinical.Staff)),], aes(y=Total.Resident.Confirmed.COVID.19.Cases.Per.1.000.Residents, x=Shortage.of.Clinical.Staff )) +
  geom_boxplot() +
  labs(y = "COVID cases per 1,000 residents", x="Shorting of Clinical Staff?")

ggplot(df_ru[which(!is.na(df_ru$Shortage.of.Aides)),], aes(y=Total.Resident.Confirmed.COVID.19.Cases.Per.1.000.Residents, x=Shortage.of.Aides )) +
  geom_boxplot() +
  labs(y = "COVID cases per 1,000 residents", x="Shorting of Aides Staff?")

ggplot(df_ru[which(!is.na(df_ru$Shortage.of.Other.Staff)),], aes(y=Total.Resident.Confirmed.COVID.19.Cases.Per.1.000.Residents, x=Shortage.of.Other.Staff )) +
  geom_boxplot() +
  labs(y = "COVID cases per 1,000 residents", x="Shorting of Other Staff?")

