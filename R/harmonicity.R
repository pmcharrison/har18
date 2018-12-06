#' @export
harmonicity <- function(x,
                        method = "kl",
                        type = "pc",
                        num_harmonics = 12,
                        rho = 0.75,
                        sigma = 6.83,
                        array_dim = 1200) {
  UseMethod("harmonicity")
}

#' @export
harmonicity.default <- function(x, type = "pc", ...) {
  x <- if (type == "pc") {
    pc_set(x)
  } else if (type == "pi") {
    stop("pitch-based harmonicity is not currently supported")
    pi_chord(x)
  } else {
    stop("unrecognised type")
  }
  harmonicity(x, type = type, ...)
}

#' @export
harmonicity.pc_set <- function(x,
                               method = "kl",
                               type = "pc",
                               num_harmonics = 12,
                               rho = 0.75,
                               sigma = 6.83,
                               array_dim = 1200,
                               ...) {
  checkmate::qassert(method, "S1")
  checkmate::qassert(type, "S1")

  x <- hrep::pc_smooth_spectrum(x,
                                num_harmonics = num_harmonics,
                                rho = rho,
                                sigma = sigma,
                                array_dim = array_dim)
  harmonicity(x,
              method = method,
              type = type,
              num_harmonics = num_harmonics,
              rho = rho,
              sigma = sigma)
}

#' @export
harmonicity.pc_smooth_spectrum <- function(x,
                                           method = "kl",
                                           type = "pc",
                                           num_harmonics = 12,
                                           rho = 0.75,
                                           sigma = 6.83) {
  checkmate::qassert(method, "S1")
  checkmate::qassert(type, "S1")

  # One day we could generalise the method from pitch classes to pitches.
  # This is not implemented yet, though.
  stopifnot(type == "pc")

  virtual <- sweep_harmonic_template(x,
                                     num_harmonics = num_harmonics,
                                     rho = rho,
                                     sigma = sigma,
                                     array_dim = array_dim)
  if (method == "kl") {
    kl_div_from_uniform(virtual)
  } else if (method == "peak") {
    peak(virtual)
  } else stop("unrecognised method")
}
