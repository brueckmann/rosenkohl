test_that("add_date adds the date to nothing if asked for", {
  expect_equal(gsub("_", "-", add_date("", "")) , as.character(Sys.Date()))
})


test_that("add_date adds date before the last dot", {
  expect_equal(add_date("d.o.t.s", "."), 
               paste0("d.o.t.", 
                gsub("-","_", Sys.Date()),
                ".s"
               )
  )
})

