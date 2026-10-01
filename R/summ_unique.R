
#' Summarise and report number of unique values and NAs
#' 
#' Summarise and report number of unique values as well as the presence of NAs
#' for each variable in a dataframe.
#'
#' @param df a dataframe to summarise.
#' @param has.na see for each variable if it "has NA(s)" or "has no NAs".  
#' Defaults to FALSE, which means, reporting if a variable has (any) NAs.
#'
#' @returns a dataframe reporting each variable, its unique values and NAs
#' @export
#'
#' @examples
#' # generate an example dataframe
#' df_no_na <- data.frame(x = 1, # 1 unique value
#' y = 1:10, # 10 unique values 
#' char = sample(LETTERS[1:3], 10, replace = TRUE)) # max 3 unique values
#' summ_unique(df_no_na) 
#' # add row with NAs
#' row <- c(NA, 10, NA)
#' df_with_NAs <- rbind.data.frame(df_no_na, row)
#' summ_unique(df_with_NAs)
#' summ_unique(df_with_NAs, has.na = TRUE)  # show if cols have NAs
#' 
summ_unique  <- function(df, has.na = FALSE) {
  # 1. Count unique values including NA
  # (length(unique(x)) naturally counts NA as a distinct value)
  n_unique_incl_NA <- sapply(df, function(x) length(unique(x)))
  
  # 2. Count unique values excluding NA
  n_unique_wo_NA <- sapply(df, function(x) {
    x_clean <- x[!is.na(x)]
    length(unique(x_clean))
  })
  
  # 3. Combine into a base R data frame
  res <- data.frame(
    column = names(df),
    n_unique_incl_NA = n_unique_incl_NA,
    n_unique_wo_NA = n_unique_wo_NA,
    row.names = NULL  # Resets the row names to numbers
  )
  
  # 4. Add the boolean NA indicator column
  
  if (has.na == FALSE) {
    res$no_NAs <- res$n_unique_incl_NA == res$n_unique_wo_NA
  } else {
    res$has_NAs <- res$n_unique_incl_NA != res$n_unique_wo_NA
  }
  return(res)
}


#' @rdname summ_unique
#' @export
summarise_unique <- summ_unique


