#' @export
pc_harmonicity <- function(x,
                           method = "kl",
                           num_harmonics = 12,
                           rho = 0.75,
                           sigma = 6.83,
                           array_dim = 1200,
                           ...) {
  UseMethod("pc_harmonicity")
}

#' @export
pc_harmonicity.default <- function(x, ...) {
  pc_harmonicity(hrep::pc_set(x), ...)
}

#' @export
pc_harmonicity.pc_set <- function(x,
                                  method = "kl",
                                  num_harmonics = 12,
                                  rho = 0.75,
                                  sigma = 6.83,
                                  array_dim = 1200,
                                  ...) {
  checkmate::qassert(method, "S1")

  x <- hrep::pc_milne_spectrum(x,
                                num_harmonics = num_harmonics,
                                rho = rho,
                                sigma = sigma,
                                array_dim = array_dim,
                                ...)
  pc_harmonicity(x,
                 method = method,
                 num_harmonics = num_harmonics,
                 rho = rho,
                 sigma = sigma)
}

#' @export
pc_harmonicity.pc_milne_spectrum <- function(x,
                                              method = "kl",
                                              num_harmonics = 12,
                                              rho = 0.75,
                                              sigma = 6.83,
                                              ...) {
  checkmate::qassert(method, "S1")

  y <- sweep_harmonic_template(x,
                               num_harmonics = num_harmonics,
                               rho = rho,
                               sigma = sigma)
  if (method == "kl") {
    kl_div_from_uniform(y)
  } else if (method == "peak") {
    peak(y)
  } else stop("unrecognised method")
}
