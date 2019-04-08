#' Read county population estimates data
#'
#' @param year Vintage year
#' @return Data frame
#' @export
read_county <- function(year) {
  if (year %in% 2011:2017) {
    data <- read_county_2010(year)
  } else {
    stop("Year not implemented.", call. = FALSE)
  }

  data
}

read_county_2010 <- function(year) {
  stopifnot(year %in% 2011:2017)

  file <- paste0(
    "https://www2.census.gov/programs-surveys/popest/datasets/2010-",
    year, "/counties/asrh/cc-est", year, "-alldata.csv"
  )
  data <- data.table::fread(file)
  data
}