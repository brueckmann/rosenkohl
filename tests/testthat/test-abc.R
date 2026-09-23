test_that("abc() alphabetises a string", {
  expect_equal(abc("b,a", format_output = TRUE), c("a", "b"))
})

c( "b", "a")

test_that("abc()'s alias also alphabetises a string", {
  expect_equal(alphabetise(c( "b", "a"), format_output = "inline"), c("a", "b"))
})

test_that("abc()'s US alias also works", {
  expect_equal(alphabetize(c( "b", "a"), format_output = "inline"), c("a", "b"))
})