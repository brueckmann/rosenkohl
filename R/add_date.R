#' add_date wrapper
#'
#' @param x a character string often a (file) name
#' @param sep a character string, can be set to empty 
#'
#' @returns a character string with today's date
#' @export
#'
#' @examples
#' add_date("file.R", "-")

add_date <- function(x, sep = "_"){
  name <- sub("\\.[^.]*$", "", x)
  if (length(grep("\\.", x))==1) {
    extension <- sub("^.*(\\.[^.]*)$", "\\1", x)
  } else { 
            if (x =="."){
              extension <- "." # decide that if there is only a dot, put it after the date
            } else {
    extension <- ""
            }
  }
  paste0(name, sep, gsub("-","_", Sys.Date()), extension)
}

