#' Peak
#'
#' Gets the peak value of an object.
#' @param x Object to analyse.
#' @return The object's peak value, as a numeric scalar.
#' @rdname peak
#' @export
peak <- function(x) {
  UseMethod("peak")
}

#' @rdname peak
#' @export
peak.pc_milne_spectrum <- function(x) {
  max(as.numeric(x))
}

#' Kullback-Leibler divergence from uniform
#'
#' Gets the Kullback-Leibler divergence of a provided distribution
#' from a uniform distribution.
#' @param x Input distribution.
#' @return The Kullback-Leibler divergence from a uniform distribution
#' to the input distribution.
#' @rdname kl_div_from_uniform
#' @export
kl_div_from_uniform <- function(x) {
  UseMethod("kl_div_from_uniform")
}

#' @rdname kl_div_from_uniform
#' @export
kl_div_from_uniform.pc_milne_spectrum <- function(x) {
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
