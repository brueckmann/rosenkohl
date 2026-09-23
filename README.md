
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rosenkohl

<!-- badges: start -->

<!-- badges: end -->

The goal of rosenkohl is to easily load some frequently used helper
functions.

## Installation

You can install the development version of rosenkohl from
[GitHub](https://github.com/brueckmann/rosenkohl) with:

``` r
# install.packages("pak")
pak::pak("brueckmann/rosenkohl")
```

## Example

This is a basic example which shows you how to sort a string
alphabetically.

``` r
library(rosenkohl)
## basic example code

### assume you have unordered strings
x <- "charlie,delta,alpha,bravo"
y <- c("delta", "charlie", "bravo", "alpha")

### see the different output formats and the aliases
abc(x, format_output = TRUE)
#> c("alpha",
#> "bravo",
#> "charlie",
#> "delta")
alphabetise(x, format_output = FALSE)
#> [1] "alpha"   "bravo"   "charlie" "delta"
abc(x, format_output = "inline")
#> alpha, bravo, charlie, delta

abc(y, format_output = TRUE)
#> c("alpha",
#> "bravo",
#> "charlie",
#> "delta")
abc(y, format_output = FALSE)
#> [1] "alpha"   "bravo"   "charlie" "delta"
alphabetize(y, format_output = "inline")
#> alpha, bravo, charlie, delta
```

This is a (very constructed) example which shows how sourcelines works.

``` r
library(rosenkohl)
## basic example code

# create a file to source it 
inputfile <-  tempfile(fileext = ".R")
# Write content to the file
writeLines(text = "1+0 \n 2+0 \n 3+0",
           con = inputfile)
# Check the file exists
file.exists(inputfile)
#> [1] TRUE
# source whole file loudly
source(inputfile, echo = TRUE)
#> 
#> > 1 + 0
#> [1] 1
#> 
#> > 2 + 0
#> [1] 2
#> 
#> > 3 + 0
#> [1] 3

# source first line
sourcelines(inputfile, 1, TRUE)
#> 
#> > 1 + 0
#> [1] 1
# source second and third line
sourcelines(inputfile, 2:3, TRUE)
#> 
#> > 2 + 0
#> [1] 2
#> 
#> > 3 + 0
#> [1] 3
# source first and third till (non-existing fourth) line
sourcelines(inputfile, c(1,3:4), TRUE)
#> 
#> > 1 + 0
#> [1] 1
#> 
#> > 3 + 0
#> [1] 3
#> 
#> > NA
#> [1] NA
```

## Bug reports

Report an issue on <https://github.com/brueckmann/rosenkohl/issues>.

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. -->
