library(tidyquant)
library(tidyverse)
library(lubridate)

appearances <- read.csv("appearances.csv", header = TRUE)
start_date <- as.Date("2024-08-16")
end_date <- as.Date("2025-05-25")

#filter to premier league appearance (GB1) 
appearances2 <- appearances[appearances$date >= start_date & appearances$date <= end_date,]
appearances2 <- appearances2 %>%
  filter(competition_id == "GB1") %>%
  select(player_id, game_id, player_club_id, date, player_name, competition_id, minutes_played, goals, assists)

#merge dataset to get player details, include their age and relevant columns
players <- read.csv("players.csv", header = TRUE)
players2 <- merge(appearances2, players, by = "player_id")
players2 <- players2 %>%
  mutate(age = floor(time_length(interval(players2$date_of_birth, "2025-05-25"), "years"))) 

clubs <- read.csv("clubs.csv", header = TRUE)
colnames(clubs)[1] <- "player_club_id"
clubs <- select(clubs, player_club_id, name)
View(clubs)
players2 <- merge(clubs, players2, by = "player_club_id")


club_wins <- read.csv("club_games.csv", header = TRUE)
club_wins2 <- merge(club_wins, players2, by = "game_id") %>%
  select(player_id, sub_position, market_value_in_eur, player_name, minutes_played, goals, assists, is_win, age)
View(club_wins2)

player_data <- club_wins2 %>%
  group_by(player_name) %>%
  summarise(player_id = first(player_id),
            total_minutes_played = sum(minutes_played),
            total_goals = sum(goals),
            total_assists = sum(assists),
            total_wins = sum(is_win),
            sub_position = first(sub_position),
            market_value_in_eur = first(market_value_in_eur),
            age = first(age),
            .groups = "drop"
  )
View(player_data) #final dataset to be used
