library(tidyverse)
library(dplyr)
library(readr)

prison <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true")

### Summary Information

# Total prison population in 2018
total_pop_2018 <- prison %>%
  filter(year == 2018) %>%
  summarise(total_pop_2018 = sum(total_pop, na.rm = TRUE)) %>%
  pull(total_pop_2018)
total_pop_2018

# Average prison population in 2018
average_value_2018 <- prison %>%
  filter(year == 2018) %>%
  summarise(average_value = mean(total_pop))
average_value_2018

# State with highest prison population
state_highest_cases <- prison %>%
  filter(total_pop == max(total_pop)) %>%
  pull(state)
unique(state_highest_cases)

# Highest number of prison population
num_highest_state <- prison %>%
  filter(total_pop == max(total_pop)) %>%
  pull(total_pop)
unique(num_highest_state)

# States with lowest prison population
state_lowest_cases <- prison %>%
  filter(total_pop == min(total_pop)) %>%
  pull(state)
unique(state_lowest_cases)

# Lowest number of prison population
num_lowest_state <- prison %>%
  filter(total_pop == min(total_pop)) %>%
  pull(total_pop)
unique(num_lowest_state)

# Black prison population rate in 2018
black_pop_2018 <- prison %>%
  filter(year == 2018) %>%
  summarise(black_pop_2018 = sum(black_pop_15to64, na.rm = TRUE)) %>%
  pull(black_pop_2018)
ratio_black_to_total_pop <- black_pop_2018 / total_pop_2018
ratio_black_to_total_pop

# White prison population rate
white_pop_2018 <- prison %>%
  filter(year == 2018) %>%
  summarise(white_pop_2018 = sum(white_pop_15to64, na.rm = TRUE)) %>%
  pull(white_pop_2018)
ratio_white_to_total_pop <- white_pop_2018 / total_pop_2018
ratio_white_to_total_pop

### The Dataset
observations <- nrow(prison)
observations
features <- ncol(prison)
features
