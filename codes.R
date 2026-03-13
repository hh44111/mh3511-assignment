library(tidyquant)
library(tidyverse)
library(lubridate)

#filter appearances
appearances <- read.csv("appearances.csv")
start_date <- as.Date("2024-08-16")
end_date <- as.Date("2025-05-25")

#filter to premier league appearance (GB1) 
appearances2 <- appearances[appearances$date >= start_date & appearances$date <= end_date,]
appearances2 <- appearances2 %>%
  filter(competition_id == "GB1") %>%
  select(player_id, game_id, player_club_id, date, player_name, competition_id, minutes_played)
View(appearances2)

players <- read.csv("players.csv")
players2 <- merge(appearances2, players, by = "player_id")
players2 <- players2 %>%
  mutate(age = floor(time_length(interval(players2$date_of_birth, "2025-05-25"), "years"))) %>%
  select(player_id, date_of_birth, position, sub_position, current_club_id, market_value_in_eur, game_id, player_club_id, date, player_name, competition_id, minutes_played, age)
View(players2)
