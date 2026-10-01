
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rosenkohl

<!-- badges: start -->

[![R-CMD-check](https://github.com/brueckmann/rosenkohl/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/brueckmann/rosenkohl/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of rosenkohl is to easily load some frequently used helper
functions. They are mostly useful for on-the-fly testing and or data
preparations.

**NOTE:** This is mostly a toy package created because of a discussion
over lunch at [Uni Bern’s IPW](https://www.ipw.unibe.ch/). My colleagues
thought I was (still) talking about [R Packages](https://r-pkgs.org),
when I mentioned
[rosenkohl](https://upload.wikimedia.org/wikipedia/commons/d/d4/Brussels_sprouts_-_geograph.org.uk_-_684256.jpg?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=original),
Brussels sprouts. Somehow, we ended up joking that this R package should
exist. Now, it does! I use it to bundle helper functions I sometimes
use.

## Installation

You can install the development version of rosenkohl from
[GitHub](https://github.com/brueckmann/rosenkohl) with:

``` r
# install.packages("pak")
pak::pak("brueckmann/rosenkohl")
```

The current development version is 0.0.0.9001.

## Examples

### ABC function

This is a basic example which shows you how to sort a string
alphabetically, using `abc()`. This is intended to be used
*interactively*, therefore, it comes with multiple output formats.

``` r
library(rosenkohl)
## basic example code

### assume you have unordered strings
x <- "charlie, delta, alpha,bravo"
y <- c("delta", "charlie bravo", "alpha")

### see the different output formats and the aliases
abc(x, format_output = TRUE)
#> c("alpha",
#> "bravo",
#> "charlie",
#> "delta")
alphabetise(x, format_output = FALSE) # use the alias
#> [1] "alpha"   "bravo"   "charlie" "delta"
abc(x, format_output = "inline")
#> alpha, bravo, charlie, delta

abc(y, format_output = TRUE)
#> c("alpha",
#> "charlie bravo",
#> "delta")
abc(y, format_output = FALSE)
#> [1] "alpha"         "charlie bravo" "delta"
alphabetize(y, format_output = "inline") # use the alias
#> alpha, charlie bravo, delta
```

### add_date function

This is a tiny example of how `add_date()` can be used:

``` r
library(rosenkohl)
## basic example code
add_date("example", "_from_")
#> [1] "example_from_2026_10_01"
add_date("today.R")
#> [1] "today_2026_10_01.R"

# create temp folder with subfolder demo
# define your path
temp <- file.path(tempdir(), "demo")
# remove everything in temp
unlink(temp, recursive = TRUE)   
# create directory 
dir.create(temp)

writeLines("x",        
           file.path(temp, 
                     add_date("test.R")
           )
) 

#return file names 
list.files(temp)
#> [1] "test_2026_10_01.R"
```

### cleanup function

This exemplifies the cleanup function `cleanup()`. The function can also
be called by their aliases `tempex()` or `temprm()`.

``` r
library(rosenkohl)

## Create some noise. 
### create things to be kept
temptation_to_keep <- data.frame(x = 1, 
                         y = 1:10, 
                         char = sample(LETTERS[1:3], 10, replace = TRUE))
url_to_keep <- "https://www.nothing_temp.csv"
### create things to be deleted: 
list_temp <- c(char = sample(LETTERS[1:3], 10, replace = TRUE))
temp_url <- "https://raw.githubusercontent.com/tidyverse/dplyr/main/data-raw/starwars.csv"
temp_dir <- file.path(tempdir(), "demo")
#### define a temp function
temp_function <- function(x) {
x + 1
}
## Some noice was created.
# use function but turn off  verbose
cleanup(verbose = FALSE)

# use function with own pattern
cleanup(pattern = "_to_keep")
#> No objects matched pattern: _to_keep

## create another temporary list again
temporary_list <- c("something", "else")
# use function with own pattern
cleanup(pattern="temporary_")
#> No objects matched pattern: temporary_

# use function when nothing is available that matches the pattern
cleanup(pattern="precious")
#> No objects matched pattern: precious

# use function when nothing is available matching the pattern - but a function
cleanup()
#> No objects matched pattern: (_temp|temp_)

# remove the temp-function
cleanup(keep.functions = FALSE)
#> No objects matched pattern: (_temp|temp_)
```

### lazysave function

This is a tiny example of how to save with `lazysave()`:

``` r
library(rosenkohl)

# create a dataframe called data
data <- data.frame(x = 1, 
                   y = 1:10, 
                   char = sample(LETTERS[1:3], 10, replace = TRUE))

# create temp folder with a subfolder
# define your path
temp <- file.path(tempdir(), "demo")
# remove everything in temp
unlink(temp, recursive = TRUE)   
# create directory 
dir.create(temp)


lazysave(data)
#> Success! data as data.rds saved to `tempdir` (/var/folders/pk/h829gy097wn5t4s545qbf60m0000gp/T//RtmpoMVex2).
list.files(temp) # still empty, as default path out is tempdir.
#> character(0)

# you may append the date to the filename
lazysave(data, dir = temp, date=TRUE, datesep = "", extension = "rdata")
#> Success! data as data2026_10_01.RData saved to temp (/var/folders/pk/h829gy097wn5t4s545qbf60m0000gp/T//RtmpoMVex2/demo).
# return file names 
list.files(temp) # file saved.
#> [1] "data2026_10_01.RData"

# lazysave() doesn't mind dot(s) in extensions  (but rds is the default)
lazysave(data, dir = temp, date=TRUE, datesep = "-", extension = ".r.ds.")
#> Success! data as data-2026_10_01.rds saved to temp (/var/folders/pk/h829gy097wn5t4s545qbf60m0000gp/T//RtmpoMVex2/demo).
# lazysave() doesn't mind capitalisation or not in extension
lazysave(data, dir = temp, extension = "RDATA")
#> Success! data as data.RData saved to temp (/var/folders/pk/h829gy097wn5t4s545qbf60m0000gp/T//RtmpoMVex2/demo).
```

### sourcelines function

This is a (very constructed) example which shows how `sourcelines()`
works.

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

### summ_unique function

This is a (very constructed) example which shows how `summ_unique()`
works.

``` r
library(rosenkohl)
## basic example code

# generate an example dataframe
df_no_na <- data.frame(x = 1, # 1 unique value
y = 1:10, # 10 unique values 
char = sample(LETTERS[1:3], 10, replace = TRUE)) # max 3 unique values
summ_unique(df_no_na) 
#>   column n_unique_incl_NA n_unique_wo_NA no_NAs
#> 1      x                1              1   TRUE
#> 2      y               10             10   TRUE
#> 3   char                3              3   TRUE
# add row with NAs
row <- c(NA, 10, NA)
df_with_NAs <- rbind.data.frame(df_no_na, row)
summarise_unique(df_with_NAs) # use the alias
#>   column n_unique_incl_NA n_unique_wo_NA no_NAs
#> 1      x                2              1  FALSE
#> 2      y               10             10   TRUE
#> 3   char                4              3  FALSE
summ_unique(df_with_NAs, has.na = TRUE)  # show if cols have NAs
#>   column n_unique_incl_NA n_unique_wo_NA has_NAs
#> 1      x                2              1    TRUE
#> 2      y               10             10   FALSE
#> 3   char                4              3    TRUE

# See what happens when everything is NA
num_na <- row[-2] # numeric NA
logi_na <- c(NA, NA) # logical NA
char_na <- c(NA_character_,NA_character_) # character NA
df_na <- data.frame(num_na, logi_na, char_na)
summ_unique(df_na)
#>    column n_unique_incl_NA n_unique_wo_NA no_NAs
#> 1  num_na                1              0  FALSE
#> 2 logi_na                1              0  FALSE
#> 3 char_na                1              0  FALSE
```

## Bug reports

Report an issue on <https://github.com/brueckmann/rosenkohl/issues>.

## Even

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. -->
