save_rds <- function(x, dir = tempdir(), date = FALSE, datesep = "_") {
  # turns the unevaluated argument into the corresponding string
  name <- deparse(substitute(x))
  # create directory if it does not exist yet
  if (!dir.exists(dir)) {
    dir.create(dir, recursive = TRUE)
  }
  if (date == FALSE) {
    saveRDS(x, file = file.path(dir, paste0(name, ".rds")))
  } else {
    saveRDS(x, file = file.path(dir, paste0(name, datesep, gsub("-","_", Sys.Date()), ".rds")))
  }
}