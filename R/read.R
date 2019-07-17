#' Read county population estimates data
#'
#' @param year Vintage year
#' @return Data frame
#' @export
read_county <- function(year) {
  if (year %in% 2011:2019) {
    read_county_2010(year)
  } else {
    stop("Year not implemented.", call. = FALSE)
  }
}

read_county_2010 <- function(year) {
  stopifnot(year %in% 2011:2019)
  file <- paste0(
    "https://www2.census.gov/programs-surveys/popest/datasets/2010-",
    year, "/counties/asrh/cc-est", year, "-alldata.csv"
  )
  data.table::fread(file)
}
