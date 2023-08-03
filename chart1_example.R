library(ggplot2)
library(tidyverse)
library(dplyr)
library(readr)

prison <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true")

top_states <- prison %>%
  group_by(state) %>%
  summarise(total_pop = sum(total_pop, na.rm = TRUE)) %>%
  arrange(desc(total_pop)) %>%
  slice(1:5) %>%
  pull(state)

data <- prison %>%
  filter(state %in% top_states)

ggplot(data) +
  geom_line(mapping = aes(
    x = year,
    y = total_pop,
    color = state
  )) +
  labs(title = "Trend in Total Population of Prisoners for Top 5 States",
       x = "Year",
       y = "Total Population",
       color = "Top States")