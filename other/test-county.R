# test county

library(tidyverse)
library(popest)
library(rwmisc)


# get data ----------------------------------------------------------------

# dat <- read_county(year = 2017)
dat <- data.table::fread("~/cc-est2017-alldata.csv")
dat <- clean_county(dat, year = 2017)

summary2(dat)

# metros ------------------------------------------------------------------

dat <- dat %>%
  left_join(popest::cw_metro, by = c("county" = "county_fips"))

tots <- dat %>%
  filter(year == max(year)) %>%
  group_by(cbsa_code, cbsa_name) %>%
  summarise(pop = sum(pop)) %>%
  ungroup()

dists <- dat %>%
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
  select(-multiple, -native, -pacific) %>%
  filter(rank(desc(pop)) <= 100) %>%
  arrange(desc(asian))
