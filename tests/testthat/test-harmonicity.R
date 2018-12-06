context("test-harmonicity")

library(hrep)
library(magrittr)

test_that("Legacy comparisons with HarmonyStats package", {
  pc_set_ids <- c(1, 100, 300, 500, 650, 800, 900, 1000, 1200, 1500)
  pc_sets <- pc_set_ids %>% decode("pc_set") %>% as.list
  pc_set_sizes <- vapply(pc_sets, length, integer(1))

  # The following commented out code was used to generate the
  # reference vector.

  # library(tidyverse)
  # x <- unclass(readRDS("/Users/peter/Dropbox/Academic/projects/pearce-marcus/harmony/HarmonyStats/inst/extdata/feature_cache.rds"))
  # scale_info <- attr(x, "scale_info")$instantaneous %>% filter(measure == "harmonicity")
  #
  # ref <- tibble(pc_set_id = pc_set_ids,
  #               size = pc_set_sizes,
  #               scaled_harmonicity = x@data$`NA`["harmonicity", pc_set_ids],
  #               center = scale_info$center[size],
  #               scale = scale_info$scale[size],
  #               harmonicity = scaled_harmonicity * scale + center) %>%
  #   pull(harmonicity)
  # dump("ref", file = "")

  ref <-
    c(1.56025992760304, 0.763094086276816, 0.699233982570559, 0.525533347758732,
      0.649556486732275, 0.763094086276816, 0.774127828829956, 0.525533347758732,
      0.699233982570559, 0.552087654180455)

  expect_equal(ref,
               pc_sets %>% vapply(pc_harmonicity, numeric(1)))
})
