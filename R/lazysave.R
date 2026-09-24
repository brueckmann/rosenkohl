lazysave <- function(x, dir = tempdir(), date = FALSE, datesep = "_" , extension = "rds") {
  # turns the unevaluated argument into the corresponding string
  name <- deparse(substitute(x))
  # make extension correct
  ext <- tolower(extension) #lower-case them all
  if (length(grep("\\.", ext))==1) {  ## if there is a dot , remove it 
    ext <- gsub("\\.", "", ext)
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
  if (ext == ".rds") {
    if (date == FALSE) {
      saveRDS(x, file = file.path(dir, paste0(name, ".rds")))
    } else {
      saveRDS(x, file = file.path(dir, paste0(name, datesep, gsub("-","_", Sys.Date()), ".rds")))
    }
  } else {
    if (date == FALSE) {
      save(list = name, file = file.path(dir, paste0(name, ext)), envir = parent.frame())
    } else {
      save(list = name, file = file.path(dir, paste0(name, datesep, gsub("-","_", Sys.Date()), ext)), envir = parent.frame())
    }
    }
  message( paste0(name, " saved to " , dir, " as " , ext)  )
  }

