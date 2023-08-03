library(ggplot2)
library(tidyverse)
library(dplyr)
library(readr)

prison <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true")

data1 <- prison %>%
  filter(year >= 1980, year <= 2018) %>%
  group_by(year) %>%
  summarise(total_pop = sum(total_pop, na.rm = TRUE),
            black_pop = sum(black_prison_pop, na.rm = TRUE),
            white_pop = sum(white_prison_pop, na.rm = TRUE))

ggplot(data1, aes(x = year, y = black_pop, color = "Black Population")) +
  geom_point(aes(y = black_pop, color = "Black Population"), size = 1) +
  geom_point(aes(y = white_pop, color = "White Population"), size = 1) +
  labs(title = "Contrasting Black and White Populations of Prisoners",
       x = "Year",
       y = "Total Population",
       color = "Population Type")