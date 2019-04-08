# Script to create county-metro crosswalk.

library(readr)
library(dplyr)
library(stringr)

file_cw <- "https://www2.census.gov/programs-surveys/popest/datasets/2010-2017/metro/totals/cbsa-est2017-alldata.csv"

create_cw <- function(file) {
  vars <- cols_only(
    CBSA = "c",
    STCOU = "c",
    NAME = "c",
    LSAD = "c"
  )

  data <- read_csv(file, col_types = vars)
  data <- setNames(data, str_to_lower(names(data)))
  data <- mutate_if(data, is.character, str_to_lower)
  data$stcou <- str_pad(data$stcou, width = 5, pad = "0")

  types <- c("metropolitan statistical area", "micropolitan statistical area")
  metros <- data[data$lsad %in% types, c("cbsa", "name")]

  out <- data[data$lsad == "county or equivalent", c("cbsa", "stcou", "name")]
  out <- left_join(out, metros, by = "cbsa")
  out <- setNames(out, c("cbsa_code", "county_fips", "county_name", "cbsa_name"))
  out <- out[, c("county_fips", "county_name", "cbsa_code", "cbsa_name")]
  out
}

cw_metro <- create_cw(file_cw)

usethis::use_data(cw_metro, overwrite = TRUE)
