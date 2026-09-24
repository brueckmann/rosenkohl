#' lazysave
#'
#' @param x an object, usually a dataframe to be saved
#' @param dir path where you want to save
#' @param date TRUE appends the date, similar to `add_date()`
#' @param datesep a character string, can be set to empty, between name and date
#' @param extension either ".rds" (default) or ".Rdata" 
#' @param quiet TRUE doesn't show success message
#'
#' @returns a file saved on disk
#' @export
#'
#' @examples
#' lazysave(df, date=TRUE, datesep = "")
lazysave <- function(x, dir = tempdir(), date = FALSE, datesep = "_" , extension = "rds" , quiet = FALSE) {
  # turns the unevaluated argument into the corresponding string
  dataframe <- deparse(substitute(x))
  # how to output the directory
  if(dir==tempdir()){
   dirreturn <- "`tempdir`"
 } else {
   dirreturn <- substitute(dir)
 }
   # make extension correct
  ext <- tolower(extension) # lower-case them all
  if (length(grep("\\.", ext))==1) {  # is there a dot in the name?
    ext <- gsub("\\.", "", ext) # remove all dots
  }
  ext <- gsub("^", ".", ext)
  if (ext == ".rdata") { 
    ext <- ".RData"
  }
  if(ext != ".rds" & ext != ".RData" ){
    stop("Not saved! Currently only RData supported besides rds!", call. = FALSE)
  } 
  # create directory if it does not exist yet
  if (!dir.exists(dir)) {
    dir.create(dir, recursive = TRUE)
  }
  if (date == FALSE) {
    name <- paste0(dataframe, ext)
  } else {
    name <- paste0(dataframe, datesep, gsub("-","_", Sys.Date()), ext) 
  }
  if (ext == ".rds") {
    saveRDS(x, file = file.path(dir, name))
  } else {
    save(list = dataframe, file = file.path(dir, name), envir = parent.frame())
  }
  if (quiet == FALSE) {
  message(paste0("Success!", 
                 dataframe," as " , name, " saved to " , dirreturn ,
                 " (", dir, ")."
                 )
          )
  }  
}

