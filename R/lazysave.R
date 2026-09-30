#' save stuff with date lazily
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
#' # More detailed examples
#' # create a dataframe called data 
#' data <- data.frame(x = 1, 
#' y = 1:10, 
#' char = sample(LETTERS[1:3], 10, replace = TRUE)) 
#' # create temp folder with a subfolder
#' # define your path
#' temp <- file.path(tempdir(), "demo")
#' # remove everything in temp
#' unlink(temp, recursive = TRUE)   
#' # create directory 
#' dir.create(temp)
#' 
#' 
#' lazysave(data)
#' list.files(temp) # still empty, as default path out is tempdir.
#' 
#' # you may append the date to the filename
#' lazysave(data, dir = temp, date=TRUE, datesep = "", extension = "rdata")
#' # return file names 
#' list.files(temp) # file saved.
#' 
#' # lazysave() doesn't mind dot(s) in extensions  (but rds is the default)
#' lazysave(data, dir = temp, date=TRUE, datesep = "-", extension = ".r.ds.")
#' # lazysave() doesn't mind capitalisation or not in extension
#' lazysave(data, dir = temp, extension = "RDATA")

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
  message(paste0("Success! ", 
                 dataframe," as " , name, " saved to " , dirreturn ,
                 " (", dir, ")."
                 )
          )
  }  
}

