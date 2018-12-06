context("test-peak")

library(hrep)
library(magrittr)

test_that("example", {
  c(0, 0, 3, 4, 1) %>%
    .pc_smooth_spectrum() %>%
    peak %>%
    expect_equal(4)
})

test_that("invariance to doubling the number of bins", {
  for (i in 1:10) {
    spec1 <- rnorm(10) %>% .pc_smooth_spectrum()
    spec2 <- rep(as.numeric(spec1), each = 2) %>% .pc_smooth_spectrum()
    expect_equal(
      peak(spec1),
      peak(spec2)
    )
  }
})

test_that("more pointy distributions get higher peaks", {
  x <- seq(from = -100, to = 100)
  pointy <- dnorm(x, sd = 1)
  less_pointy <- dnorm(x, sd = 4)
  expect_gt(
    peak(.pc_smooth_spectrum(pointy)),
    peak(.pc_smooth_spectrum(less_pointy))
  )
})
