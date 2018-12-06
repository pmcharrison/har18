#' @export
peak <- function(x, ...) {
  UseMethod("peak")
}

#' @export
peak.pc_smooth_spectrum <- function(x, ...) {
  max(as.numeric(x))
}

#' @export
kl_div_from_uniform <- function(x, ...) {
  UseMethod("kl_div_from_uniform")
}

#' @export
kl_div_from_uniform.pc_smooth_spectrum <- function(x, ...) {
  # Construct a probability vector, where each bin corresponds to
  # the probability of a discrete event
  x <- as.numeric(x)
  probs <- x / sum(x)
  n <- length(probs)
  uniform_probs <- 1 / n
  non_zero_probs <- probs[probs > 0]
  sum(
    non_zero_probs * log(non_zero_probs / uniform_probs, base = 2)
  )
}
