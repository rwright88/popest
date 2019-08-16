# pop forecasts

library(dplyr)
library(forecast)
library(ggplot2)
library(popest)

year <- 2018

# funs --------------------------------------------------------------------

get_data <- function(year) {
  data <- read_county(year = year)
  data <- clean_county(data, year = year)
  data$age2 <- rec_age(data$age)

  data %>%
    group_by(year, age2, race) %>%
    summarise(pop = sum(pop)) %>%
    group_by(year, age2) %>%
    mutate(d = pop / sum(pop)) %>%
    ungroup()
}

rec_age <- function(x) {
  out <- rep(NA_character_, length(x))
  out[x %in% c("0-4", "5-9", "10-14", "15-19")]     <- "0-19"
  out[x %in% c("20-24", "25-29", "30-34", "35-39")] <- "20-39"
  out[x %in% c("40-44", "45-49", "50-54", "55-59")] <- "40-59"
  out[x %in% c("60-64", "65-69", "70-74", "75-79")] <- "60-79"
  out
}

calc_fc <- function(data, h = 10) {
  years <- range(data$year)
  data <- group_by(data, age2, race)
  data <- summarise(data,
    fc = list(forecast(ts(d, start = !!years[1], end = !!years[2]), h = !!h))
  )
  data <- ungroup(data)
  data$year <- lapply(data$fc, function(.x) {
    stats::time(.x$mean)
  })
  data$d <- lapply(data$fc, function(.x) {
    .x$mean
  })
  data$fc <- NULL
  unnest(data)
}

# run ---------------------------------------------------------------------

res <- get_data(year = year)

fc <- calc_fc(res, h = 10)

both <- bind_rows(res, fc)
both

both %>%
  filter(!is.na(age2), race == "white") %>%
  mutate(age2 = reorder(age2, desc(d))) %>%
  ggplot(aes(year, d, color = age2)) +
  geom_point(size = 1.5) +
  geom_line(size = 1) +
  scale_color_brewer(type = "qual", palette = "Set1") +
  coord_cartesian(ylim = c(0, 1)) +
  theme_bw()
