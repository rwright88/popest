
<!-- README.md is generated from README.Rmd. Please edit that file -->

# popest

Tools to get US Census Bureau [population
estimates](https://www.census.gov/programs-surveys/popest.html) data.

## Installation

``` r
devtools::install_github("rwright88/popest")
```

## Examples

Get vintage 2018 population data by county:

``` r
library(popest)

year <- 2018
data <- popest::read_county(year)
data <- popest::clean_county(data, year)
data
```

    #> # A tibble: 7,126,056 x 6
    #>     year county sex   age   race    pop
    #>    <int> <chr>  <chr> <chr> <chr> <int>
    #>  1  2010 01001  male  0-4   white  1340
    #>  2  2010 01001  male  5-9   white  1445
    #>  3  2010 01001  male  10-14 white  1608
    #>  4  2010 01001  male  15-19 white  1554
    #>  5  2010 01001  male  20-24 white  1167
    #>  6  2010 01001  male  25-29 white  1192
    #>  7  2010 01001  male  30-34 white  1246
    #>  8  2010 01001  male  35-39 white  1534
    #>  9  2010 01001  male  40-44 white  1595
    #> 10  2010 01001  male  45-49 white  1771
    #> # ... with 7,126,046 more rows
