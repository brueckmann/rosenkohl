test_that("abc() alphabetises a string", {
  expect_equal(abc("b,a", format_output = TRUE), c("a", "b"))
})

test_that("abc()'s british english alias also works", {
  expect_equal(alphabetise(c("b", "a"), format_output = FALSE), c("a", "b"))
})

test_that("abc()'s US alias also works", {
  text <- "Espace Mittelland  , Nordwestschweiz     ,   Ostschweiz  , Région lémanique      ,      Ticino  ,  Zentralschweiz           , Zürich"
  expect_equal(
    alphabetize(text, format_output = "inline"),
    c(
      "Espace Mittelland",
      "Nordwestschweiz",
      "Ostschweiz",
      "Région lémanique",
      "Ticino",
      "Zentralschweiz",
      "Zürich"
    )
  )
})
