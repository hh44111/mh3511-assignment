library(tidyquant); library(tidyverse)
library(lubridate)

#filter appearances
appearances <- read.csv("appearances.csv")
View(appearances)
summary(appearances)
str(appearances)
#appearances$dates <- as.Date(appearances$date)

start_date <- as.Date("2024-08-16")
end_date <- as.Date("2025-05-25")

appearances2 <- appearances[appearances$date >= start_date & appearances$date <= end_date,]

appearances3 <- appearances2 %>% 
#  arrange(desc(dates)) %>%
#  filter(filter(date >= start_date & date <= end_date)) %>%
  select(player_id, player_club_id, goals, assists, minutes_played, date)
View(appearances2)

