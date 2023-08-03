library(dplyr)
library(readr)
library(ggplot2)
library(maps)
library(scales)

rate <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-jail-rates.csv?raw=true")

rate_filtered <- rate %>%
  filter(!is.na(black_jail_pop_rate))
state_indices <- match(rate_filtered$state, state.abb)
state_names <- state.name[state_indices]
state_names_lower <- tolower(state_names)
rate_filtered$state <- state_names_lower
state_shape <- map_data("state")

aggregate_data <- rate_filtered %>%
  filter(year == 2018) %>%
  group_by(state) %>%
  summarize(black_jail_pop_rate = mean(black_jail_pop_rate, na.rm = TRUE))

aggregate_data2 <- left_join(
  aggregate_data, state_shape, by = c("state" = "region"))

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(), # remove axis lines
    axis.text = element_blank(), # remove axis labels
    axis.ticks = element_blank(), # remove axis ticks
    axis.title = element_blank(), # remove axis titles
    plot.background = element_blank(), # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank(), # remove border around plot
  )

ggplot(aggregate_data2) +
  geom_polygon(mapping = aes(x = long,
                             y = lat,
                             group = group,
                             fill = black_jail_pop_rate)) +
  scale_fill_continuous(low = "pink",
                        high = "red",
                        labels = comma_format()) +
  labs(title = "Distribution of Black Jail Population Rate by State in 2018",
       fill = "Black Jail Population Rate") + 
  coord_map() +
  blank_theme