rec_age_2010 <- function(x) {
  out <- rep(NA_character_, length(x))
  age5 <- (x %in% 1:17)
  out[age5] <- paste0(x[age5] * 5 - 5, "-", x[age5] * 5 - 1)
  out[x == 18] <- "85+"
  out
}

rec_county <- function(state, county) {
  paste0(
    stringr::str_pad(state, width = 2, pad = "0"),
    stringr::str_pad(county, width = 3, pad = "0")
  )
}

rec_race <- function(x) {
  out <- rep(NA_character_, length(x))
  out[grepl(pattern = "nhwa", x = x, perl = TRUE)]  <- "white"
  out[grepl(pattern = "nhba", x = x, perl = TRUE)]  <- "black"
  out[grepl(pattern = "nhia", x = x, perl = TRUE)]  <- "native"
  out[grepl(pattern = "nhaa", x = x, perl = TRUE)]  <- "asian"
  out[grepl(pattern = "nhna", x = x, perl = TRUE)]  <- "pacific"
  out[grepl(pattern = "nhtom", x = x, perl = TRUE)] <- "multiple"
  out[grepl(pattern = "h_", x = x, perl = TRUE)]    <- "hispanic"
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
