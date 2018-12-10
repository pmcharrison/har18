context("test-kl_div_from_uniform")

library(hrep)
library(magrittr)

test_that("example output", {
  spec <- c(0.2, 0.4, 0.3, 0.1) %>% .pc_milne_spectrum()
  unif <- 1 / length(spec)
  d <- 0
  for (i in seq_along(spec)) {
    d <- d + spec[i] * log(spec[i] / unif, base = 2)
  }
  expect_equal(
    d, kl_div_from_uniform(spec)
  )
})

test_that("invariance to the number of bins", {
  v1 <- c(0.2, 0.4, 0.3, 0.1)
  v2 <- rep(v1, each = 2)
  s1 <- .pc_milne_spectrum(v1)
  s2 <- .pc_milne_spectrum(v2)
  expect_equal(
    kl_div_from_uniform(s1),
    kl_div_from_uniform(s2)
  )
})

test_that("invariance to magnitude", {
  v1 <- c(0.2, 0.4, 0.3, 0.1)
  v2 <- v1 * 2
  s1 <- .pc_milne_spectrum(v1)
  s2 <- .pc_milne_spectrum(v2)
  expect_equal(
    kl_div_from_uniform(s1),
    kl_div_from_uniform(s2)
  )
})

test_that("Peak measure produces different patterns to KL measure", {
  organised_sub_peaks <- c(0, 0, 3, 0, 0, 5, 0, 0, 0, 0) %>% .pc_milne_spectrum()
  disorganised_sub_peaks <- c(1, 1, 1, 0, 0, 5, 0, 0, 0, 0) %>% .pc_milne_spectrum()
  expect_equal(
    peak(organised_sub_peaks),
    peak(disorganised_sub_peaks)
  )
  expect_gt(
    kl_div_from_uniform(organised_sub_peaks),
    kl_div_from_uniform(disorganised_sub_peaks)
  )
})
