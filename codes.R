library(tidyquant); library(tidyverse)
library(lubridate)

#filter appearances
appearances <- read.csv("appearances.csv")
View(appearances)
summary(appearances)
str(appearances)

start_date <- as.Date("2024-08-16")
end_date <- as.Date("2025-05-25")
appearances2 <- appearances[appearances$date >= start_date & appearances$date <= end_date,]
View(appearances2)

appearances3 <- appearances2 %>% 
  select(player_id, player_club_id, goals, assists, minutes_played, date)
View(appearances3)

