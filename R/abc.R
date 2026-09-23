#' abc sort anything alphabetically function
#'
#' @param text A character vector with multiple entries or with comma separated text
#' @param format_output TRUE returns a character vector, FALSE returns ordered elements, inline returns text
#'
#' @returns A character vector.
#' @export
#'
#' @examples
#'  x <- "charlie,delta,alpha,bravo"
#'  abc(x, format_output = TRUE)
#'  abc(x, format_output = FALSE)
#'  abc(x, format_output = "inline")
#'
abc <- function(text, format_output = TRUE) {

  # Sorting
  if (length(text) > 1) {# Sorting for character vector type of texts
    sorted <- sort(text)
  } else { # Sorting for comma separated text without "" around words
    sorted <- sort(trimws(strsplit(text, ",")[[1]]))
  }

  # Format output
  if (format_output == TRUE) {
    items <- paste0('"', sorted, '"', collapse = ",\n")
    cat(paste0("c(", items, ")"))
    invisible(sorted)
  } else if (format_output == "inline") {
    cat(paste(sorted, collapse = ", "))
    invisible(sorted)
  } else {
    return(sorted)
  }
}

#' @rdname abc
#' @export
alphabetise <- abc

#' @rdname abc
#' @export
alphabetize <- abc
