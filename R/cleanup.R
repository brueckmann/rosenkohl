
#' Remove objects whose names match a pattern 
#'
#' To remove temporary objects (usually named "temp_" or "_temp") 
#' 
#' @param pattern What shall be searched for.
#' @param envir usually the GlobalEnvironment
#' @param keep.functions TRUE if you do not want to remove temporary functions
#' @param verbose gives feedback or none 
#'
#' @returns empty character string 
#' @export
#'
#' @examples
#' cleanup()
#' # More detailed examples
#' ## Create some noise. 
#' ### create things to be kept
#' temptation_to_keep <- data.frame(x = 1, 
#'                          y = 1:10, 
#'                          char = sample(LETTERS[1:3], 10, replace = TRUE))
#' url_to_keep <- "https://www.nothing_temp.csv"
#' ### create things to be deleted: 
#' list_temp <- c(char = sample(LETTERS[1:3], 10, replace = TRUE))
#' temp_url <- "https://raw.githubusercontent.com/tidyverse/dplyr/main/data-raw/starwars.csv"
#' temp_dir <- file.path(tempdir(), "demo")
#' #### define a temp function
#' temp_function <- function(x) {
#' x + 1
#' }
#' ## Some noice was created.
#' # use function but turn off  verbose
#' cleanup(verbose = FALSE)
#' 
#' # use function with own pattern
#' cleanup(pattern = "_to_keep")
#' 
#' ## create another temporary list again
#' temporary_list <- c("something", "else")
#' # use function with own pattern
#' cleanup(pattern="temporary_")
#' 
#' # use function when nothing is available that matches the pattern
#' cleanup(pattern="precious")
#' 
#' # use function when nothing is available matching the pattern - but a function
#' cleanup()
#' 
#' # remove the temp-function
#' cleanup(keep.functions = FALSE)
cleanup <- function(pattern = "(_temp|temp_)", envir = .GlobalEnv, keep.functions = TRUE, verbose = TRUE) {
  # list matching objects in the target environment
  matches <- ls(envir = envir, pattern = pattern, all.names = TRUE)
  if (length(matches) == 0) {
    if (verbose) message("No objects matched pattern: ", pattern)
    return(invisible(character()))
  }
  
  # optionally remove functions from the removal list
  if (keep.functions) {
    # only attempt to mget names that actually exist (guard against promises/active bindings)
    existing <- matches[vapply(matches, function(n) exists(n, envir = envir, inherits = FALSE), logical(1))]
    if (length(existing) == 0L) {
      if (verbose) message("No existing objects matched pattern: ", pattern)
      return(invisible(character()))
    }
    
    objs <- mget(existing, envir = envir, inherits = FALSE)
    is_fun <- vapply(objs, is.function, logical(1))
    to_remove <- setdiff(matches, names(is_fun)[is_fun])
  } else {
    to_remove <- matches
  }
  
  if (length(to_remove) == 0) {
    if (verbose) message("No non-function objects to remove for pattern: ", pattern, 
                         ". Set `keep.functions = FALSE` to remove these functions.")
    return(invisible(character()))
  }
  
  # remove and report
  rm(list = to_remove, envir = envir)
  if (verbose) message("Removed ", length(to_remove), " object(s): ", paste(to_remove, collapse = ", "))
  invisible(to_remove)
}



#' @rdname cleanup
#' @export
tempex <- cleanup

#' @rdname cleanup
#' @export
temprm <- cleanup

