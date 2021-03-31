context("test-cpp")

test_that("get_index", {
  x <- c(0, 1, 2, 3)

  expect_equal(get_index(x, index = 0, offset = 0), 0)
  expect_equal(get_index(x, index = 1, offset = 0), 1)
  expect_equal(get_index(x, index = 2, offset = 0), 2)
  expect_equal(get_index(x, index = 3, offset = 0), 3)

  expect_equal(get_index(x, index = 0, offset = 1), 1)
  expect_equal(get_index(x, index = 1, offset = 1), 2)
  expect_equal(get_index(x, index = 2, offset = 1), 3)
  expect_equal(get_index(x, index = 3, offset = 1), 0)

  expect_equal(get_index(x, index = 0, offset = 2), 2)
  expect_equal(get_index(x, index = 1, offset = 2), 3)
  expect_equal(get_index(x, index = 2, offset = 2), 0)
  expect_equal(get_index(x, index = 3, offset = 2), 1)
})

test_that("cosine_similarity", {
  x <- c(12, 25, -40, 20, 49)
  y <- c(-40, 30, 10, 5, -30)

  expect_equal(
    cosine_similarity_cpp(x, y, offset = 0), # <-- C++ version
    cosine_similarity(x, y), # <-- R version
  )

  expect_equal(
    cosine_similarity_cpp(x, y, offset = 1),
    cosine_similarity(x[c(2:5, 1)], y),
  )

  expect_equal(
    cosine_similarity_cpp(x, y, offset = 2),
    cosine_similarity(x[c(3:5, 1:2)], y),
  )

  expect_equal(
    cosine_similarity_cpp(x, y, offset = 3),
    cosine_similarity(x[c(4:5, 1:3)], y),
  )
})

test_that("sweep_template", {
  x <- c(-5, 20, 15, 35, 40, 20)
  y <- c(20, 15, 27, 40, 10, 15)

  expect_equal(
    sweep_template(x, y, legacy = TRUE),
    sweep_template_cpp(x, y)
  )
})
