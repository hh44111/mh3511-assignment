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
  select(player_id, game_id, player_club_id, date, player_name, competition_id, minutes_played, goals, assists)
View(appearances2)

#merge dataset to get player details, include their age and relevant columns
players <- read.csv("players.csv")
players2 <- merge(appearances2, players, by = "player_id")
players2 <- players2 %>%
  mutate(age = floor(time_length(interval(players2$date_of_birth, "2025-05-25"), "years"))) %>%
  mutate(market_value = market_value_in_eur * 1.47) %>%
View(players2)

#adding club name
clubs <- read.csv("clubs.csv", header = TRUE)
colnames(clubs)[1] <- "player_club_id"
clubs <- select(clubs, player_club_id, name)
View(clubs)
players2 <- merge(clubs, players2, by = "player_club_id") %>%
  select(sub_position, market_value, date, player_name, minutes_played, age, goals, assists)
View(players2)

#total minutes played, goals and assists by each player
players3 <- players2 %>%
  group_by(player_name) %>%
  summarise(total_minutes_played = sum(minutes_played),
            total_goals = sum(goals),
            total_assists = sum(assists))
View(players3)

