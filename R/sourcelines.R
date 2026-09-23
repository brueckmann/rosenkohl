



#' sourcelines
#'
#' @param file character string with the path to the file to source.
#' @param lines numeric vector of lines to source in \code{file}.
#' @param echoset logical; TRUE prints expressions after parse before eval.
#'
#' @returns invisibly returns a list (just like source())
#' @export
#'
#' @examples
#'  # Create a file to source it -----------------------------------------------
#' inputfile <-  tempfile(fileext = ".R")
#' # write 3 lines in the file
#' writeLines(text = "1+0 \n 2+0 \n 3+0", con = inputfile)
#' # source whole file loudly
#' # Using sourcelines ---------------------------------------------------------
#' # source only the first line 
#' sourcelines(inputfile, 1, TRUE)
#' # source only second and third line
#' sourcelines(inputfile, 2:3, TRUE)
#' # source only first and third till (non-existing fourth) line
#' sourcelines(inputfile, c(1, 3:4), TRUE)


sourcelines <- function(file, lines, echoset=FALSE){
  source(textConnection(readLines(file)[(lines)]), echo = echoset)
}

