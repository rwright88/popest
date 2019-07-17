#' Clean county population estimates data
#'
#' Transforms the data read with read_county so that each column is one
#' variable. Only returns selected race and hispanic origin estimates.
#'
#' @param data Data frame read with read_county
#' @param year Vintage year
#' @return Data frame
#' @export
clean_county <- function(data, year) {
  stopifnot(is.data.frame(data))
  if (year %in% 2011:2019) {
    clean_county_2010(data)
  } else {
    stop("Year not implemented.", call. = FALSE)
  }
}

clean_county_2010 <- function(data) {
  stopifnot(is.data.frame(data))

  vars_wide <- c(
    "year",
    "state",
    "county",
    "agegrp",
    "nhwa_male",
    "nhwa_female",
    "nhba_male",
    "nhba_female",
    "nhia_male",
    "nhia_female",
    "nhaa_male",
    "nhaa_female",
    "nhna_male",
    "nhna_female",
    "nhtom_male",
    "nhtom_female",
    "h_male",
    "h_female"
  )

  data <- dplyr::as_tibble(data)
  data <- set_names(data, tolower(names(data)))
  data <- data[, vars_wide]
  data <- data[data$year %in% 3:12, ]
  data <- data[data$agegrp != 0, ]

  data$year <- rec_year_2010(data$year)
  data$county <- rec_county(state = data$state, county = data$county)
  data$state <- NULL
  data$age <- rec_age_2010(data$agegrp)
  data$agegrp <- NULL

  vars_gather <- vars_wide[!(vars_wide %in% c("year", "state", "county", "agegrp"))]
  data <- tidyr::gather(data, "race_sex", "pop", !!vars_gather)

  data$sex <- rec_sex(data$race_sex)
  data$race <- rec_race(data$race_sex)
  data$race_sex <- NULL

  data <- data[, c("year", "county", "sex", "age", "race", "pop")]
  data
}
