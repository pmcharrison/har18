#' Sweep harmonic template
#'
#' Sweeps a harmonic template over an input spectrum.
#' @param x Object to analyse.
#' @param num_harmonics See \code{\link{pc_harmonicity}}.
#' @param rho See \code{\link{pc_harmonicity}}.
#' @param sigma See \code{\link{pc_harmonicity}}.
#' @param array_dim See \code{\link{pc_harmonicity}}.
#' @param ... Arguments passed to specific methods.
#' @return An object of class \code{\link[hrep]{milne_pc_spectrum}},
#' identifying each pitch class with a perceptual weight
#' corresponding to its harmonic template fit.
#' @rdname sweep_harmonic_template
#' @export
sweep_harmonic_template <- function(x,
                                    num_harmonics = 12,
                                    rho = 0.75,
                                    sigma = 6.83,
                                    array_dim = 1200,
                                    ...) {
  UseMethod("sweep_harmonic_template")
}

#' @rdname sweep_harmonic_template
#' @export
sweep_harmonic_template.pc_set <- function(x,
                                           num_harmonics = 12,
                                           rho = 0.75,
                                           sigma = 6.83,
                                           array_dim = 1200,
                                           ...) {
  hrep::milne_pc_spectrum(x,
                          num_harmonics = num_harmonics,
                          rho = rho,
                          sigma = sigma,
                          array_dim = array_dim) %>%
    sweep_harmonic_template(num_harmonics = num_harmonics,
                            rho = rho,
                            sigma = sigma)
}

#' @rdname sweep_harmonic_template
#' @export
sweep_harmonic_template.milne_pc_spectrum <- function(x,
                                                      num_harmonics = 12,
                                                      rho = 0.75,
                                                      sigma = 6.83,
                                                      ...) {
  x <- as.numeric(x)
  array_dim <- length(x)
  template <- hrep::milne_pc_spectrum(hrep::pc_set(0),
                                      array_dim = array_dim,
                                      num_harmonics = num_harmonics,
                                      rho = rho,
                                      sigma = sigma)
  res <- sweep_template(x, template)

  hrep::.milne_pc_spectrum(res)
}

#' Sweep template
#'
#' Sweeps a circular template over a circular vector
#' and computes the cosine similarity at each possible offset.
#'
#' @param x
#' (Numeric vector)
#' The vector to be swept over.
#'
#' @param template
#' (Numeric vector)
#' The template to sweep over \code{x}.
#' Should have the same dimensionality as \code{x}.
#'
#' @param legacy
#' (Logical scalar)
#' Whether to use the legacy R implementation
#' (default = \code{FALSE}).
#' Otherwise the faster C++ implementation is used.
#'
#' @export
sweep_template <- function(x, template, legacy = FALSE) {
  if (!legacy) {
    return(sweep_template_cpp(x, template))
  }

  array_dim <- length(x)
  res <- numeric(array_dim)

  for (i in seq_len(array_dim)) {
    indices <- 1 + (seq(from = i - 1, length.out = array_dim) %% array_dim)
    res[i] <- cosine_similarity(template, x[indices])
  }

  res
}
