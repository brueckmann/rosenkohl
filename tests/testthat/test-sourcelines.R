test_that("sourcelines() sources a full document correctly", {
  # create a file to source it 
  inputfile <-  tempfile(fileext = ".R")
  # Write content to the file
  writeLines(text = "1+0 \n 2+0 \n 3+0",
             con = inputfile)

  expect_identical(sourcelines(inputfile, c(1:3), FALSE), source(inputfile, echo = FALSE))
})


test_that("sourcelines() sources the first line correctly when echo is on", {
  # create a file to source it 
  inputfile <-  tempfile(fileext = ".R")
  # Write content to the file
  writeLines(text = "1+0 \n 2+0 \n 3+0",
             con = inputfile)
  # create a file to source it 
  firstlinefile <-  tempfile(fileext = ".R")  
  writeLines(text = "1+0",
             con = firstlinefile)
  
  expect_identical(sourcelines(inputfile, 1, TRUE), source(firstlinefile, echo = TRUE))
})

test_that("sourcelines() sources two lines correctly", {
  # create a file to source it 
  inputfile <-  tempfile(fileext = ".R")
  # Write content to the file
  writeLines(text = "1+0 \n 2+0 \n 3+0",
             con = inputfile)
  # create a file to source it 
  firstandlastlinefile <-  tempfile(fileext = ".R")  
  writeLines(text = "1+0 \n 3+0",
             con = firstandlastlinefile)
  expect_identical(sourcelines(inputfile, c(1,3), FALSE), source(firstandlastlinefile, echo = FALSE))
})


