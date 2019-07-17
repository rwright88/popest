# test county

library(tidyverse)
library(popest)

year <- 2018

# get data ----------------------------------------------------------------

data <- read_county(year = year)
data <- clean_county(data, year = year)

# metros ------------------------------------------------------------------

data <- data %>%
  left_join(popest::cw_metro, by = c("county" = "county_fips"))

tots <- data %>%
  filter(year == max(year)) %>%
  group_by(cbsa_code, cbsa_name) %>%
  summarise(pop = sum(pop)) %>%
  ungroup()

dists <- data %>%
  filter(year == max(year)) %>%
  group_by(cbsa_code, cbsa_name, race) %>%
  summarise(pop = sum(pop)) %>%
  group_by(cbsa_code, cbsa_name) %>%
  mutate(percent = round(pop / sum(pop) * 100, 1)) %>%
  ungroup() %>%
  select(-pop) %>%
  spread(race, percent)

tots %>%
  left_join(dists, by = c("cbsa_code", "cbsa_name")) %>%
  select(cbsa_code, cbsa_name, pop, white, hispanic, black, asian) %>%
  arrange(desc(pop))
