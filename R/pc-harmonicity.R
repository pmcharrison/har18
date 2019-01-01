#' Pitch-class harmonicity
#'
#' Gets the pitch-class harmonicity of an input sonority, after
#' \insertCite{Harrison2018;textual}{har18} and
#' \insertCite{Milne2013;textual}{har18}.
#' @param x Object to analyse.
#' @param method (Character scalar) Method to use.
#' * \code{"kl"} (default) delivers the Kullback-Leibler method of
#' \insertCite{Harrison2018;textual}{har18}.
#' * \code{"peak"} delivers the peak-value method of
#' \insertCite{Milne2013;textual}{har18}.
#' @param num_harmonics (Integerish scalar)
#' Number of harmonics to use when expanding tones into their implied harmonics,
#' and when defining the harmonic template
#' (including the fundamental frequency).
#' Defaults to 12, after
#' \insertCite{Milne2016;textual}{har18}.
#' @param rho (Numeric scalar)
#' Roll-off parameter for harmonic expansion.
#' Defaults to 0.75, after
#' \insertCite{Milne2016;textual}{har18}.
#' @param sigma (Numeric scalar)
#' Standard deviation of the Gaussian smoothing distribution (cents).
#' Defaults to 6.83, after
#' \insertCite{Milne2016;textual}{har18}.
#' @param array_dim (Integerish scalar)
#' Dimensionality of the pitch-class spectrum array.
#' Defaults to 1200, after
#' \insertCite{Milne2016;textual}{har18}.
#' @param ... Arguments passed to specific methods.
#' @return Pitch-class harmonicity, as a numeric scalar.
#' @note This algorithm makes use of \code{\link[hrep]{milne_pc_spectrum}()}
#' as defined in the \code{hrep} package.
#' @md
#' @references
#' \insertAllCited{}
#' @examples
#' pc_harmonicity(c(0, 4, 7))
#' pc_harmonicity(c(0, 3, 7))
#' pc_harmonicity(c(0, 3, 6))
#' @rdname pc_harmonicity
#' @export
pc_harmonicity <- function(x,
                           method = "kl",
                           num_harmonics = 12,
                           rho = 0.75,
                           sigma = 6.83,
                           ...) {
  UseMethod("pc_harmonicity")
}

#' @rdname pc_harmonicity
#' @export
pc_harmonicity.default <- function(x,
                                   method = "kl",
                                   num_harmonics = 12,
                                   rho = 0.75,
                                   sigma = 6.83,
                                   array_dim = 1200,
                                   ...) {
  x <- hrep::pc_set(x)
  do.call(pc_harmonicity, as.list(environment()))
}

#' @rdname pc_harmonicity
#' @export
pc_harmonicity.pc_set <- function(x,
                                  method = "kl",
                                  num_harmonics = 12,
                                  rho = 0.75,
                                  sigma = 6.83,
                                  array_dim = 1200,
                                  ...) {
  checkmate::qassert(method, "S1")

  x <- hrep::milne_pc_spectrum(x,
                               num_harmonics = num_harmonics,
                               rho = rho,
                               sigma = sigma,
                               array_dim = array_dim)
  pc_harmonicity(x,
                 method = method,
                 num_harmonics = num_harmonics,
                 rho = rho,
                 sigma = sigma)
}

#' @rdname pc_harmonicity
#' @export
pc_harmonicity.milne_pc_spectrum <- function(x,
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
