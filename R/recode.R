rec_age_2010 <- function(x) {
  out <- rep(NA_character_, length(x))
  age5 <- (x %in% 1:17)
  out[age5] <- paste0(x[age5] * 5 - 5, "-", x[age5] * 5 - 1)
  out[x == 18] <- "85+"
  out
}

rec_county <- function(state, county) {
  paste0(
    formatC(state, width = 2, format = "d", flag = "0"),
    formatC(county, width = 3, format = "d", flag = "0")
  )
}

rec_race <- function(x) {
  out <- rep(NA_character_, length(x))
  out[x %in% c("nhwa_male", "nhwa_female")]   <- "white"
  out[x %in% c("nhba_male", "nhba_female")]   <- "black"
  out[x %in% c("nhia_male", "nhia_female")]   <- "native"
  out[x %in% c("nhaa_male", "nhaa_female")]   <- "asian"
  out[x %in% c("nhna_male", "nhna_female")]   <- "pacific"
  out[x %in% c("nhtom_male", "nhtom_female")] <- "multiple"
  out[x %in% c("h_male", "h_female")]         <- "hispanic"
  out
}

rec_sex <- function(x) {
  out <- rep(NA_character_, length(x))
  out[grepl(pattern = "_male", x = x, perl = TRUE)]   <- "male"
  out[grepl(pattern = "_female", x = x, perl = TRUE)] <- "female"
  out
}

rec_year_2010 <- function(x) {
  out <- rep(NA_integer_, length(x))
  out[x %in% 3:12] <- x[x %in% 3:12] + 2007L
  out
}
