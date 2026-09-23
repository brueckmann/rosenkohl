#' sourcelines.R
#' Source specific lines in an R file (from https://gist.github.com/christophergandrud/1eb4e095974204b12af9#file-source_lines-r)
#'
#' @param file character string with the path to the file to source.
#' @param lines numeric vector of lines to source in \code{file}.

sourcelines <- function(file, lines){
  source(textConnection(readLines(file)[lines]))
}
